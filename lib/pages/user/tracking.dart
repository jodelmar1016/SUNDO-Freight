import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Tracking extends StatefulWidget {
  final List<LatLng> points;
  const Tracking({super.key, required this.points});

  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  late LatLng origin;
  late LatLng destination;

  // static const LatLng sourceLocation =
  //     LatLng(17.638517459360106, 121.75565950134083);
  // static const LatLng destination =
  //     LatLng(17.61337898335645, 121.71409369881701);

  List<LatLng> polylinecoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyCc7-GEEUjHx-yM0yClaSAmsuWH7H7wfck',
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) => {
            polylinecoordinates.add(LatLng(point.latitude, point.longitude)),
          });

      setState(() {});
    }
  }

  @override
  void initState() {
    origin = widget.points[0];
    destination = widget.points[1];
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            child: Center(
              child: Text(
                'Your Package is on the way',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: origin,
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('source'),
                  position: origin,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueViolet),
                ),
                Marker(
                  markerId: MarkerId('destionation'),
                  position: destination,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueViolet),
                ),
              },
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  points: polylinecoordinates,
                  color: Colors.teal,
                  width: 6,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
