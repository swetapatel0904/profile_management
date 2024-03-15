import 'package:flutter/material.dart';
import '../../../utils/shared_helper.dart';
import '../model/profile_model.dart';


class ProfileProvider with ChangeNotifier
{
  List<ProfileModel> contactList = [];
  String path = "";
  bool theme = false;
  String? editImage;
  ThemeMode mode = ThemeMode.light;
  bool isTheme = false;
  IconData themeMode = Icons.dark_mode;
  DateTime d1 = DateTime.now();
  TimeOfDay t1 = TimeOfDay.now();
  void setAccount(List<String> l1)
  {
    saveAccount(l1: l1);
    notifyListeners();
  }
  void changeDate(DateTime d2)
  {
    d1=d2;
    notifyListeners();
  }
  void changeTime(TimeOfDay t2)
  {
    t1=t2;
    notifyListeners();
  }


  void setTheme() async {
    theme = !theme;
    saveTheme(isTheme: theme);
    isTheme = (await applyTheme())!;
    if (isTheme == true) {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (isTheme == false) {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    } else {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    }
    notifyListeners();
  }

  void getTheme() async {
    if (await applyTheme() == null) {
      isTheme = false;
    } else {
      isTheme = (await applyTheme())!;
    }
    if (isTheme == true) {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (isTheme == false) {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    } else {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    }
    notifyListeners();
  }

  void addPath(String p1) {
    path = p1;
    notifyListeners();
  }

  void addContact(ProfileModel c1) {
    contactList.add(c1);
    notifyListeners();
  }

  void deleteContact(int i) {
    contactList.removeAt(i);
    notifyListeners();
  }

  void updateContact({required int i, required ProfileModel c3}) {
    contactList[i] = c3;
    notifyListeners();
  }

  void editI(String i) {
    editImage = i;
    notifyListeners();
  }

  void editPath(String p1) {
    editImage = p1;
    notifyListeners();
  }
}