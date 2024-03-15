import 'package:flutter/cupertino.dart';

class SettingProvider with ChangeNotifier{
  bool isOn = false;
  List<String> profileList=[];
  void toggleUser()
  {
    isOn = !isOn;
    notifyListeners();
  }
}
