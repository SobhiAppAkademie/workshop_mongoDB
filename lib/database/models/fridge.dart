import 'package:realm/realm.dart';

/// Diese Datei enthält Schemes für die MongoDB Datenbank.
/// Um das Schema mit der Datenbank zu synchronisieren nutzen wir
/// den Befehl im Terminal: "dart run realm generate"
/// Für bestehende Änderungen nutzen wir den Befehl: "dart run realm generate --watch"
/// Nach dem Ausführen erhalten wir eine auto-generierte Datei namens 'fridge.g.dart'

/// Für jede Entität müssen wir eine part-Direktive angeben. Diese Direktive gibt an,
/// dass die Entität zu einem anderen Teil (in einer anderen Datei) gehört.

part 'fridge.g.dart';

/// Jede Klasse die in unsere MongoDB Datenbank eingefügt werden soll, muss als klar definiertes Schema angegeben werden.
/// Im Developer Mode in der Atlas MongoDB können wir von hier aus das Schema dynamisch festlegen.

/// Jede Entität (Klasse) bekommt ein '@RealmModel()'
@RealmModel()
class _Fridge {
  /// Für die ID nutzen wir einen Primary Key und mappen es als _id.
  /// late ObjectId _id können wir nicht verwenden, da wir sonst einen Fehler bei der Schemasynchronisation erhalten
  /// Deshalb nutzen wir '@MapTo("_id")' um 'id' auf die '_id' zu mappen.
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;

  /// identifyID: Zur Identifizierung unseres Kühlschranks
  late String identifyID;

  /// products: Eine Liste an Produkte die in unserem Kühlschrank vorhanden sind
  /// Wir nutzen eine Entität (Klasse) die unten definiert ist und in Verbindung mit unserem Kühlschrank steht
  /// 1 Kühlschrank kann N Produkte enthalten
  late List<_Product> products;
}

@RealmModel()
class _Product {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;

  late String productName;

  /// Fiktiver Barcode der gescannt werden kann für eine erweiterte Suchfunktion
  /// Nicht in der App implementiert, wird mit einem Standardwert versehen
  late String barcode;

  /// Das Ablaufdatum des Produkts
  late DateTime expiresIn;
}
