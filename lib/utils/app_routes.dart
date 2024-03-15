import 'package:flutter/material.dart';
import 'package:profile_management/screen/addContact/addContact_screen.dart';
import 'package:profile_management/screen/addContact/addContactios_screen.dart';
import 'package:profile_management/screen/detail/detail_screen.dart';
import 'package:profile_management/screen/detail/detailios_screen.dart';
import 'package:profile_management/screen/home/homeios_screen.dart';
import 'package:profile_management/screen/setting/settingios_screen.dart';
import 'package:profile_management/screen/splash/splashiosScreen.dart';
import 'package:profile_management/screen/splash/splash_screen.dart';
import '../screen/home/home_screen.dart';
import '../screen/setting/setting_screen.dart';

Map<String, WidgetBuilder> app_route = {
  '/':(context) => SplashScreen(),
  'home': (context) => const HomeScreen(),
  'setting':(context) => SettingScreen(),
  'add_data': (context) => const AddContactScreen(),
  'details':(context) => DetailScreen(),

};
Map <String, WidgetBuilder> cupertino_approutes={
  '/':(context) => SplashIosScreen(),
  'ioshome':(context) => HomeiosScreen(),
  'iosadd_data':(context) => AddContactiosScreen(),
  'iosdetail':(context) => DetailIosScreen(),
  'iossetting':(context) => SettingIosScreen(),

};