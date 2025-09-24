import 'package:stream_transform/stream_transform.dart';

import 'index.dart';

const kMaxChatCacheSize = 5;

DocumentReference? get currentUserReference =>
    currentUserDocument?.reference; // عرف هنا current user

class FFChatInfo {
  const FFChatInfo(this.chatRecord, [this.groupMembers]);
  final ChatsRecord chatRecord;
  final List<UsersRecord>? groupMembers;

  UsersRecord get currentUser => groupMembers!
      .firstWhere((user) => user.reference == currentUserReference);

  Map<String, UsersRecord> get otherUsers => Map.fromEntries(
    groupMembers!
        .where((user) => user.reference != currentUserReference)
        .map((user) => MapEntry(user.reference.id, user)),
  );

  List<UsersRecord> get otherUsersList => otherUsers.values.toList();
  bool get isGroupChat => otherUsers.length > 1;

  String chatPreviewTitle() {
    if (groupMembers == null) return '';
    final numOthers = chatRecord.users.length - otherUsersList.length - 1;
    return otherUsersList
        .map((m) => m.displayName.isNotEmpty == true ? m.displayName : 'Friend')
        .join(', ') +
        (numOthers > 0
            ? ' + $numOthers other${numOthers > 1 ? 's' : ''}'
            : '');
  }

  String chatPreviewMessage() {
    final userSentLastMessage = chatRecord.lastMessageSentBy == currentUserReference;
    var lastChatText = chatRecord.lastMessage;
    if (userSentLastMessage && lastChatText.isNotEmpty) {
      lastChatText = 'You: $lastChatText';
    }
    return lastChatText;
  }

  String chatPreviewPic() {
    if (groupMembers == null || otherUsersList.isEmpty) return '';
    final userSentLastMessage = chatRecord.lastMessageSentBy == currentUserReference;
    final chatUser = userSentLastMessage
        ? otherUsersList.first
        : otherUsersList.firstWhere(
          (m) => m.reference == chatRecord.lastMessageSentBy,
      orElse: () => otherUsersList.first,
    );
    return chatUser.photoUrl ;
  }
}

class FFChatManager {
  FFChatManager._();

  static Map<String, Stream<List<ChatMessagesRecord>>> _chatMessages = {};
  static Map<String, List<ChatMessagesRecord>> _chatMessagesCache = {};
  static Map<String, DocumentReference> _userChats = {};
  static DocumentReference? _currentUser;

  static FFChatManager? _instance;
  static FFChatManager get instance => _instance ??= FFChatManager.instance;

  Stream<List<ChatMessagesRecord>> getChatMessages(DocumentReference chatReference) {
    final chatId = chatReference.id;

    if (!_chatMessages.containsKey(chatId) && _chatMessages.length >= kMaxChatCacheSize) {
      final firstKey = _chatMessages.keys.first;
      _chatMessages.remove(firstKey);
      _chatMessagesCache.remove(firstKey);
    }

    _chatMessages[chatId] ??= queryChatMessagesRecord(
      queryBuilder: (q) => q.where('chat', isEqualTo: chatReference).orderBy('timestamp', descending: true),
      limit: 30,
    );

    return _chatMessages[chatId]!;
  }

  void setLatestMessages(DocumentReference chatReference, List<ChatMessagesRecord> messages) =>
      _chatMessagesCache[chatReference.id] = messages;

  List<ChatMessagesRecord> getLatestMessages(DocumentReference chatReference) =>
      _chatMessagesCache[chatReference.id] ?? [];

  DocumentReference getChatUserRef(ChatsRecord chat) {
    final userRef = chat.users.firstWhere((d) => d.path != currentUserReference?.path);
    _userChats[userRef.id] = chat.reference;
    return userRef;
  }

  Stream<FFChatInfo> getChatInfo({
    UsersRecord? otherUserRecord,
    DocumentReference? chatReference,
    ChatsRecord? chatRecord,
  }) {
    assert(
    (otherUserRecord != null || chatReference != null) ^ (chatRecord != null),
    'Specify exactly one of otherUserRecord / chatReference / chatRecord',
    );

    Stream<ChatsRecord> chatStream = chatRecord != null
        ? Stream.value(chatRecord)
        : Stream.value(chatReference)
        .asyncMap((ref) async => ref ?? await _getChatReference(otherUserRecord!.reference))
        .switchMap((ref) => Stream.fromFuture(ChatsRecord.getDocument(ref) as Future<ChatsRecord>));

    return chatStream.asyncMap((chat) async {
      var userRefs = chat.users.toSet();
      if (chatRecord != null) {
        final userAndSender = {
          currentUserReference!,
          if (chat.lastMessageSentBy != null) chat.lastMessageSentBy!
        };
        userRefs = {
          ...userAndSender,
          ...(userRefs.toSet()..removeAll(userAndSender)).take(3),
        };
      }
      final groupMembers = await Future.wait(userRefs.map((ref) => UsersRecord.getDocument(ref).first));
      return FFChatInfo(chat, groupMembers);
    });
  }

  Future<DocumentReference> _getChatReference(DocumentReference otherUser) async {
    if (_currentUser != currentUserReference) {
      _userChats.clear();
      _currentUser = currentUserReference;
    }

    var chatRef = _userChats[otherUser.id];
    if (chatRef != null) return chatRef;

    final users = [otherUser, currentUserReference!];
    users.sort((a, b) => a.id.compareTo(b.id));

    final chat = await queryChatsRecord(
      queryBuilder: (q) => q
          .where('user_a', isEqualTo: users.first)
          .where('user_b', isEqualTo: users.last)
          .where('users', arrayContains: currentUserReference),
      singleRecord: true,
    ).first;

    if (chat.isNotEmpty) {
      _userChats[otherUser.id] = chat.first.reference;
      return chat.first.reference;
    }

    chatRef = _userChats[otherUser.id];
    if (chatRef != null) {
      await Future.delayed(Duration(seconds: 1));
      return chatRef;
    }

    chatRef = ChatsRecord.collection.doc();
    _userChats[otherUser.id] = chatRef;
    await chatRef.set({
      ...createChatsRecordData(userA: users.first, userB: users.last),
      'users': users,
    });
    return chatRef;
  }

  Future<ChatsRecord?> createChat(List<DocumentReference> otherUsers) async {
    final users = {currentUserReference!, ...otherUsers};
    if (users.length < 3) return null;

    final chatRef = ChatsRecord.collection.doc();
    final chatData = {'users': users.toList()};
    await chatRef.set(chatData);
    return ChatsRecord.getDocumentFromData(chatData, chatRef);
  }

  Future<ChatsRecord?> addGroupMembers(ChatsRecord? chat, List<DocumentReference> users) async {
    if (chat == null) return null;

    final newUsers = {...chat.users, ...users}.toList();
    if (chat.userA != null || chat.userB != null || users.isEmpty) return chat;

    await chat.reference.update({'users': newUsers});
    chat.users
      ..clear()
      ..addAll(newUsers);

    return chat;
  }

  Future<ChatsRecord> removeGroupMembers(ChatsRecord chat, List<DocumentReference> users) async {
    final newUsers = (chat.users.toSet()..removeAll(users)).toList();
    if (newUsers.length < 3) return chat;

    await chat.reference.update({'users': newUsers});
    chat.users
      ..clear()
      ..addAll(newUsers);

    return chat;
  }
}