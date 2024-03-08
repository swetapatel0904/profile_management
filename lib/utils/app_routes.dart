import 'package:flutter/material.dart';
import 'package:profile_management/screen/addContact/addContact_screen.dart';
import 'package:profile_management/screen/addContact/addContactios_screen.dart';
import 'package:profile_management/screen/home/homeios_screen.dart';
import 'package:profile_management/screen/splash/splash_screen.dart';


import '../screen/home/home_screen.dart';

Map<String, WidgetBuilder> app_route = {
  '/':(context) => SplashScreen(),
  'home': (context) => const HomeScreen(),
  'add_data': (context) => const AddContactScreen(),
};
Map <String, WidgetBuilder> cupertino_approutes={
  '/':(context) => SplashScreen(),
  'home':(context) => HomeiosScreen(),
  'add_data':(context) => AddContactiosScreen()
};