import 'package:flutter/widgets.dart';

/// using the mixin concept of dart that we have discussed
/// in our previous chapter
class CountingTheNumber with ChangeNotifier {
  int value = 0;
  void increaseValue() {
    value++;
    notifyListeners();
  }

  void decreaseValue() {
    value--;
    notifyListeners();
  }
}
