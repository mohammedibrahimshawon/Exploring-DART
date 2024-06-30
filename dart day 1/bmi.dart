import 'dart:io';

void main() {
  print('Enter your weight in kilograms: ');
  double weight = double.parse(stdin.readLineSync()!);

  print('Enter your height in meters: ');
  double height = double.parse(stdin.readLineSync()!);

  double bmi = calculateBMI(weight, height);
  print('Your BMI is: ${bmi.toStringAsFixed(2)}');

  String interpretation = interpretBMI(bmi);
  print('Interpretation: $interpretation');
}

double calculateBMI(double weight, double height) {
  return weight / (height * height);
}

String interpretBMI(double bmi) {
  if (bmi < 18.5) {
    return 'Underweight';
  } else if (bmi >= 18.5 && bmi < 24.9) {
    return 'Normal weight';
  } else if (bmi >= 25 && bmi < 29.9) {
    return 'Overweight';
  } else {
    return 'Obesity';
  }
}
