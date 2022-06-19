import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tenant_review/models/review.dart';
import 'package:tenant_review/widgets/review_detail.dart';

class ReviewEntryWidget extends StatelessWidget {
  Review reviewEntry = Review();
  ReviewEntryWidget(Review previewEntry) {
    Key? key = super.key;
    reviewEntry = previewEntry;
  }
  @override
  Widget build(BuildContext context) {
    final colori = Colors.blue[reviewEntry.score.toInt() != 0
        ? (10 * reviewEntry.score.toInt() ~/ 100).toInt() * 100
        : 50];
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                ReviewDetail reviewDetail = ReviewDetail();
                reviewDetail.reviewEntry = reviewEntry;
                return reviewDetail;
              })
                  //arguments: product.id,
                  );
            },
            child: Container(
              height: 120,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.hardEdge,
                shadowColor: Colors.blueAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          reviewEntry.locationName.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 30, color: colori),
                        ),
                        Text(
                          "${reviewEntry.reviewDate.month.toString()}/${reviewEntry.reviewDate.year}",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 30, color: colori),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CircleAvatar(
                            backgroundColor: colori,
                            minRadius: 45,
                            child: Text(
                              "${reviewEntry.score.toString()}%",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
