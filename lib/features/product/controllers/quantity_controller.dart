import 'package:flutter/material.dart';

class QuantityController extends ChangeNotifier {
  int quantity = 1;

  void increase() {
    quantity++;
    notifyListeners();
  }

  void decrease() {
    if (quantity == 1) return;

    quantity--;
    notifyListeners();
  }
}