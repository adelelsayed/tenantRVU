import 'package:tenant_review/storage/tenant_review_sql_storage.dart';

class Logger {
  DateTime logDate = DateTime.now().toUtc();
  String logModule = "LoggerItem";
  String logMessage = "";
  String logKey = DateTime.now().millisecond.toString() + "Logger Key";
  bool isWritten = false;

  Logger(DateTime plogDate, String plogModule, String plogMessage) {
    this.logDate = plogDate.toUtc();
    this.logModule = plogModule;
    this.logMessage = plogMessage;
    this.logKey = this.logDate.microsecond.toString() + " : " + this.logModule;
  }

  static void logMe(String FunctionName, String Message) async {}
}
