import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_management/screen/profile/provider/profile_provider.dart';
import 'package:profile_management/screen/profile/provider/ui_provider.dart';
import 'package:profile_management/screen/setting/provider/setting_provider.dart';
import 'package:profile_management/utils/app_routes.dart';
import 'package:profile_management/utils/ios_theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProfileProvider()),
        ChangeNotifierProvider.value(value: UiProvider()),
        ChangeNotifierProvider.value(value: SettingProvider()),
      ],
      child: Consumer2<ProfileProvider, UiProvider>(
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
            theme: value.isTheme?dark:light,
                );
        },
      ),
    ),
  );
}
