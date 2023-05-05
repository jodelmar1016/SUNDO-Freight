import 'package:flutter/material.dart';
import 'package:freight/functions/compute.dart';

class Fare extends StatefulWidget {
  const Fare({super.key});

  @override
  State<Fare> createState() => _FareState();
}

class _FareState extends State<Fare> {
  _FareState() {
    _dropdownValue = items[0];
  }

  String? _dropdownValue = '';
  final items = ['Package', 'Solid Bulk', 'Hazardous'];

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
          // newBooking.onWeightChanged(double.parse(val));
          // newBooking.getTotal();
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

    // FOR TESTING
    Widget distance = TextFormField(
      onChanged: (val) {
        setState(() {
          newBooking.distance = double.parse(val);
          newBooking.getTotal();
        });
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Distance',
        suffixText: 'km',
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor: Colors.grey[200],
                        leading: Icon(
                          Icons.circle_outlined,
                          color: Colors.teal,
                        ),
                        trailing: Icon(Icons.arrow_right_sharp),
                        title: Text('Select Origin'),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor: Colors.grey[200],
                        leading: Icon(
                          Icons.location_pin,
                          color: Colors.teal,
                        ),
                        trailing: Icon(Icons.arrow_right_sharp),
                        title: Text('Select Destination'),
                      ),
                      SizedBox(height: 20),
                      Text(
                          'For testing(we get distance from origin and destination)'),
                      SizedBox(height: 5),
                      distance,
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
                              '₱0.0',
                              // '₱${newBooking.total}',
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
