import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenant_review/views/logon.dart';
import 'package:tenant_review/views/homepage_map.dart';
import 'package:tenant_review/views/reviews.dart';
import 'package:tenant_review/providers/auth.dart';
import 'package:tenant_review/providers/current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<String, Widget Function(BuildContext)> TRVURoutes = {
      TRVULogin.routeName: (context) => TRVULogin(),
      TRVUHomeMap.routeName: (context) => TRVUHomeMap(),
      ReviewListByLocationView.routeName: (context) =>
          ReviewListByLocationView(),
    };

    TRVUCurrentLocation currentLocationObj =
        TRVUCurrentLocation(latitude: 25.2923, longitude: 55.3711);
    currentLocationObj.getCurrentLocation();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProvider.value(value: currentLocationObj),
        ],
        child: MaterialApp(
          title: 'TenantReview',
          routes: TRVURoutes,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: TRVULogin(),
        ));
  }
}
