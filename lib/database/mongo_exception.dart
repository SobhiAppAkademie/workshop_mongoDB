class MongoException implements Exception {
  String message;
  String errorCode;

  @override
  String toString() {
    return "$errorCode: $message";
  }

  MongoException({required this.message, required this.errorCode});
}

// Defining Error Codes for our App

class DatabaseConnectErrorException extends MongoException {
  DatabaseConnectErrorException({String? e})
      : super(errorCode: "ME-01", message: "Cannot connect to Database: $e");
}

class DatabaseInsertErrorException extends MongoException {
  DatabaseInsertErrorException({String? e})
      : super(
            errorCode: "ME-02", message: "Cannot insert Data to Database: $e");
}
