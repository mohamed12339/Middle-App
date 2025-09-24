// ignore_for_file: unnecessary_getters_setters
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CartStruct extends FFFirebaseStruct {
  CartStruct({
    String? name,
    double? price,
    double? finalprice,
    int? quantity,
    DocumentReference? refrence,
    String? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _price = price,
        _finalprice = finalprice,
        _quantity = quantity,
        _refrence = refrence,
        _id = id,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;
  void incrementPrice(double amount) => _price = price + amount;
  bool hasPrice() => _price != null;

  // "finalprice" field.
  double? _finalprice;
  double get finalprice => _finalprice ?? 0.0;
  set finalprice(double? val) => _finalprice = val;
  void incrementFinalprice(double amount) => _finalprice = finalprice + amount;
  bool hasFinalprice() => _finalprice != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  set quantity(int? val) => _quantity = val;
  void incrementQuantity(int amount) => _quantity = quantity + amount;
  bool hasQuantity() => _quantity != null;

  // "refrence" field.
  DocumentReference? _refrence;
  DocumentReference? get refrence => _refrence;
  set refrence(DocumentReference? val) => _refrence = val;
  bool hasRefrence() => _refrence != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;
  bool hasId() => _id != null;

  static CartStruct fromMap(Map<String, dynamic> data) => CartStruct(
        name: data['name'] as String?,
        price: castToType<double>(data['price']),
        finalprice: castToType<double>(data['finalprice']),
        quantity: data['quantity'] as int?,
        refrence: data['refrence'] as DocumentReference?,
        id: data['id'] as String?,
      );

  static CartStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? CartStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'price': _price,
        'finalprice': _finalprice,
        'quantity': _quantity,
        'refrence': _refrence,
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => toMap();
  static CartStruct fromSerializableMap(Map<String, dynamic> data) =>
      fromMap(data);

  @override
  String toString() => 'CartStruct(${toMap()})';
}

CartStruct createCartStruct({
  String? name,
  double? price,
  double? finalprice,
  int? quantity,
  DocumentReference? refrence,
  String? id,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CartStruct(
      name: name,
      price: price,
      finalprice: finalprice,
      quantity: quantity,
      refrence: refrence,
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CartStruct? updateCartStruct(
  CartStruct? cart, {
  bool clearUnsetFields = true,
}) =>
    cart
      ?..firestoreUtilData =
          FirestoreUtilData(clearUnsetFields: clearUnsetFields);

void addCartStructData(
  Map<String, dynamic> firestoreData,
  CartStruct? cart,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (cart == null) {
    return;
  }
  if (cart.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue && cart.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final cartData = getCartFirestoreData(cart, forFieldValue);
  final nestedData = cartData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = cart.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCartFirestoreData(
  CartStruct? cart, [
  bool forFieldValue = false,
]) {
  if (cart == null) {
    return {};
  }
  final firestoreData = mapToFirestore(cart.toMap());

  // Add any Firestore field values
  cart.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCartListFirestoreData(
  List<CartStruct>? carts,
) =>
    carts?.map((e) => getCartFirestoreData(e, true)).toList() ?? [];
