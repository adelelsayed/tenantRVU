import 'package:flutter/material.dart';
import 'package:tenant_review/widgets/error_widget.dart';
import 'package:tenant_review/widgets/logon.dart';
import 'package:tenant_review/logger/logger.dart';

class TRVULogin extends StatelessWidget {
  static String routeName = "Login";
  AppBar appBar = AppBar(title: const Text("TenantRVU"));
  @override
  Widget build(BuildContext context) {
    try {
      Widget LogonWidget = Scaffold(appBar: appBar, body: TRVULogonWidget());

      return LogonWidget;
    } catch (eError, stackTrace) {
      Logger.logMe(
          "TRVULogin", "${eError.toString()}||${stackTrace.toString()}");

      return TRVUErrorWidget(
          MessageOfError:
              "Error During Login click this button to upload the log to support!");
    }
  }
}
