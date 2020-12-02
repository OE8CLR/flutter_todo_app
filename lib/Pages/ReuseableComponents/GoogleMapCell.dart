import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapCell extends StatefulWidget {
  final double latitude;
  final double longitude;
  final double zoomLevel;
  final double height;
  final EdgeInsets padding;
  final bool readOnly;

  const GoogleMapCell({Key key, @required this.latitude, @required this.longitude, @required this.zoomLevel, @required this.height, this.padding, this.readOnly = true}) : super(key: key);

  @override
  _GoogleMapCellState createState() => _GoogleMapCellState();
}

class _GoogleMapCellState extends State<GoogleMapCell> {
  final Completer<GoogleMapController> _mapController = Completer();
  Future _mapFuture = Future.delayed(Duration(milliseconds: 250), () => true);

  @override
  Widget build(BuildContext context) {
    // Initialisation of GoogleMaps produces some lagging in navigation animation
    // There is a workaround available -> https://github.com/flutter/flutter/issues/28493
    return FutureBuilder(
        future: _mapFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              padding: widget.padding ?? EdgeInsets.zero,
              height: widget.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return _buildMapWidget();
        });
  }

  Widget _buildMapWidget() {
    var coordinates = LatLng(widget.latitude ?? 0, widget.longitude ?? 0);
    var marker = Marker(markerId: MarkerId("POI"), position: coordinates);

    return Container(
      padding: widget.padding ?? EdgeInsets.zero,
      height: widget.height,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          initialCameraPosition: CameraPosition(
            target: coordinates,
            zoom: widget.zoomLevel ?? 1.0,
          ),
          markers: [marker].toSet(),
          rotateGesturesEnabled: !widget.readOnly,
          zoomGesturesEnabled: !widget.readOnly,
          scrollGesturesEnabled: !widget.readOnly,
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },
        ),
      ),
    );
  }

}
