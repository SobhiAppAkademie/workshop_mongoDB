// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fridge.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Fridge extends _Fridge with RealmEntity, RealmObjectBase, RealmObject {
  Fridge(
    ObjectId id,
    String identifyID, {
    Iterable<Product> products = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'identifyID', identifyID);
    RealmObjectBase.set<RealmList<Product>>(
        this, 'products', RealmList<Product>(products));
  }

  Fridge._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get identifyID =>
      RealmObjectBase.get<String>(this, 'identifyID') as String;
  @override
  set identifyID(String value) =>
      RealmObjectBase.set(this, 'identifyID', value);

  @override
  RealmList<Product> get products =>
      RealmObjectBase.get<Product>(this, 'products') as RealmList<Product>;
  @override
  set products(covariant RealmList<Product> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Fridge>> get changes =>
      RealmObjectBase.getChanges<Fridge>(this);

  @override
  Fridge freeze() => RealmObjectBase.freezeObject<Fridge>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Fridge._);
    return const SchemaObject(ObjectType.realmObject, Fridge, 'Fridge', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('identifyID', RealmPropertyType.string),
      SchemaProperty('products', RealmPropertyType.object,
          linkTarget: 'Product', collectionType: RealmCollectionType.list),
    ]);
  }
}

class Product extends _Product with RealmEntity, RealmObjectBase, RealmObject {
  Product(
    ObjectId id,
    String productName,
    String barcode,
    DateTime expiresIn,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'productName', productName);
    RealmObjectBase.set(this, 'barcode', barcode);
    RealmObjectBase.set(this, 'expiresIn', expiresIn);
  }

  Product._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get productName =>
      RealmObjectBase.get<String>(this, 'productName') as String;
  @override
  set productName(String value) =>
      RealmObjectBase.set(this, 'productName', value);

  @override
  String get barcode => RealmObjectBase.get<String>(this, 'barcode') as String;
  @override
  set barcode(String value) => RealmObjectBase.set(this, 'barcode', value);

  @override
  DateTime get expiresIn =>
      RealmObjectBase.get<DateTime>(this, 'expiresIn') as DateTime;
  @override
  set expiresIn(DateTime value) =>
      RealmObjectBase.set(this, 'expiresIn', value);

  @override
  Stream<RealmObjectChanges<Product>> get changes =>
      RealmObjectBase.getChanges<Product>(this);

  @override
  Product freeze() => RealmObjectBase.freezeObject<Product>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Product._);
    return const SchemaObject(ObjectType.realmObject, Product, 'Product', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('productName', RealmPropertyType.string),
      SchemaProperty('barcode', RealmPropertyType.string),
      SchemaProperty('expiresIn', RealmPropertyType.timestamp),
    ]);
  }
}
