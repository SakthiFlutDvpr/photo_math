import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class ProviderController extends ChangeNotifier {
  // bottom navbar index
  int index = 0;

  // calculator properties

  String actualInput = '';
  String parallelOutput = '';
  String actualOutput = '';

  // changing navbar index
  void changeIndex(int i) {
    index = i;
    notifyListeners();
  }

  // calculation methods

  void addInput(String newInput) {
    switch (newInput) {
      case 'c':
        newInput = '';
        parallelOutput = '';
        actualInput = '';
        actualOutput = '';

      case '-1':
        actualInput = actualInput.isNotEmpty
            ? actualInput.substring(0, actualInput.length - 1)
            : '';
        parallelOutput = parallelOutput.isNotEmpty
            ? parallelOutput.substring(0, parallelOutput.length - 1)
            : '';

      case '*':
        parallelOutput += 'x';
        actualInput += newInput;

      case '=':
        newInput = '';
        calculateResult();

      default:
        parallelOutput += newInput;
        actualInput += newInput;
    }

    notifyListeners();
  }

  void calculateResult() {
    Parser parser = Parser();
    Expression expression = parser.parse(actualInput);
    ContextModel model = ContextModel();
    double result = expression.evaluate(EvaluationType.REAL, model);
    actualOutput = result.toString();
  }
}