import 'package:flutter/material.dart';
import 'package:freight/functions/compute.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:freight/pages/selectLocation.dart';
import 'package:freight/functions/gmap.dart';

class Fare extends StatefulWidget {
  const Fare({super.key});

  @override
  State<Fare> createState() => _FareState();
}

class _FareState extends State<Fare> {
  LatLng? _selectOrigin;
  LatLng? _selectDestination;
  String? placenameOrigin;
  String? placenameDestination;

  String? _dropdownValue = 'Select';
  List<String> items = ['Package', 'Solid Bulk', 'Hazardous'];

  double distance = 0;
  double _weight = 0;
  double _length = 0;
  double _width = 0;
  double _height = 0;

  Compute newBooking = Compute();

  getTotalBookingCost() {
    if (distance != 0 &&
        _weight != 0 &&
        _length != 0 &&
        _width != 0 &&
        _height != 0) {
      newBooking.getTypeOfVehicle();
      newBooking.getBasePrice();
      newBooking.getBookingFee();
      newBooking.getTotal();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TYPE OF CARGO DROPDOWN ---------------------->
    Widget typeOfCargo = DropdownButtonFormField(
      items: items.map((e) {
        return DropdownMenuItem(
          child: Text(e),
          value: e,
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          _dropdownValue = val as String;
          if (val == 'Package') {
            newBooking.cargoType = TypeOfCargo.package;
            getTotalBookingCost();
          } else if (val == 'Solid Bulk') {
            newBooking.cargoType = TypeOfCargo.solidBulk;
            getTotalBookingCost();
          } else if (val == 'Hazardous') {
            newBooking.cargoType = TypeOfCargo.hazardous;
            getTotalBookingCost();
          }
        });
      },
      value: _dropdownValue == 'Select' ? null : _dropdownValue,
      hint: Text(_dropdownValue!),
      icon: Icon(
        Icons.arrow_drop_down_circle,
        color: Colors.teal,
      ),
      decoration: InputDecoration(
        labelText: "Type of Cargo",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
      validator: (value) {
        if (value == null) {
          return 'Please select an option';
        }
        return null;
      },
    );

    // WEIGHT --------------------------------->
    Widget weight = TextFormField(
      onChanged: (val) {
        setState(() {
          _weight = double.parse(val);
          newBooking.weight = double.parse(val);
          getTotalBookingCost();
        });
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Weight',
        suffixText: 'kg',
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    // LENGTH --------------------------------->
    Widget length = TextFormField(
      onChanged: (val) {
        setState(() {
          _length = double.parse(val);
          newBooking.length = double.parse(val);
          getTotalBookingCost();
        });
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Length',
        suffixText: 'ft',
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    // WIDTH ---------------------------------->
    Widget width = TextFormField(
      onChanged: (val) {
        setState(() {
          _width = double.parse(val);
          newBooking.width = double.parse(val);
          getTotalBookingCost();
        });
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Width',
        suffixText: 'ft',
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    // HEIGHT --------------------------------->
    Widget height = TextFormField(
      onChanged: (val) {
        setState(() {
          _height = double.parse(val);
          newBooking.height = double.parse(val);
          getTotalBookingCost();
        });
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Height',
        suffixText: 'ft',
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    // CARGO INFORMATION ----------------------->
    Widget cargoInformation = Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Cargo Information'),
            SizedBox(height: 5),
            typeOfCargo,
            SizedBox(height: 10),
            weight,
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: length,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: width,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: height,
                ),
              ],
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Fare'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: [
                      ListTile(
                        onTap: () async {
                          // GO TO SELECT LOCATION
                          final selectedLatLng = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectLocation(),
                            ),
                          );

                          if (selectedLatLng != null) {
                            // GET THE NAME OF THE PLACE BASE ON LATLNG
                            String temp =
                                await Gmap.getPlaceName(selectedLatLng);

                            setState(() {
                              placenameOrigin = temp;
                              _selectOrigin = selectedLatLng;
                            });

                            // DISPLAY THE DISTANCE
                            if (_selectOrigin != null &&
                                _selectDestination != null) {
                              double val = await Gmap.getDistance(
                                  _selectOrigin!, _selectDestination!);
                              setState(() {
                                distance = val;
                              });
                            }
                          }
                          // SET DISTANCE FOR COMPUTATION
                          newBooking.distance = distance;
                          getTotalBookingCost();
                        },
                        title: placenameOrigin == null
                            ? Text('Select Origin')
                            : Text('$placenameOrigin'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor: Colors.grey[200],
                        leading: Icon(
                          Icons.circle_outlined,
                          color: Colors.teal,
                        ),
                        trailing: Icon(Icons.arrow_right_sharp),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        onTap: () async {
                          // GET THE NAME OF THE PLACE BASE ON LATLNG
                          final selectedLatLng = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectLocation(),
                            ),
                          );

                          if (selectedLatLng != null) {
                            String temp =
                                await Gmap.getPlaceName(selectedLatLng);

                            setState(() {
                              placenameDestination = temp;
                              _selectDestination = selectedLatLng;
                            });

                            // DISPLAY THE DISTANCE
                            if (_selectOrigin != null &&
                                _selectDestination != null) {
                              double val = await Gmap.getDistance(
                                  _selectOrigin!, _selectDestination!);
                              setState(() {
                                distance = val;
                              });
                            }
                          }
                          // SET DISTANCE FOR COMPUTATION
                          newBooking.distance = distance;
                          getTotalBookingCost();
                        },
                        title: placenameDestination == null
                            ? Text('Select Destination')
                            : Text('$placenameDestination'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor: Colors.grey[200],
                        leading: Icon(
                          Icons.location_pin,
                          color: Colors.teal,
                        ),
                        trailing: Icon(Icons.arrow_right_sharp),
                      ),
                      SizedBox(height: 10),
                      Text('$distance km'),
                      SizedBox(height: 20),
                      cargoInformation,
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'TOTAL:',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '₱${newBooking.totalBookingCost}',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
