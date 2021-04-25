import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turbo_care/providers/vehicle_provider.dart';
import 'package:turbo_care/screens/vehicle_list_screen.dart';

class SelectTransmissionScreen extends StatefulWidget {
  static const routeName = '/select-transmission-screen';
  @override
  _SelectTransmissionScreenState createState() =>
      _SelectTransmissionScreenState();
}

class _SelectTransmissionScreenState extends State<SelectTransmissionScreen> {
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
      appBar: AppBar(
        title: Text('Select Transmission'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              vehicleDetails['transmission'] = 'Manual';

              Provider.of<VehicleProvider>(context, listen: false)
                  .addVehicleToListOfinLocal(vehicleDetails)
                  .then((value) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    VehicleListScreen.routeName,
                    ModalRoute.withName(VehicleListScreen.routeName));
              });
            },
            title: Text(
              'Manual',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {
              vehicleDetails['transmission'] = 'Automatic';

              Provider.of<VehicleProvider>(context, listen: false)
                  .addVehicleToListOfinLocal(vehicleDetails)
                  .then((value) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    VehicleListScreen.routeName,
                    ModalRoute.withName(VehicleListScreen.routeName));
              });
              // Navigator.of(context).
            },
            title: Text(
              'Automatic',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}
