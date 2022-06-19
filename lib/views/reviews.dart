import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenant_review/controller/reviews.dart';
import 'package:tenant_review/models/review.dart';
import 'package:tenant_review/widgets/review_detail.dart';
import 'package:tenant_review/widgets/review_list.dart';
import 'package:tenant_review/providers/auth.dart';
import 'package:tenant_review/logger/logger.dart';
import 'package:tenant_review/widgets/error_widget.dart';

class ReviewListByLocationView extends StatelessWidget {
  static String routeName = "ReviewListByLocationView";
  @override
  Widget build(BuildContext context) {
    try {
      final Auth auth = Provider.of<Auth>(context);
      AppBar appBar = AppBar(title: const Text("TenantRVU"));
      return Scaffold(
          appBar: appBar,
          body: SingleChildScrollView(
            child: ReviewListByLocation(),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              dynamic reviewForm =
                  await ReviewList.getEmptyForm(auth.token["token"].toString());

              ReviewDetail routeWidget = ReviewDetail();

              routeWidget.reviewEntry = Review.fromMap(reviewForm);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => routeWidget));
            },
            label: const Text('Add'),
            icon: const Icon(Icons.rate_review_sharp),
          ));
    } catch (eError, stackTrace) {
      Logger.logMe("ReviewListByLocationView",
          "${eError.toString()}||${stackTrace.toString()}");

      return TRVUErrorWidget(
          MessageOfError:
              "Error During ReviewList By LocationView click this button to upload the log to support!");
    }
  }
}
