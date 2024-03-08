// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  var heightController = TextEditingController();
  var weightController = TextEditingController();
  double? bmiResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Height (cm)'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Weight (kg)'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
              },
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 16.0),
            bmiResult != null
                ? Text('BMI: ${bmiResult!.toStringAsFixed(2)}')
                : Container(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                recalculateBMI();
              },
              child: Text('Recalculate BMI'),
            )
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    num? height = double.tryParse(heightController.text);
    num? weight = double.tryParse(weightController.text);

    if (height != null && weight != null && height > 0 && weight > 0) {
      double heightInMeters = height / 100;
      double bmi = weight / (heightInMeters * heightInMeters);

      setState(() {
        bmiResult = bmi;
      });
    } else {
      showErrorMessage("Please enter valid height and weight.");
    }
  }

  void recalculateBMI() {
    setState(() {
      bmiResult = null;
    });

    heightController.clear();
    weightController.clear();
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
