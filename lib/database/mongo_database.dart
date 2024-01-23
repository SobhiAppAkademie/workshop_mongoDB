import 'package:fridge/database/mongo_configuration.dart';
import 'package:fridge/database/mongo_data_repository.dart';
import 'package:fridge/database/mongo_exception.dart';
import 'package:realm/realm.dart';
import 'package:objectid/src/objectid/objectid.dart' as obj;
import 'models/fridge.dart';

class MongoDatabase {
  /// App Konfiguration
  final appConfig = AppConfiguration(MongoConfiguration.appServiceID);

  /// App Instanz
  late final app;

  /// User Instanz
  late final user;

  /// Realm Konfiguration
  late final config;

  ///Realm Instanz, um CRUD-Aktionen durchzuführen
  late final Realm realm;

  bool _init = false;

  /// Dient zur Überprüfung, sodass keine CRUD-Aktionen mit der Realm-Instanz
  /// durchgeführt werden, ohne dass die App- und Realm-Instanz initialisiert wurden.
  void _checkInitialization() {
    if (!_init) {
      throw Exception("Please initialize and connect to Database first.");
    }
  }

  /// Anonymes Anmelden ermöglicht das Durchführen von CRUD-Aktionen und die
  /// Synchronisierung mit der Datenbank.
  Future<void> _loginAnonym() async {
    user = await app.logIn(Credentials.anonymous());
  }

  /// Abfrage unseres Kühlschranks in der Datenbank anhand der 'identifyID'.
  /// Nach der Abfrage setzen wir den Kühlschrank in unserem MongoDataRepository
  Future<void> _initFridge() async {
    final RealmResults<Fridge> results =
        realm.query<Fridge>(r'identifyID = $0', [MongoConfiguration.fridgeID]);
    if (results.isEmpty) return;

    Fridge myFridge = results.first;
    if (myFridge != null) {
      print("[MongoDatabase]: We found a fridge in the Database");
    } else {
      print("[MongoDatabase]: NO Fridge");
    }
    MongoDataRepository().fridge = myFridge;
  }

  /// Initialisieren unserer Datenbank
  Future<void> initDatabase() async {
    /// Wenn unsere Datenbank schon initialisiert wurde soll dies nicht nochmal
    /// erfolgen
    if (_init) return;
    try {
      app = App(appConfig);
      await _loginAnonym();

      /// flexibleSync: Synchronisieren mit der MongoDB Cloud Datenbank
      /// local: Lokale Synchronisation ohne MongoDB Cloud Datenbank
      config =
          Configuration.flexibleSync(user, [Fridge.schema, Product.schema]);
      realm = Realm(config);

      /// Benötigen Subscriptions, um CRUD-Aktionen durchzuführen
      realm.subscriptions.update((mutableSubscriptions) {
        /// Jeweils für die Produkt- und die Fridge-Entität
        mutableSubscriptions.add(realm.all<Product>());
        mutableSubscriptions.add(realm.all<Fridge>());
      });
      await _initFridge();
      _init = true;
    } catch (e) {
      throw DatabaseConnectErrorException(e: e.toString());
    }
  }

  Future<void> saveProductToDatabase(Product product) async {
    _checkInitialization();
    try {
      /// Wenn wir ein Kühlschrank bereits in der DB angelegt haben
      if (MongoDataRepository().hasFridge) {
        final currentFridge = MongoDataRepository().fridge!;

        /// Write-Funktion ausführen
        final myNewerFridge = await realm.writeAsync<Fridge>(() {
          /// Fügen ein Produkt zum Kühlschrank hinzu
          currentFridge.products.add(product);

          /// add-Funktion: Erstellen/Updaten eines Objekts in der DB
          /// update: true -> Sagen der DB, dass es nur updaten soll
          return realm.add(currentFridge, update: true);
        });

        /// Neuer up-to-date Kühlschrank in unserem MongoDataRepository setzen
        MongoDataRepository().fridge = myNewerFridge;
      } else {
        /// Wir haben keinen Kühlschrank in der DB angelegt und müssen dies nun
        /// vorbereiten. Jede ID eines MongoDB-Schemas muss mit ObjectId()
        /// aus dem Package: package:objectid/src/objectid/objectid.dart
        /// angelegt werden
        Fridge fridge = Fridge(obj.ObjectId(), MongoConfiguration.fridgeID);

        /// Write-Funktion ausführen
        final myNewFridge = await realm.writeAsync<Fridge>(() {
          /// Das aktuelle Produkt noch zum Kühlschrank hinzufügen
          fridge.products.add(product);

          /// add-Funktion: Erstellen/Updaten eines Objekts in der DB
          /// in diesem Falle erstellen wir ein Objekt in der DB, da das
          /// update-Attribut nicht gesetzt ist
          return realm.add(fridge);
        });

        MongoDataRepository().fridge = myNewFridge;
      }
    } catch (e, s) {
      print(e);
      print(s);
      throw DatabaseInsertErrorException(e: e.toString());
    }
  }

  Future<void> deleteExpiredProducts() async {
    for (Product product in MongoDataRepository().expiredProducts) {
      /// Jedes abgelaufene Produkt in der Liste wird in der DB gelöscht
      await realm.writeAsync<void>(() => realm.delete(product));
    }
  }

  static final MongoDatabase _instance = MongoDatabase._internal();
  factory MongoDatabase() => _instance;
  MongoDatabase._internal();
}
