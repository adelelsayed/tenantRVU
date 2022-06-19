import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

TRVUKeyValueStorage TRVUStorage = TRVUKeyValueStorage();

///generic local data layer, key value store, indexing is logically embedded in key where the ^ symbol separates
///module name (i.e: table name) from the dataKey (i.e: index) while the value would be a json of key and value pairs
class TRVUKeyValueStorage extends FlutterSecureStorage {
  String module = "";
  String dataKey = "";
  String dataValue = "";

  Future<dynamic> reading() async {
    String retVal = "";
    await super.read(key: "$module^$dataKey").then((value) {
      if (value != null) {
        return json.decode(value);
      }
    });
  }

  Future<void> writing() {
    return super.write(key: "$module^$dataKey", value: dataValue);
  }
}
