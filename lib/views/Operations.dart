// ignore_for_file: file_names, prefer_const_constructors, prefer_final_fields, unused_field, unused_element

import 'dart:async';
import 'dart:math';

import 'package:evrka_case/customWidgets/custDialog.dart';
import 'package:evrka_case/customWidgets/custTextStyles.dart';
import 'package:evrka_case/customWidgets/greenButton.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class Operations extends StatefulWidget {
  const Operations({Key? key}) : super(key: key);

  @override
  _OperationsState createState() => _OperationsState();
}

class _OperationsState extends State<Operations> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = LatLng(39.90324, 32.77555);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<MarkerId, myContainer> containers = <MarkerId, myContainer>{};

//states
  bool isMarkerSelected = false;
  bool isRelocationActive = false;
  bool disableOutTapping = false;
  bool isRelocationConfirmed = false;
  String selectedMarkerId = "";
  String nextCollection = "";
  String fullnessRate = "";
  late MarkerId selectedMarker;

  int markerIdCounter = 060001;
  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    //creating markers in Ankara city.

    // Random Ankara locations.
    double minLat = 39.984048;
    double maxLat = 39.847482;

    double minLong = 32.697432;
    double maxLong = 32.870280;

    Map<MarkerId, Marker> markersList = <MarkerId, Marker>{};

    for (var i = 1; i <= 1000; i++) {
      final Random random = Random();
      double latitude = minLat + (random.nextDouble() * (maxLat - minLat));
      double longtitude = minLong + (random.nextDouble() * (maxLong - minLong));

      //onemli bir mevzu
      MarkerId markerId = MarkerId(markerIdCounter.toString());
      markerIdCounter++;

      int containerFullness = random.nextInt(100);
      DateTime nextCollectionDate =
          DateTime.now().add(Duration(days: random.nextInt(5)));
      myContainer container =
          myContainer(markerId, containerFullness, nextCollectionDate);
      containers[markerId] = container;
      Marker marker = Marker(
          markerId: markerId,
          position: LatLng(latitude, longtitude),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(512, 512)),
              "assets/images/greenPin.png"),
          onTap: () {
            _onMarkerTapped(markerId);
          });

      markersList[markerId] = marker;
    }
    setState(() {
      markers = markersList;
      print(markers);
    });
  }

  void _onMarkerTapped(MarkerId markerId) {
    setState(() {
      print("ALOOO");
      print(markerId.value);
      isMarkerSelected = true;
      selectedMarkerId = markerId.value;
      nextCollection = (containers[markerId]?.nextCollection).toString();
      // nextCollection = containers[selectedMarkerId]!.nextCollection.toString();
      fullnessRate = (containers[markerId]?.fullness).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
            onMapCreated: _onMapCreated,
            onLongPress: (LatLng) {
              if (isRelocationActive) {
                relocate(LatLng, MarkerId(selectedMarkerId));
              }
            },
            onTap: (LatLng pos) {
              if (!disableOutTapping) {
                setState(() {
                  selectedMarkerId = "";
                  isMarkerSelected = false;
                  isRelocationActive = false;
                  nextCollection = "";
                  fullnessRate = "";
                  isRelocationConfirmed = false;
                });
              }
            },
            markers: Set<Marker>.of(markers.values),
            myLocationEnabled: true,
            compassEnabled: false,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(target: _center, zoom: 11.0)),
        Align(
            alignment: Alignment.bottomCenter,
            child: Builder(builder: (_) {
              if (isMarkerSelected) {
                return MapDialog(
                  context: context,
                  widget: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Container $selectedMarkerId", style: h3()),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Next Collection", style: h4()),
                            Text(nextCollection, style: t1()),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Fullness Rate",
                              style: h4(),
                            ),
                            Text(
                              "${fullnessRate}%",
                              style: t1(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GreenButton("NAVIGATE", () {
                                    var targetMarker =
                                        markers[MarkerId(selectedMarkerId)];
                                    if (targetMarker != null) {
                                      double lat =
                                          targetMarker.position.latitude;
                                      double lon =
                                          targetMarker.position.longitude;
                                      MapsLauncher.launchCoordinates(lat, lon);
                                    } else {
                                      MapsLauncher();
                                    }
                                  }, MediaQuery.of(context).size.width * 0.35),
                                  GreenButton("RELOCATE", () {
                                    setState(() {
                                      isMarkerSelected = false;
                                      isRelocationActive = true;
                                    });
                                  }, MediaQuery.of(context).size.width * 0.35)
                                ])
                          ],
                        )
                      ],
                    ),
                  ),
                  hratio: 0.3,
                );
              } else if (isRelocationActive) {
                return MapDialog(
                    context: context,
                    widget: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Please select a location from the map for your bin to be relocated. You can select a location by long press on the map.",
                            style: t1(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GreenButton("SAVE", () => {updateLocation()}, 304.0)
                        ],
                      ),
                    ),
                    hratio: 0.2);
              } else if (isRelocationConfirmed) {
                return MapDialog(
                    context: context,
                    widget: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your bin has been relocated successfully!",
                            style: t1(),
                          )
                        ],
                      ),
                    ),
                    hratio: 0.1);
              } else {
                return Container();
              }
            })),
      ],
    ));
  }

  relocate(LatLng l, MarkerId markerId) async {
    disableOutTapping = true;
    markers.remove(markerId);
    markers[markerId] = Marker(
        markerId: markerId,
        position: l,
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(512, 512)),
            "assets/images/greenPin.png"),
        onTap: () {
          _onMarkerTapped(markerId);
        });
    setState(() {
      markers = markers;
    });
  }

  updateLocation() {
    setState(() {
      isRelocationActive = false;
      isMarkerSelected = false;
      disableOutTapping = false;
      isRelocationConfirmed = true;
    });
  }
}

class myContainer {
  MarkerId markerId;
  int? fullness;
  DateTime? nextCollection;

  myContainer(this.markerId, this.fullness, this.nextCollection);
}
