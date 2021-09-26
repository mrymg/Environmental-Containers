// ignore_for_file: file_names, prefer_const_constructors, prefer_final_fields, unused_field, unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Operations extends StatefulWidget {
  const Operations({Key? key}) : super(key: key);

  @override
  _OperationsState createState() => _OperationsState();
}

class _OperationsState extends State<Operations> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(39.90324, 32.77555);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                CameraPosition(target: _center, zoom: 11.0)));
  }
}
