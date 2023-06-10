import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:freight/functions/gmap.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  LatLng _selectedLatLng = LatLng(17.660759658795374, 121.74708318638257);
  String placename = '';

  Marker _marker = Marker(
    markerId: MarkerId('pim'),
    position: LatLng(17.660759658795374, 121.74708318638257),
    infoWindow: InfoWindow(title: 'pin'),
    icon: BitmapDescriptor.defaultMarker,
  );

  // Tap on the map and update the position of the markker
  void _onMapTap(LatLng latLng) async {
    placename = await Gmap.getPlaceName(latLng);
    setState(() {
      _marker = _marker.copyWith(positionParam: latLng);
      _selectedLatLng = latLng;
    });
  }

  void getPlaceName() async {
    String temp = await Gmap.getPlaceName(_selectedLatLng);
    setState(() {
      placename = temp;
    });
  }

  @override
  void initState() {
    getPlaceName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Column(children: [
        Expanded(
          child: GoogleMap(
            mapType: MapType.normal,
            markers: Set<Marker>.of([_marker]),
            initialCameraPosition: CameraPosition(
              target: LatLng(17.660759658795374, 121.74708318638257),
              zoom: 14,
            ),
            onTap: _onMapTap,
          ),
        ),
        Container(
          child: Column(
            children: [
              Text('Place: $placename'),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    _selectedLatLng,
                  );
                },
                child: Column(children: [Text('SELECT')]),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
