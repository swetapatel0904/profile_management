import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_management/screen/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../profile/provider/provider2.dart';

class SettingIosScreen extends StatefulWidget {
  const SettingIosScreen({super.key});

  @override
  State<SettingIosScreen> createState() => _SettingIosScreenState();
}

class _SettingIosScreenState extends State<SettingIosScreen> {
  Provider2? uiR;
  Provider2? uiW;
  ProfileProvider? providerR;
  ProfileProvider? providerW;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();


  @override
  Widget build(BuildContext context) {
    uiR = context.read<Provider2>();
    uiW = context.watch<Provider2>();
    providerR = context.read<ProfileProvider>();
    providerW = context.watch<ProfileProvider>();
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Settings"),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 100,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Switch"),
                  CupertinoSwitch(
                    value: uiW!.iosUi,
                    onChanged: (value) {
                      uiR!.setUi();
                    },
                  ),

                ],
              ),Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Theme"),
                  CupertinoButton(
                    onPressed: (){
                      providerR!.setTheme();
                      },
                    child: Icon(providerW!.isTheme==false?Icons.dark_mode:Icons.light_mode),
                  ),

                ],
              ),
          ]
        ),
        ));
  }


}
