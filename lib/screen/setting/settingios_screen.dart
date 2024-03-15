import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_management/screen/profile/provider/profile_provider.dart';
import 'package:profile_management/screen/setting/provider/setting_provider.dart';
import 'package:provider/provider.dart';

import '../profile/provider/ui_provider.dart';

class SettingIosScreen extends StatefulWidget {
  const SettingIosScreen({super.key});

  @override
  State<SettingIosScreen> createState() => _SettingIosScreenState();
}

class _SettingIosScreenState extends State<SettingIosScreen> {
  UiProvider? uiR;
  UiProvider? uiW;
  SettingProvider? settingR;
  SettingProvider? settingW;
  ProfileProvider? providerR;
  ProfileProvider? providerW;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();


  @override
  Widget build(BuildContext context) {
    settingR =context.read<SettingProvider>();
    settingW =context.watch<SettingProvider>();
    uiR = context.read<UiProvider>();
    uiW = context.watch<UiProvider>();
    providerR = context.read<ProfileProvider>();
    providerW = context.watch<ProfileProvider>();
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Settings"),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Switch"),
                  CupertinoSwitch(
                    value: uiW!.iosUi,
                    onChanged: (value) {
                      uiR!.setUi();
                    },
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Theme"),
                  CupertinoButton(
                    onPressed: (){
                      providerR!.setTheme();
                      },
                    child: Icon(providerW!.isTheme==false?Icons.dark_mode:Icons.light_mode),
                  ),
                ],
              ),
              CupertinoListTile(title: Text("User Profile"),trailing: CupertinoSwitch(value: settingR!.isOn,onChanged: (value) {
                settingR!.toggleUser();
              },),),
              Visibility(
                visible: settingW!.isOn,
                child:settingW!.profileList.isEmpty? Column(
                  children: [
                    Text("NO ACCOUNT FOUND"),
                    
                  ],
                ):
                Column(
                  children: [
                    
                  ],
                )
                
              )
          ]
        ),
        ));
  }


}
