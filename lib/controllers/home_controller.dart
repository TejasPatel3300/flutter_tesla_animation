import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  int selectedBottomTabIndex = 0;
  // we use HomeController for logical part

  // battery
  bool isRightDoorLock = true;
  bool isLeftDoorLock = true;
  bool isBonnetLock = true;
  bool isTrunkLock = true;

  // temperature
  bool isCoolTempSelected = true;

  // tyre
  bool isShowTyreController = false;
  bool isShowTyreStatus = false;

  void onSelectedBottomTabChange({required int index}) {
    if (selectedBottomTabIndex == index) {
      return;
    }
    selectedBottomTabIndex = index;
    notifyListeners();
  }

  // doors
  void updateRightDoorLock() {
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  void updateLeftDoorLock() {
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  void updateBonnetDoorLock() {
    isBonnetLock = !isBonnetLock;
    notifyListeners();
  }

  void updateTrunkDoorLock() {
    isTrunkLock = !isTrunkLock;
    notifyListeners();
  }

  // temperature
  void updateCoolTempSelected() {
    isCoolTempSelected = !isCoolTempSelected;
    notifyListeners();
  }

  // tyre
  void showTyreController(int index) {
    if (selectedBottomTabIndex != 3 && index == 3) {
      Future.delayed(const Duration(milliseconds: 400), () {
        isShowTyreController = true;
        notifyListeners();
      });
    } else {
      isShowTyreController = false;
      notifyListeners();
    }
  }

  void tyreStatusController(int index) {
    if (selectedBottomTabIndex != 3 && index == 3) {
      isShowTyreStatus = true;
      notifyListeners();
    } else {
      Future.delayed(
        const Duration(milliseconds: 800),
        () {
          isShowTyreStatus = false;
          notifyListeners();
        },
      );
    }
  }
}
