import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turbo_care/screens/select_fuel_type_screen.dart';
import '../providers/vehicle_provider.dart';

class SelectModelScreen extends StatefulWidget {
  static const routeName = '/select-model-screen';
  @override
  _SelectModelScreenState createState() => _SelectModelScreenState();
}

class _SelectModelScreenState extends State<SelectModelScreen> {
  Map<String, String> vehicleDetails;
  List<String> models = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((_) {
      vehicleDetails = ModalRoute.of(context).settings.arguments;

      Provider.of<VehicleProvider>(context, listen: false)
          .getListOfModelsFromDatabase(
              vehicleDetails['type'], vehicleDetails['make'])
          .then((value) {
        setState(() {
          models =
              Provider.of<VehicleProvider>(context, listen: false).modelOfCar;
          _isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Model')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: models.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  vehicleDetails['model'] = models[index];
                  Navigator.of(context).pushNamed(
                      SelectFuelTypeScreen.routeName,
                      arguments: vehicleDetails);

                  // Navigator.of(context).
                },
                title: Text(
                  models[index],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
    );
  }
}
