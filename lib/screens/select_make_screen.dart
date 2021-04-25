import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turbo_care/models/vehicle_model.dart';
import 'package:turbo_care/providers/vehicle_provider.dart';
import 'package:turbo_care/screens/select_model_screen.dart';

class SelectMakeScreen extends StatefulWidget {
  static const routeName = '/select-make-screen';
  @override
  _SelectMakeScreenState createState() => _SelectMakeScreenState();
}

class _SelectMakeScreenState extends State<SelectMakeScreen> {
  Map<String, String> vehicleDetails;
  List<String> makes = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((_) {
      // setState(() {
      vehicleDetails = ModalRoute.of(context).settings.arguments;
      // });

      Provider.of<VehicleProvider>(context, listen: false)
          .getListOfMakersFromDatabase(vehicleDetails['type'])
          .then((value) {
        setState(() {
          makes =
              Provider.of<VehicleProvider>(context, listen: false).makeOfCar;
          _isLoading = false;
        });
      });
      print(vehicleDetails);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Make'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: makes.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  vehicleDetails['make'] = makes[index];
                  Navigator.of(context).pushNamed(SelectModelScreen.routeName,
                      arguments: vehicleDetails);
                },
                title: Text(
                  makes[index],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
    );
  }
}
