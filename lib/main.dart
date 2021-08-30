import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Insert your measurements";

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Insert your measurements";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculateBMI() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double bmi = weight / (height * height);

      _infoText = (bmi < 18.5
              ? "Underweight"
              : bmi >= 18.5 && bmi <= 24.9
                  ? "Normal"
                  : bmi > 24.9 && bmi <= 29.9
                      ? "Overweight"
                      : bmi > 29.9 && bmi <= 34.9
                          ? "Class I obesity"
                          : bmi > 34.9 && bmi <= 39.9
                              ? "Class II obesity"
                              : "Class III obesity") +
          " (${bmi.toStringAsPrecision(3)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("BMI Calculator"),
            centerTitle: true,
            backgroundColor: Colors.green,
            actions: <Widget>[
              IconButton(
                onPressed: _resetFields,
                icon: Icon(Icons.refresh),
              )
            ]),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.person_outline,
                          size: 120.0, color: Colors.green),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Weight (kg)",
                              labelStyle: TextStyle(color: Colors.green)),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.green, fontSize: 25.0),
                          controller: weightController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Insert your weight!";
                            }
                            return null;
                          }),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Height (cm)",
                              labelStyle: TextStyle(color: Colors.green)),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.green, fontSize: 25.0),
                          controller: heightController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Insert your height!";
                            }
                            return null;
                          }),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Container(
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _calculateBMI();
                                  }
                                },
                                child: Text(
                                  "Calculate!",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25.0),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
                              ))),
                      Text(
                        "$_infoText",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 25.0),
                      )
                    ]))));
  }
}
