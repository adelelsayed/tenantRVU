import 'dart:convert';
import 'dart:developer';

class Review {
  double locationLatitude = 0.0;
  double locationLongitude = 0.0;
  String locationName = "";
  double _score = 0.0;
  DateTime reviewDate = DateTime.now();
  bool canEdit = true;
  List<ReviewItem> reviewItems = [];

  double get score {
    return _score;
  }

  void set score(double pScore) {
    _score = pScore;
  }

  Review();

  Review.fromMap(dynamic reviewMap) {
    locationLatitude = reviewMap["locationLatitude"];
    locationLongitude = reviewMap["locationLongitude"];
    locationName = reviewMap["locationName"];
    score = double.tryParse(reviewMap["score"].toString())!;
    reviewDate = DateTime.parse(reviewMap["reviewDate"]).toLocal();
    canEdit = reviewMap["canEdit"];
    List<dynamic> reviewItemList = List<dynamic>.from(reviewMap["reviewItems"]);
    reviewItems =
        reviewItemList.map((element) => ReviewItem.fromMap(element)).toList();
  }

  dynamic serialize() {
    Map<String, dynamic> reviewJson = {};
    reviewJson["locationLatitude"] = locationLatitude;
    reviewJson["locationLongitude"] = locationLongitude;
    reviewJson["locationName"] = locationName;
    reviewJson["reviewDate"] = reviewDate.toUtc().toString();
    reviewJson["reviewItems"] =
        reviewItems.map((element) => element.serialize()).toList();
    return json.encode(reviewJson);
  }
}

class ReviewItem {
  String itemName = "";
  String itemType = "discrete"; //could be discrete (numerical) or nominal
  String itemSystem =
      "Star"; // evaluation system , stars for discrete, dropmenu for nominal.
  double discreteDenominator = 100.0;
  List<dynamic> nominalWords = [];
  String itemNominalValue = "";
  double itemDiscreteValue = 0.0;

  ReviewItem();

  ReviewItem.fromMap(dynamic reviewItemMap) {
    itemName = reviewItemMap["itemName"];
    itemType = reviewItemMap["itemType"];
    itemSystem = reviewItemMap["itemSystem"];
    discreteDenominator = ((reviewItemMap["discreteDenominator"] != null) &
            (reviewItemMap["discreteDenominator"].toString() != ""))
        ? double.parse(reviewItemMap["discreteDenominator"].toString())
        : 0.0;
    nominalWords = reviewItemMap["nominalWords"];
    itemNominalValue = reviewItemMap["itemNominalValue"];
    itemDiscreteValue = ((reviewItemMap["itemDiscreteValue"] != null) &
            (reviewItemMap["itemDiscreteValue"].toString() != ""))
        ? double.parse(reviewItemMap["itemDiscreteValue"].toString())
        : 0.0;
  }
  dynamic serialize() {
    Map<String, dynamic> reviewItemJson = {};
    reviewItemJson["itemName"] = itemName;
    reviewItemJson["itemType"] = itemType;
    reviewItemJson["itemSystem"] = itemSystem;
    reviewItemJson["discreteDenominator"] = discreteDenominator;
    reviewItemJson["nominalWords"] = nominalWords;
    reviewItemJson["itemNominalValue"] = itemNominalValue;
    reviewItemJson["itemDiscreteValue"] = itemDiscreteValue;
    return json.encode(reviewItemJson);
  }
}
