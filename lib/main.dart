import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turbo_care/providers/vehicle_provider.dart';
import 'package:turbo_care/screens/new_vehicle_screen.dart';
import 'package:turbo_care/screens/select_fuel_type_screen.dart';
import 'package:turbo_care/screens/select_make_screen.dart';
import 'package:turbo_care/screens/select_model_screen.dart';
import 'package:turbo_care/screens/select_transmission_screen.dart';
import 'package:turbo_care/screens/vehicle_list_screen.dart';
import 'package:turbo_care/screens/vehicle_profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: VehicleProvider(),
          ),
        ],
        child: Consumer<VehicleProvider>(
          builder: (context, vehicle, _) => MaterialApp(
            title: 'Turbo Care Assignment',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.purple,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: VehicleListScreen(),
            routes: {
              NewVehicleScreen.routeName: (ctx) => NewVehicleScreen(),
              SelectFuelTypeScreen.routeName: (ctx) => SelectFuelTypeScreen(),
              SelectMakeScreen.routeName: (ctx) => SelectMakeScreen(),
              SelectModelScreen.routeName: (ctx) => SelectModelScreen(),
              SelectTransmissionScreen.routeName: (ctx) =>
                  SelectTransmissionScreen(),
              VehicleListScreen.routeName: (ctx) => VehicleListScreen(),
              VehicleProfileScreen.routeName: (ctx) => VehicleProfileScreen(),
            },
          ),
        ));
  }
}
