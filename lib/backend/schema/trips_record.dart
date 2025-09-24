import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TripsRecord extends FirestoreRecord {
  TripsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "propertyRef" field.
  DocumentReference? _propertyRef;
  DocumentReference? get propertyRef => _propertyRef;
  bool hasPropertyRef() => _propertyRef != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "tripBeginDate" field.
  DateTime? _tripBeginDate;
  DateTime? get tripBeginDate => _tripBeginDate;
  bool hasTripBeginDate() => _tripBeginDate != null;

  // "tripEndDate" field.
  DateTime? _tripEndDate;
  DateTime? get tripEndDate => _tripEndDate;
  bool hasTripEndDate() => _tripEndDate != null;

  // "tripCost" field.
  double? _tripCost;
  double get tripCost => _tripCost ?? 0.0;
  bool hasTripCost() => _tripCost != null;

  // "guests" field.
  int? _guests;
  int get guests => _guests ?? 0;
  bool hasGuests() => _guests != null;

  // "paymentMethod" field.
  String? _paymentMethod;
  String get paymentMethod => _paymentMethod ?? '';
  bool hasPaymentMethod() => _paymentMethod != null;

  // "tripCreated" field.
  DateTime? _tripCreated;
  DateTime? get tripCreated => _tripCreated;
  bool hasTripCreated() => _tripCreated != null;

  // "host" field.
  DocumentReference? _host;
  DocumentReference? get host => _host;
  bool hasHost() => _host != null;

  // "cancelTrip" field.
  bool? _cancelTrip;
  bool get cancelTrip => _cancelTrip ?? false;
  bool hasCancelTrip() => _cancelTrip != null;

  // "cancelReason" field.
  String? _cancelReason;
  String get cancelReason => _cancelReason ?? '';
  bool hasCancelReason() => _cancelReason != null;

  // "tripTotal" field.
  int? _tripTotal;
  int get tripTotal => _tripTotal ?? 0;
  bool hasTripTotal() => _tripTotal != null;

  // "upcoming" field.
  bool? _upcoming;
  bool get upcoming => _upcoming ?? false;
  bool hasUpcoming() => _upcoming != null;

  // "complete" field.
  bool? _complete;
  bool get complete => _complete ?? false;
  bool hasComplete() => _complete != null;

  // "rated" field.
  bool? _rated;
  bool get rated => _rated ?? false;
  bool hasRated() => _rated != null;

  void _initializeFields() {
    _propertyRef = snapshotData['propertyRef'] as DocumentReference?;
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _tripBeginDate = snapshotData['tripBeginDate'] as DateTime?;
    _tripEndDate = snapshotData['tripEndDate'] as DateTime?;
    _tripCost = castToType<double>(snapshotData['tripCost']);
    _guests = snapshotData['guests'] as int?;
    _paymentMethod = snapshotData['paymentMethod'] as String?;
    _tripCreated = snapshotData['tripCreated'] as DateTime?;
    _host = snapshotData['host'] as DocumentReference?;
    _cancelTrip = snapshotData['cancelTrip'] as bool?;
    _cancelReason = snapshotData['cancelReason'] as String?;
    _tripTotal = snapshotData['tripTotal'] as int?;
    _upcoming = snapshotData['upcoming'] as bool?;
    _complete = snapshotData['complete'] as bool?;
    _rated = snapshotData['rated'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('trips');

  static Stream<TripsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TripsRecord.fromSnapshot(s));

  static Future<TripsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TripsRecord.fromSnapshot(s));

  static TripsRecord fromSnapshot(DocumentSnapshot snapshot) => TripsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TripsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TripsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TripsRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createTripsRecordData({
  DocumentReference? propertyRef,
  DocumentReference? userRef,
  DateTime? tripBeginDate,
  DateTime? tripEndDate,
  double? tripCost,
  int? guests,
  String? paymentMethod,
  DateTime? tripCreated,
  DocumentReference? host,
  bool? cancelTrip,
  String? cancelReason,
  int? tripTotal,
  bool? upcoming,
  bool? complete,
  bool? rated,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'propertyRef': propertyRef,
      'userRef': userRef,
      'tripBeginDate': tripBeginDate,
      'tripEndDate': tripEndDate,
      'tripCost': tripCost,
      'guests': guests,
      'paymentMethod': paymentMethod,
      'tripCreated': tripCreated,
      'host': host,
      'cancelTrip': cancelTrip,
      'cancelReason': cancelReason,
      'tripTotal': tripTotal,
      'upcoming': upcoming,
      'complete': complete,
      'rated': rated,
    }.withoutNulls,
  );

  return firestoreData;
}
