import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/firebase_auth/auth_util.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'schema/util/firestore_util.dart';
import 'schema/users_record.dart';
import 'schema/chats_record.dart';
import 'schema/chat_messages_record.dart';

export 'dart:async' show StreamSubscription;
export 'package:cloud_firestore/cloud_firestore.dart';
export 'schema/index.dart';
export 'schema/util/firestore_util.dart';
export 'schema/util/schema_util.dart';
export 'schema/users_record.dart';
export 'schema/chats_record.dart';
export 'schema/chat_messages_record.dart';

typedef RecordBuilder<T> = T Function(DocumentSnapshot doc);

/// =================== COUNT ===================
Future<int> queryCollectionCount(
    Query collection, {
      Query Function(Query)? queryBuilder,
      int limit = -1,
    }) async {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0) query = query.limit(limit);

  try {
    final snapshot = await query.count().get();
    return snapshot.count ?? 0;
  } catch (e) {
    print('Error querying $collection: $e');
    return 0;
  }
}

/// =================== STREAM ===================
Stream<List<T>> queryCollection<T>(
    Query collection,
    RecordBuilder<T> recordBuilder, {
      Query Function(Query)? queryBuilder,
      int limit = -1,
      bool singleRecord = false,
    }) {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0 || singleRecord) query = query.limit(singleRecord ? 1 : limit);

  return query.snapshots().handleError((err) {
    print('Error querying $collection: $err');
  }).map((snapshot) => snapshot.docs
      .map((doc) => safeGet(() => recordBuilder(doc),
          (e) => print('Error serializing doc ${doc.reference.path}: $e')))
      .where((d) => d != null)
      .map((d) => d!)
      .toList());
}

/// =================== ONCE ===================
Future<List<T>> queryCollectionOnce<T>(
    Query collection,
    RecordBuilder<T> recordBuilder, {
      Query Function(Query)? queryBuilder,
      int limit = -1,
      bool singleRecord = false,
    }) async {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0 || singleRecord) query = query.limit(singleRecord ? 1 : limit);

  final snapshot = await query.get();
  return snapshot.docs
      .map((doc) => safeGet(() => recordBuilder(doc),
          (e) => print('Error serializing doc ${doc.reference.path}: $e')))
      .where((d) => d != null)
      .map((d) => d!)
      .toList();
}

/// =================== PAGINATION ===================
class FFFirestorePage<T> {
  final List<T> data;
  final Stream<List<T>>? dataStream;
  final DocumentSnapshot? nextPageMarker;

  FFFirestorePage(this.data, this.dataStream, this.nextPageMarker);
}

Future<FFFirestorePage<T>> queryCollectionPage<T>(
    Query collection,
    RecordBuilder<T> recordBuilder, {
      Query Function(Query)? queryBuilder,
      DocumentSnapshot? nextPageMarker,
      required int pageSize,
      required bool isStream,
    }) async {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection).limit(pageSize);
  if (nextPageMarker != null) query = query.startAfterDocument(nextPageMarker);

  Stream<QuerySnapshot>? snapshotStream;
  QuerySnapshot snapshot;

  if (isStream) {
    snapshotStream = query.snapshots();
    snapshot = await snapshotStream.first;
  } else {
    snapshot = await query.get();
  }

  final processDocs = (QuerySnapshot s) => s.docs
      .map((doc) => safeGet(() => recordBuilder(doc),
          (e) => print('Error serializing doc ${doc.reference.path}: $e')))
      .where((d) => d != null)
      .map((d) => d!)
      .toList();

  final data = processDocs(snapshot);
  final dataStream = snapshotStream?.map(processDocs);
  final nextPage = snapshot.docs.isEmpty ? null : snapshot.docs.last;

  return FFFirestorePage(data, dataStream, nextPage);
}

/// =================== EXTENSIONS ===================
extension QueryExtensions on Query {
  Query whereInSafe(String field, List? list) =>
      (list == null || list.isEmpty) ? where(field, whereIn: null) : where(field, whereIn: list);

  Query whereNotInSafe(String field, List? list) =>
      (list == null || list.isEmpty) ? where(field, whereNotIn: null) : where(field, whereNotIn: list);

  Query whereArrayContainsAnySafe(String field, List? list) =>
      (list == null || list.isEmpty) ? where(field, arrayContainsAny: null) : where(field, arrayContainsAny: list);
}

/// =================== CREATE USER ===================
Future maybeCreateUser(User user) async {
  final userRef = UsersRecord.collection.doc(user.uid);
  final exists = await userRef.get().then((u) => u.exists);

  if (exists) {
    currentUserDocument = await UsersRecord.getDocumentOnce(userRef);
    return;
  }

  final userData = createUsersRecordData(
    email: user.email,
    displayName: user.displayName,
    photoUrl: user.photoURL,
    uid: user.uid,
    phoneNumber: user.phoneNumber,
    createdTime: getCurrentTimestamp,
  );

  await userRef.set(userData);
  currentUserDocument = UsersRecord.getDocumentFromData(userData, userRef);
}

/// =================== CHAT DEDICATED QUERIES ===================
Stream<List<ChatsRecord>> queryChatsRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      ChatsRecord.collection,
      ChatsRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Stream<List<ChatMessagesRecord>> queryChatMessagesRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      ChatMessagesRecord.collection,
      ChatMessagesRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );