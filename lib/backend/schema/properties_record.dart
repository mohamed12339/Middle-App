import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PropertiesRecord extends FirestoreRecord {
  PropertiesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "propertyName" field.
  String? _propertyName;
  String get propertyName => _propertyName ?? '';
  bool hasPropertyName() => _propertyName != null;

  // "propertyDescription" field.
  String? _propertyDescription;
  String get propertyDescription => _propertyDescription ?? '';
  bool hasPropertyDescription() => _propertyDescription != null;

  // "mainImage" field.
  String? _mainImage;
  String get mainImage => _mainImage ?? '';
  bool hasMainImage() => _mainImage != null;

  // "propertyLocation" field.
  LatLng? _propertyLocation;
  LatLng? get propertyLocation => _propertyLocation;
  bool hasPropertyLocation() => _propertyLocation != null;

  // "propertyAddress" field.
  String? _propertyAddress;
  String get propertyAddress => _propertyAddress ?? '';
  bool hasPropertyAddress() => _propertyAddress != null;

  // "isDraft" field.
  bool? _isDraft;
  bool get isDraft => _isDraft ?? false;
  bool hasIsDraft() => _isDraft != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "propertyNeighborhood" field.
  String? _propertyNeighborhood;
  String get propertyNeighborhood => _propertyNeighborhood ?? '';
  bool hasPropertyNeighborhood() => _propertyNeighborhood != null;

  // "ratingSummary" field.
  double? _ratingSummary;
  double get ratingSummary => _ratingSummary ?? 0.0;
  bool hasRatingSummary() => _ratingSummary != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  bool hasPrice() => _price != null;

  // "taxRate" field.
  double? _taxRate;
  double get taxRate => _taxRate ?? 0.0;
  bool hasTaxRate() => _taxRate != null;

  // "cleaningFee" field.
  int? _cleaningFee;
  int get cleaningFee => _cleaningFee ?? 0;
  bool hasCleaningFee() => _cleaningFee != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "minNightStay" field.
  double? _minNightStay;
  double get minNightStay => _minNightStay ?? 0.0;
  bool hasMinNightStay() => _minNightStay != null;

  // "lastUpdated" field.
  DateTime? _lastUpdated;
  DateTime? get lastUpdated => _lastUpdated;
  bool hasLastUpdated() => _lastUpdated != null;

  // "minNights" field.
  int? _minNights;
  int get minNights => _minNights ?? 0;
  bool hasMinNights() => _minNights != null;

  // "isLive" field.
  bool? _isLive;
  bool get isLive => _isLive ?? false;
  bool hasIsLive() => _isLive != null;

  // "cart" field.
  DocumentReference? _cart;
  DocumentReference? get cart => _cart;
  bool hasCart() => _cart != null;

  void _initializeFields() {
    _propertyName = snapshotData['propertyName'] as String?;
    _propertyDescription = snapshotData['propertyDescription'] as String?;
    _mainImage = snapshotData['mainImage'] as String?;
    _propertyLocation = snapshotData['propertyLocation'] as LatLng?;
    _propertyAddress = snapshotData['propertyAddress'] as String?;
    _isDraft = snapshotData['isDraft'] as bool?;
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _propertyNeighborhood = snapshotData['propertyNeighborhood'] as String?;
    _ratingSummary = castToType<double>(snapshotData['ratingSummary']);
    _price = snapshotData['price'] as int?;
    _taxRate = castToType<double>(snapshotData['taxRate']);
    _cleaningFee = snapshotData['cleaningFee'] as int?;
    _notes = snapshotData['notes'] as String?;
    _minNightStay = castToType<double>(snapshotData['minNightStay']);
    _lastUpdated = snapshotData['lastUpdated'] as DateTime?;
    _minNights = snapshotData['minNights'] as int?;
    _isLive = snapshotData['isLive'] as bool?;
    _cart = snapshotData['cart'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('properties');

  static Stream<PropertiesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PropertiesRecord.fromSnapshot(s));

  static Future<PropertiesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PropertiesRecord.fromSnapshot(s));

  static PropertiesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PropertiesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PropertiesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PropertiesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PropertiesRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createPropertiesRecordData({
  String? propertyName,
  String? propertyDescription,
  String? mainImage,
  LatLng? propertyLocation,
  String? propertyAddress,
  bool? isDraft,
  DocumentReference? userRef,
  String? propertyNeighborhood,
  double? ratingSummary,
  int? price,
  double? taxRate,
  int? cleaningFee,
  String? notes,
  double? minNightStay,
  DateTime? lastUpdated,
  int? minNights,
  bool? isLive,
  DocumentReference? cart,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'propertyName': propertyName,
      'propertyDescription': propertyDescription,
      'mainImage': mainImage,
      'propertyLocation': propertyLocation,
      'propertyAddress': propertyAddress,
      'isDraft': isDraft,
      'userRef': userRef,
      'propertyNeighborhood': propertyNeighborhood,
      'ratingSummary': ratingSummary,
      'price': price,
      'taxRate': taxRate,
      'cleaningFee': cleaningFee,
      'notes': notes,
      'minNightStay': minNightStay,
      'lastUpdated': lastUpdated,
      'minNights': minNights,
      'isLive': isLive,
      'cart': cart,
    }.withoutNulls,
  );

  return firestoreData;
}
