import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:turbo_care/screens/select_make_screen.dart';

class NewVehicleScreen extends StatefulWidget {
  static final routeName = '/new-vehicle-screen';
  @override
  _NewVehicleScreenState createState() => _NewVehicleScreenState();
}

class _NewVehicleScreenState extends State<NewVehicleScreen> {
  var _numberNode = FocusNode();
  var _numberController = TextEditingController();
  var _vehicleType = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new vehicle profile'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_numberController.text == '') {
            Toast.show('Please enter vehicle number', context,
                gravity: Toast.CENTER);
            return;
          }
          if (_vehicleType == '') {
            Toast.show('Please enter vehicle type', context,
                gravity: Toast.CENTER);
            return;
          }

          Map<String, String> vehicleDetails = {
            'type': _vehicleType,
            'numberOfVehicle': _numberController.text
          };
          Navigator.of(context)
              .pushNamed(SelectMakeScreen.routeName, arguments: vehicleDetails);
        },
        child: Icon(Icons.keyboard_arrow_right),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 60,
              child: TextField(
                keyboardType: TextInputType.name,
                maxLines: 1,
                focusNode: _numberNode,
                textInputAction: TextInputAction.next,
                controller: _numberController,
                decoration: InputDecoration(
                    labelText: 'VEHICLE NUMBER',
                    hintText: 'VEHICLE NUMBER',
                    alignLabelWithHint: true,
                    hintStyle: const TextStyle(
                        color: const Color(0xffb6c5d1),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: const TextStyle(
                      color: const Color(0xff0d3f67),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    )),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              )),
          SizedBox(height: 20),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Radio(
                value: '2w',
                groupValue: _vehicleType,
                onChanged: (type) {
                  setState(() {
                    _vehicleType = type;
                  });
                },
              ),
              new Text(
                '2 wheeler',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: '4w',
                groupValue: _vehicleType,
                onChanged: (type) {
                  setState(() {
                    _vehicleType = type;
                  });
                },
              ),
              new Text(
                '4 wheeler',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
