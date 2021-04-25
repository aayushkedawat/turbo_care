import 'package:flutter/material.dart';
import 'package:turbo_care/screens/select_transmission_screen.dart';

class SelectFuelTypeScreen extends StatefulWidget {
  static const routeName = '/select-fuelType-screen';
  @override
  _SelectFuelTypeScreenState createState() => _SelectFuelTypeScreenState();
}

class _SelectFuelTypeScreenState extends State<SelectFuelTypeScreen> {
  List<String> fuelTypes = [
    'Petrol',
    'Diesel',
    'CNG',
    'Petrol + CNG',
    'Electric',
    'Hybrid'
  ];

  Map<String, String> vehicleDetails;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((_) {
      vehicleDetails = ModalRoute.of(context).settings.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select fuel type')),
      body: ListView.builder(
        itemCount: fuelTypes.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            vehicleDetails['fuelType'] = fuelTypes[index];

            Navigator.of(context).pushNamed(SelectTransmissionScreen.routeName,
                arguments: vehicleDetails);
          },
          title: Text(
            fuelTypes[index],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ),
    );
  }
}
