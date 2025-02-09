import 'dart:ffi';

import 'package:calculator_flutter/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'calc_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  var screenValue = '';
  String? operator = '';
  double? firstOperand;

  void onNumberPress(String number) {
    setState(() {
      if (screenValue == '0') {
        screenValue = number;
      } else {
        screenValue += number;
      }
    });
  }

  void onOperatorPress(String newOperator) {
    setState(() {
      if (screenValue.isNotEmpty) {
        firstOperand = double.tryParse(screenValue);
        operator = newOperator;
        screenValue = '';
      }
    });
  }

  void calculateResult() {
    if (firstOperand != null && screenValue.isNotEmpty) {
      double secondOperand = double.tryParse(screenValue) ?? 0;
      double result = 0;
      switch (operator) {
        case '+':
          result = firstOperand! + secondOperand;
          break;
        case '-':
          result = firstOperand! - secondOperand;
          break;
        case 'X':
          result = firstOperand! * secondOperand;
          break;
        case '/':
          result = secondOperand != 0 ? firstOperand! / secondOperand : 0;
          break;
      }
      setState(() {
        screenValue = (result % 1 == 0) ? result.toInt().toString() : result.toString();
        firstOperand = null;
        operator = null;
      });
    }
  }

  void clearScreen() {
    setState(() {
      screenValue = '0';
      firstOperand = null;
      operator = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 37),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 35),
                        child: Text(
                          screenValue,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 56,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      CalcButton(text: 'C', color: AppColors.grey, onTap: clearScreen),
                      const SizedBox(width: 10,),
                      CalcButton(text: '+/-', color: AppColors.grey,),
                      const SizedBox(width: 10,),
                      CalcButton(text: '%', color: AppColors.grey,),
                      const SizedBox(width: 10,),
                      CalcButton(text: '/', isActionColor: true, onTap: () => onOperatorPress('/')),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      CalcButton(text: '7', onTap: () => onNumberPress('7')),
                      const SizedBox(width: 10,),
                      CalcButton(text: '8', onTap: () => onNumberPress('8')),
                      const SizedBox(width: 10,),
                      CalcButton(text: '9', onTap: () => onNumberPress('9')),
                      const SizedBox(width: 10,),
                      CalcButton(text: 'X', isActionColor: true, onTap: () => onOperatorPress('X')),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      CalcButton(text: '4', onTap: () => onNumberPress('4')),
                      const SizedBox(width: 10,),
                      CalcButton(text: '5', onTap: () => onNumberPress('5')),
                      const SizedBox(width: 10,),
                      CalcButton(text: '6', onTap: () => onNumberPress('6')),
                      const SizedBox(width: 10,),
                      CalcButton(text: '-', isActionColor: true, onTap: () => onOperatorPress('-')),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      CalcButton(text: '3', onTap: () => onNumberPress('3')),
                      const SizedBox(width: 10,),
                      CalcButton(text: '2', onTap: () => onNumberPress('2')),
                      const SizedBox(width: 10,),
                      CalcButton(text: '1', onTap: () => onNumberPress('1')),
                      const SizedBox(width: 10,),
                      CalcButton(text: '+', isActionColor: true, onTap: () => onOperatorPress('+')),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      CalcButton(text: '0', flex: 2, onTap: () => onNumberPress('0')),
                      const SizedBox(width: 10,),
                      CalcButton(text: '.', onTap: () => onNumberPress('.')),
                      const SizedBox(width: 10,),
                      CalcButton(text: '=', isActionColor: true, onTap: calculateResult),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
