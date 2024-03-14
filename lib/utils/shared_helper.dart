import 'package:shared_preferences/shared_preferences.dart';

void saveTheme({required bool isTheme}) async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  shr.setBool("theme", isTheme);
}

Future<bool?> applyTheme() async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  return shr.getBool("theme");
}
void saveUi({required bool isUi}) async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  shr.setBool("ui", isUi);
}

Future<bool?> applyUi() async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  return shr.getBool("ui");
}
void saveAccount({required List <String> l1}) async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  shr.setStringList("ac", l1);
}

Future<List<String>?> getAccount() async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  return shr.getStringList("ac");
}