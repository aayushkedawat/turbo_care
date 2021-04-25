import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/vehicle_model.dart';

class VehicleProvider with ChangeNotifier {
  List<String> _makers = [];
  List<String> _models = [];
  List<VehicleModel> _vehicles = [];

  Future<void> getListOfMakersFromDatabase(String type) async {
    final url = 'https://test.turbocare.app/turbo/care/v1/makes?class=$type';
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode != 200) {
        throw 'There was some error communicating to server';
      }
      final extractedData = json.decode(response.body) as List;
      final List<String> loadedCategories = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((catData) {
        loadedCategories.add(catData);
      });
      _makers = loadedCategories;
      // notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getListOfModelsFromDatabase(String type, String make) async {
    final url =
        'https://test.turbocare.app/turbo/care/v1/models?class=$type&make=$make';
    try {
      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode != 200) {
        throw 'There was some error communicating to server';
      }
      final extractedData = json.decode(response.body) as List;

      final List<String> loadedCategories = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((catData) {
        loadedCategories.add(catData);
      });
      _models = loadedCategories;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getListOfCarsFromLocal() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('vehicles')) {
        _vehicles.clear();
        List map = jsonDecode(prefs.get('vehicles'));
        map.forEach((element) {
          _vehicles.add(VehicleModel.fromJson(element));
        });
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addVehicleToListOfinLocal(Map<String, String> model) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('vehicles')) {
        _vehicles.clear();
        List map = jsonDecode(prefs.get('vehicles'));
        map.add(model);
        _vehicles.add(VehicleModel.fromJson(model));

        prefs.remove('vehicles');
        prefs.setString('vehicles', jsonEncode(map));
      } else {
        _vehicles.clear();
        List map = [];
        map.add(model);
        _vehicles.add(VehicleModel.fromJson(model));
        prefs.setString('vehicles', jsonEncode(map));
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  List<String> get makeOfCar {
    return [..._makers];
  }

  List<String> get modelOfCar {
    return [..._models];
  }

  List<VehicleModel> get vehicles {
    return [..._vehicles];
  }
}
