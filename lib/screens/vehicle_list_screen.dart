import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turbo_care/screens/new_vehicle_screen.dart';
import 'package:turbo_care/screens/select_make_screen.dart';
import 'package:turbo_care/screens/vehicle_profile_screen.dart';
import '../providers/vehicle_provider.dart';
import '../models/vehicle_model.dart';

class VehicleListScreen extends StatefulWidget {
  static const routeName = '/vehicle-list-screen';
  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  List<VehicleModel> vehicles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      Provider.of<VehicleProvider>(context, listen: false)
          .getListOfCarsFromLocal()
          .then((value) {
        setState(() {
          vehicles =
              Provider.of<VehicleProvider>(context, listen: false).vehicles;
          _isLoading = false;
        });
      }).catchError((onError) {
        print(onError.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicles'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(NewVehicleScreen.routeName);
        },
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : vehicles.length == 0
              ? Center(
                  child: Text('There are no vehicles added'),
                )
              : ListView.builder(
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              VehicleProfileScreen.routeName,
                              arguments: vehicles[index]);
                        },
                        title: Text(
                          vehicles[index].numberOfVehicle == null
                              ? ''
                              : vehicles[index].numberOfVehicle,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            vehicles[index].make + ' ' + vehicles[index].model),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      Divider(
                        color: Colors.grey,
                        endIndent: 20,
                        indent: 20,
                      )
                    ],
                  ),
                ),
    );
  }
}
