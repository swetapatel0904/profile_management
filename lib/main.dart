import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_management/screen/profile/provider/profile_provider.dart';
import 'package:profile_management/screen/profile/provider/provider2.dart';
import 'package:profile_management/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProfileProvider()),
        ChangeNotifierProvider.value(value: Provider2()),
      ],
      child: Consumer2<ProfileProvider, Provider2>(
        builder: (context, value, value2, child) {
          value2.getUi();
          value2.iosUi = value2.androidUi;
          value.getTheme();
          value.theme = value.isTheme;
          return value2.androidUi == false
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData.light(),
                  darkTheme: ThemeData.dark(),
                  themeMode: value.mode,
                  routes: app_route,
                )
              : CupertinoApp(
                  debugShowCheckedModeBanner: false,
                  routes: cupertino_approutes,
                );
        },
      ),
    ),
  );
}
