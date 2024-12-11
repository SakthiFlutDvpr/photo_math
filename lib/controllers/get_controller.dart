import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class GetController extends GetxController {
  ScrollController scrollController = ScrollController();

  // image uploading properties

  Rx<File> imgFile = File('').obs;

  RxString actualInput = ''.obs;
  RxString parallelOutput = ''.obs;
  RxString actualOutput = ''.obs;

  pickImageFile(File file) {
    imgFile.value = file;
  }

  // calculator properties

  void addInput(String newInput) {
    switch (newInput) {
      case 'c':
        newInput = '';
        parallelOutput.value = '';
        actualInput.value = '';
        actualOutput.value = '';

      case '-1':
        actualInput.value = actualInput.isNotEmpty
            ? actualInput.substring(0, actualInput.value.length - 1)
            : '';
        parallelOutput.value = parallelOutput.isNotEmpty
            ? parallelOutput.substring(0, parallelOutput.value.length - 1)
            : '';

      case '*':
        parallelOutput.value += 'x';
        actualInput.value += newInput;

      case '=':
        newInput = '';
        calculateResult();

      default:
        parallelOutput.value += newInput;
        actualInput.value += newInput;
        scrollToEnd();
    }
  }

  void calculateResult() {
    Parser parser = Parser();
    Expression expression = parser.parse(actualInput.value);
    ContextModel model = ContextModel();
    double result = expression.evaluate(EvaluationType.REAL, model);

    if (result % 1 == 0) {
      actualOutput.value = (result.toInt()).toString();
    } else {
      actualOutput.value = result.toString();
    }
  }

  void scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    });
  }
}
