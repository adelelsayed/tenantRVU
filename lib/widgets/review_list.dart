import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tenant_review/controller/reviews.dart';
import 'package:tenant_review/providers/auth.dart';
import 'package:tenant_review/providers/current_location.dart';
import 'package:tenant_review/logger/logger.dart';
import 'package:tenant_review/widgets/error_widget.dart';
import 'package:tenant_review/widgets/review_entry.dart';

class ReviewListByLocation extends StatefulWidget {
  @override
  State<ReviewListByLocation> createState() => _ReviewListByLocation();
}

class _ReviewListByLocation extends State<ReviewListByLocation> {
  bool loaded = false;
  ReviewList reviewListObject = ReviewList();

  @override
  void initState() {
    super.initState();
    loaded = false;
  }

  @override
  Widget build(BuildContext context) {
    try {
      final TRVUCurrentLocation currentLocation =
          Provider.of<TRVUCurrentLocation>(context);
      final Auth auth = Provider.of<Auth>(context);

      if (!loaded) {
        ReviewList.getReviewList(
                LatLng(currentLocation.latitude, currentLocation.longitude),
                auth.token["token"].toString())
            .then((ReviewListObj) {
          reviewListObject = ReviewListObj;
          setState(() {
            loaded = true;
          });
        });
      }

      return loaded
          ? ListView.builder(
              itemBuilder: (ctx, idx) {
                return ReviewEntryWidget(reviewListObject.reviewObjList[idx]);
              },
              itemCount: reviewListObject.reviewObjList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            )
          : const Center(child: CircularProgressIndicator());
    } catch (eError, stackTrace) {
      Logger.logMe("ReviewListByLocation",
          "${eError.toString()}||${stackTrace.toString()}");

      return TRVUErrorWidget(
          MessageOfError:
              "Error During Review List Rendering click this button to upload the log to support!");
    }
  }
}
