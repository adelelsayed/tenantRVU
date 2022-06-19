import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tenant_review/http/http_interface.dart';
import 'package:tenant_review/logger/logger.dart';
import 'package:tenant_review/models/review.dart';

class ReviewList {
  List<Review> reviewObjList = [];
  static String fetchUrl = "https://tenantrvu.com/trvu/reviewlist";
  static String postUrl = "https://tenantrvu.com/trvu/postReview";
  static String fetchEmptyFormUrl = "https://tenantrvu.com/trvu/emptyform";

  static Future<ReviewList> getReviewList(
      LatLng ptargetLocation, String authToken) async {
    try {
      ReviewList retReviewList = ReviewList();

      TRVUHttp reviewsHttpRequest = TRVUHttp(
          Uri.parse(
              "$fetchUrl/${ptargetLocation.latitude}/${ptargetLocation.longitude}"),
          {"token": authToken}, (reviewsHttpReponse) {
        List<dynamic> reviewJson =
            json.decode(reviewsHttpReponse.body)["resultset"];
        retReviewList.reviewObjList =
            reviewJson.map((elem) => Review.fromMap(elem)).toList();
      });

      await reviewsHttpRequest.get();

      return retReviewList;
    } catch (eError, stackTrace) {
      Logger.logMe("ReviewList build process",
          "${eError.toString()}||${stackTrace.toString()}");

      return ReviewList();
    }
  }

  static Future<void> postReview(Review review, String authToken) async {
    try {
      TRVUHttp reviewsHttpRequest = TRVUHttp(
          Uri.parse(postUrl),
          {"token": authToken, "reviewData": review.serialize()},
          (reviewsHttpReponse) {});

      await reviewsHttpRequest.post();
    } catch (eError, stackTrace) {
      Logger.logMe("Review post process",
          "${eError.toString()}||${stackTrace.toString()}");
    }
  }

  static Future<dynamic> getEmptyForm(String authToken) async {
    try {
      dynamic retVal;
      TRVUHttp reviewsHttpRequest =
          TRVUHttp(Uri.parse(fetchEmptyFormUrl), {"token": authToken},
              (reviewsHttpReponse) {
        retVal = json.decode(reviewsHttpReponse.body);
      });

      await reviewsHttpRequest.get();

      return retVal;
    } catch (eError, stackTrace) {
      Logger.logMe("Review blank form fetch process",
          "${eError.toString()}||${stackTrace.toString()}");
    }
  }
}
