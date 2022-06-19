import 'package:flutter/material.dart';
import 'package:tenant_review/views/logon.dart';
import 'package:tenant_review/storage/tenant_review_kv_storage.dart';
import 'package:tenant_review/http/http_interface.dart';

class TRVUErrorWidget extends StatelessWidget {
  String MessageOfError;
  TRVUErrorWidget({required this.MessageOfError});

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(title: const Text("TenantRVU"));

    return Scaffold(
      appBar: appBar,
      body: Container(
          child: Column(
        children: [
          Text(this.MessageOfError),
          ElevatedButton.icon(
              onPressed: () async {
                //read logger file
                //send it to support url
                /*
                TRVUStorage.read(key: "Logger").then((log) {
                  if (log != null) {
                    TRVUStorage.read(key: "SupportUrl").then((supportURL) {
                      if (supportURL != null) {
                        TRVUHttp myHttp = TRVUHttp(
                            Uri.parse(supportURL), {"SupportLog": log}, () {});
                        myHttp.post();
                      }
                    });
                  }
                });
                */
                Navigator.of(context).pushReplacementNamed(TRVULogin.routeName);
              },
              icon: const Icon(Icons.upload_file),
              label: const Text("Send Logs to Support"))
        ],
      )),
    );
  }
}
