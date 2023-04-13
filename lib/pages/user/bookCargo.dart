import 'package:flutter/material.dart';
import 'package:freight/pages/user/selectLocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:freight/functions/compute.dart';
import 'package:freight/models/bookings.dart';
import 'package:freight/models/response.dart';
import 'package:freight/services/dataService.dart';
import 'package:freight/functions/gmap.dart';

class BookCargo extends StatefulWidget {
  const BookCargo({super.key});

  @override
  State<BookCargo> createState() => _BookCargoState();
}

class _BookCargoState extends State<BookCargo> {
  LatLng? _selectOrigin;
  LatLng? _selectDestination;
  String? placenameOrigin;
  String? placenameDestination;
  double distance = 0;

  _BookCargoState() {
    _dropdownValue = items[0];
  }
  // TYPE OF CARGO
  String? _dropdownValue = '';
  final items = ['Package', 'Solid Bulk', 'Hazardous'];

  double _weight = 0;
  double _length = 0;
  double _width = 0;
  double _height = 0;

  // CONTROLLERS FOR SENDER AND RECEIVER
  final TextEditingController _senderName = TextEditingController();
  final TextEditingController _senderContactNo = TextEditingController();
  final TextEditingController _receiverName = TextEditingController();
  final TextEditingController _receiverContactNo = TextEditingController();

  // COMPUTE TOTAL FARE
  Compute newBooking = Compute();

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
            newBooking.bookingFee = .05;
          } else if (val == 'Solid Bulk') {
            newBooking.bookingFee = .08;
          } else if (val == 'Hazardous') {
            newBooking.bookingFee = .10;
          }
          newBooking.getTotal();
        });
      },
      value: _dropdownValue,
      icon: Icon(
        Icons.arrow_drop_down_circle,
        color: Colors.teal,
      ),
      decoration: InputDecoration(
        labelText: "Type of Cargo",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    // WEIGHT --------------------------------->
    Widget weight = TextFormField(
      onChanged: (val) {
        setState(() {
          newBooking.onWeightChanged(double.parse(val));
          newBooking.getTotal();
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
          newBooking.length = double.parse(val);
          newBooking.getTotal();
        });
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Length',
        suffixText: 'cm',
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    // WIDTH ---------------------------------->
    Widget width = TextFormField(
      onChanged: (val) {
        setState(() {
          newBooking.width = double.parse(val);
          newBooking.getTotal();
        });
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Width',
        suffixText: 'cm',
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    // HEIGHT --------------------------------->
    Widget height = TextFormField(
      onChanged: (val) {
        setState(() {
          newBooking.height = double.parse(val);
          newBooking.getTotal();
        });
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Height',
        suffixText: 'cm',
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

    Widget senderName = TextFormField(
      controller: _senderName,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Sender Name',
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    Widget senderContact = TextFormField(
      controller: _senderContactNo,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Sender Contact Number',
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    Widget senderInformation = Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Sender Information'),
            SizedBox(height: 5),
            senderName,
            SizedBox(height: 10),
            senderContact,
          ],
        ),
      ),
    );

    Widget receiverName = TextFormField(
      controller: _receiverName,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Receiver Name',
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    Widget receiverContact = TextFormField(
      controller: _receiverContactNo,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Receiver Contact Number',
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    Widget receiverInformation = Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Receiver Information'),
            SizedBox(height: 5),
            receiverName,
            SizedBox(height: 10),
            receiverContact,
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Cargo'),
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
                  height: MediaQuery.of(context).size.height * .75,
                  child: ListView(
                    children: [
                      ListTile(
                        onTap: () async {
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
                              placenameOrigin = temp;
                              _selectOrigin = selectedLatLng;
                            });

                            if (_selectOrigin != null &&
                                _selectDestination != null) {
                              double val = await Gmap.getDistance(
                                  _selectOrigin!, _selectDestination!);
                              setState(() {
                                distance = val;
                              });
                            }
                          }
                          newBooking.distance = distance;
                          newBooking.getTotal();
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

                            if (_selectOrigin != null &&
                                _selectDestination != null) {
                              double val = await Gmap.getDistance(
                                  _selectOrigin!, _selectDestination!);
                              setState(() {
                                distance = val;
                              });
                            }
                          }
                          newBooking.distance = distance;
                          newBooking.getTotal();
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
                      Text('$distance km'),
                      SizedBox(height: 10),
                      cargoInformation,
                      SizedBox(height: 10),
                      senderInformation,
                      SizedBox(height: 10),
                      receiverInformation,
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₱${newBooking.total.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                Booking createBooking = new Booking(
                                  origin: _selectOrigin!,
                                  destination: _selectDestination!,
                                  originName: placenameOrigin!,
                                  destinationName: placenameDestination!,
                                  type_of_cargo: _dropdownValue!,
                                  weight: newBooking.weight,
                                  length: newBooking.length,
                                  width: newBooking.width,
                                  height: newBooking.height,
                                  cost: newBooking.total,
                                  senderName: _senderName.text,
                                  senderContactNo: _senderContactNo.text,
                                  receiverName: _receiverName.text,
                                  receiverContactNo: _receiverContactNo.text,
                                );
                                var result =
                                    DataService.addBooking(createBooking);
                              },
                              child: Text(
                                'SUBMIT',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
