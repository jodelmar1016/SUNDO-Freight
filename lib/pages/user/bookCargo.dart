import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class BookCargo extends StatefulWidget {
  const BookCargo({super.key});

  @override
  State<BookCargo> createState() => _BookCargoState();
}

class _BookCargoState extends State<BookCargo> {
  _BookCargoState() {
    _dropdownValue = items[0];
  }

  String? _dropdownValue = '';
  final items = ['Package', 'Solid Bulk', 'Hazardous'];

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
        });
      },
      value: _dropdownValue,
      icon: Icon(
        Icons.arrow_drop_down_circle,
        color: Colors.orangeAccent,
      ),
      decoration: InputDecoration(
        labelText: "Type of Cargo",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    // WEIGHT --------------------------------->
    Widget weight = TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Weight',
        suffixText: 'kg',
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    // LENGTH --------------------------------->
    Widget length = TextFormField(
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
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Sender Name',
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    Widget senderContact = TextFormField(
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
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Receiver Name',
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );

    Widget receiverContact = TextFormField(
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor: Colors.grey[200],
                        leading: Icon(
                          Icons.circle_outlined,
                          color: Colors.redAccent,
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
                          color: Colors.redAccent,
                        ),
                        trailing: Icon(Icons.arrow_right_sharp),
                        title: Text('Select Destination'),
                      ),
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
                            '₱1,000.00',
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
                              onPressed: () {},
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
