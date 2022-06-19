import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenant_review/models/review.dart';
import 'package:tenant_review/providers/current_location.dart';
import 'package:tenant_review/providers/auth.dart';
import 'package:tenant_review/widgets/common_widgets.dart';
import 'package:tenant_review/controller/reviews.dart';
import 'package:tenant_review/logger/logger.dart';
import 'package:tenant_review/widgets/error_widget.dart';

class ReviewDetail extends StatelessWidget {
  Review reviewEntry = Review();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    try {
      AppBar appBar = AppBar(title: const Text("TenantRVU"));
      final TRVUCurrentLocation currentLocation =
          Provider.of<TRVUCurrentLocation>(context);
      final Auth auth = Provider.of<Auth>(context);

      return Scaffold(
          appBar: appBar,
          body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Building Name", icon: Icon(Icons.house)),
                      onChanged: (value) {
                        reviewEntry.locationName = value;
                      },
                      initialValue: reviewEntry.locationName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Building Name';
                        }
                        return null;
                      },
                    ),
                    ...reviewEntry.reviewItems
                        .where((element) => element.itemSystem == "nominal")
                        .map((revItem) {
                      return Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: DropdownButtonFormField(
                          value: revItem.itemNominalValue,
                          items: revItem.nominalWords
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e.toString())))
                              .toList(),
                          onChanged: reviewEntry.canEdit
                              ? (dynamic value) {
                                  revItem.itemNominalValue = value.toString();
                                }
                              : null,
                          decoration: InputDecoration(
                            labelText: revItem.itemName,
                          ),
                        ),
                      );
                    }).toList(),
                    ...reviewEntry.reviewItems
                        .where((element) => element.itemSystem == "stars")
                        .map((revItem) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 25),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(children: [
                                Text(
                                  revItem.itemName,
                                  textAlign: TextAlign.left,
                                )
                              ]),
                              StarButton(revItem),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              reviewEntry.reviewDate = DateTime.now();
                              reviewEntry.locationLatitude =
                                  currentLocation.latitude;
                              reviewEntry.locationLongitude =
                                  currentLocation.longitude;
                              ReviewList.postReview(reviewEntry,
                                      auth.token["token"].toString())
                                  .then((value) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                Navigator.of(context).pop();
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Processing Data'),
                                duration: Duration(milliseconds: 500),
                              ));
                            },
                            icon: const Icon(Icons.save),
                            label: const Text("Submit"))),
                  ]))));
    } catch (eError, stackTrace) {
      log("${eError.toString()}||${stackTrace.toString()}");
      Logger.logMe(
          "ReviewDetail", "${eError.toString()}||${stackTrace.toString()}");

      return TRVUErrorWidget(
          MessageOfError:
              "Error During Review Detail click this button to upload the log to support!");
    }
  }
}
