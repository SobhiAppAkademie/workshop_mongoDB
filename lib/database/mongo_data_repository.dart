import 'package:fridge/database/models/fridge.dart';
import 'package:realm/src/list.dart';

import '../helper/helper.dart';

class MongoDataRepository {
  Fridge? fridge;

  /// Help Fields
  bool get hasFridge => fridge != null;
  bool get hasProducts => hasFridge ? fridge!.products.isNotEmpty : false;

  /// Enthält alle abgelaufene Produkte
  List<Product> get expiredProducts => hasFridge
      ? fridge!.products
          .where((element) => isExpired(DateTime.now(), element.expiresIn))
          .toList()
      : [];

  /// Enthält alle nicht abgelaufene Produkte
  List<Product> get nonExpiredProducts => hasFridge
      ? fridge!.products
          .where((element) => !isExpired(DateTime.now(), element.expiresIn))
          .toList()
      : [];

  /// Alle Produkte im Kühlschrank
  List<Product> get allProducts => hasFridge ? fridge!.products : [];

  /// Alle Produkte sortiert nach dem Ablaufdatum
  List<Product> Function() get allSortedProducts => () {
        if (!hasFridge) return [];
        List<Product> products = fridge!.products.map((e) => e).toList();
        products.sort((a, b) => a.expiresIn.compareTo(b.expiresIn));
        return products;
      };

  static final MongoDataRepository _instance = MongoDataRepository._internal();
  factory MongoDataRepository() => _instance;
  MongoDataRepository._internal();
}
