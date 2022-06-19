import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:tenant_review/providers/current_location.dart';
import 'package:tenant_review/logger/logger.dart';
import 'package:tenant_review/widgets/error_widget.dart';
import 'package:tenant_review/views/reviews.dart';
import 'dart:developer';

class TRVUHomeMap extends StatefulWidget {
  static String routeName = "HomeMap";
  @override
  State<TRVUHomeMap> createState() => _HomeMap();
}

class _HomeMap extends State<TRVUHomeMap> {
  bool showFloating = false;
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    try {
      final TRVUCurrentLocation currentLocation =
          Provider.of<TRVUCurrentLocation>(context);

      Widget retVal = Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target:
                  LatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: 15.0),
          onMapCreated: (GoogleMapController controller) {
            //controller.animateCamera(CameraUpdate());
            _controller.complete(controller);
          },
          markers: {
            Marker(
                markerId: const MarkerId("TRVU"),
                position:
                    LatLng(currentLocation.latitude, currentLocation.longitude),
                onDrag: (LatLng dragLoc) {
                  currentLocation.setToCoordinates(dragLoc);
                },
                onDragEnd: (LatLng dragLoc) {
                  currentLocation.setToCoordinates(dragLoc);
                })
          },
          myLocationEnabled: true,
          onTap: (LatLng tapLoc) {
            if ((tapLoc.latitude == currentLocation.latitude) &
                (tapLoc.longitude == currentLocation.longitude)) {
              showFloating = false;
            } else {
              // new location
              currentLocation.setToCoordinates(tapLoc);
              showFloating = true;
            }
            //floating button visible --> click to go to route of location details : search reviews  and option of add/edit my review
          },
        ),
        floatingActionButton: Visibility(
            visible: showFloating,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(ReviewListByLocationView.routeName);
              },
              label: const Text('TRVU'),
              icon: const Icon(Icons.reviews),
            )),
      );
      return retVal;
    } catch (eError, stackTrace) {
      Logger.logMe(
          "TRVUHomeMap", "${eError.toString()}||${stackTrace.toString()}");

      return TRVUErrorWidget(
          MessageOfError:
              "Error During Map Rendering click this button to upload the log to support!");
    }
  }
}
