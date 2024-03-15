import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_management/screen/profile/provider/profile_provider.dart';
import 'package:profile_management/screen/setting/provider/setting_provider.dart';
import 'package:provider/provider.dart';

import '../profile/model/profile_model.dart';
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
    settingR = context.read<SettingProvider>();
    settingW = context.watch<SettingProvider>();
    settingR!.getprofileList();
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
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(
              height: 100,
            ),
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
                  onPressed: () {
                    providerR!.setTheme();
                  },
                  child: Icon(providerW!.isTheme == false
                      ? Icons.dark_mode
                      : Icons.light_mode),
                ),
              ],
            ),
            CupertinoListTile(
              title: const Text("User Profile"),
              trailing: CupertinoSwitch(
                value: settingR!.isOn,
                onChanged: (value) {
                  settingR!.toggleUser();
                },
              ),
            ),
            Visibility(
                visible: settingW!.isOn,
                child: settingW!.profileList.isEmpty
                    ? Column(
                        children: [
                          const Text("NO ACCOUNT FOUND"),
                          const SizedBox(
                            height: 10,
                          ),
                          CupertinoButton(
                              child: const Text("Create user account"),
                              onPressed: () {
                                createAccount();
                              })
                        ],
                      )
                    : Column(
                        children: [
                          settingW!.profileList[0].isNotEmpty
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      FileImage(File(settingW!.profileList[0])),
                                )
                              : const CircleAvatar(
                                  radius: 50,
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("${settingW!.profileList[1]}",
                              style: const TextStyle(fontSize: 30)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("${settingW!.profileList[2]}",
                              style: const TextStyle(fontSize: 30)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("${settingW!.profileList[3]}",
                              style: const TextStyle(fontSize: 30)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoButton(
                                  child: const Text("Edit"),
                                  onPressed: () {
                                    editAccount();
                                  }),
                              CupertinoButton(
                                  child: const Text("Delete"),
                                  onPressed: () {
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                        title: const Text("Alert"),
                                        content: const Text(
                                            "Are you sure you want to delete?"),
                                        actions: [
                                          CupertinoDialogAction(
                                              onPressed: () {
                                                List<String> l1 = [];
                                                settingR!.createUserAccount(l1);
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Yes")),
                                          CupertinoDialogAction(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("No"),
                                            isDestructiveAction: true,
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ],
                          )
                        ],
                      ))
          ]),
        ));
  }

  void createAccount() {
    txtName.clear();
    txtMobile.clear();
    txtEmail.clear();
    settingR!.createIm("");
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Form(
            key: key,
            child: SingleChildScrollView(
              child: CupertinoAlertDialog(
                  title: Container(
                width: MediaQuery.sizeOf(context).width * 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 20),
                        child: Stack(alignment: Alignment.center, children: [
                          settingW!.image.isEmpty
                              ? const CircleAvatar(
                                  radius: 50,
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      FileImage(File(settingW!.image!)),
                                ),
                        ]),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoButton(
                            onPressed: () async {
                              ImagePicker picker = ImagePicker();
                              XFile? image = await picker.pickImage(
                                  source: ImageSource.camera);
                              settingR!.createIm(image!.path);
                            },
                            child: const Icon(CupertinoIcons.camera)),
                        CupertinoButton(
                            onPressed: () async {
                              ImagePicker picker = ImagePicker();
                              XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              settingR!.createIm(image!.path);
                            },
                            child: const Icon(CupertinoIcons.photo))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CupertinoTextFormFieldRow(
                            controller: txtName,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "name is required";
                              }
                              return null;
                            },
                            placeholder: "Name",
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: CupertinoColors.activeBlue)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CupertinoTextFormFieldRow(
                            controller: txtMobile,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "mobile no. is required";
                              } else if (value!.length != 10) {
                                return "Enter the valid number";
                              }
                              return null;
                            },
                            placeholder: "Mobile Number",
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: CupertinoColors.activeBlue)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CupertinoTextFormFieldRow(
                            controller: txtEmail,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is required ";
                              } else if (!RegExp(
                                      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                                  .hasMatch(value)) {
                                return "enter the valid email";
                              }
                              return null;
                            },
                            placeholder: "Email",
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: CupertinoColors.activeBlue)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: CupertinoButton(
                              child: const Text("Save"),
                              onPressed: () {
                                if (key.currentState!.validate()) {
                                  List<String> l1 = [];
                                  l1.add(settingW!.image);
                                  l1.add(txtName.text);
                                  l1.add(txtMobile.text);
                                  l1.add(txtEmail.text);
                                  settingR!.createUserAccount(l1);
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
        });
  }

  void editAccount() {
    settingR!.editIm(settingW!.profileList[0]);
    txtName.text = settingW!.profileList[1];
    txtMobile.text = settingW!.profileList[2];
    txtEmail.text = settingW!.profileList[3];
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Form(
            key: key,
            child: SingleChildScrollView(
              child: CupertinoAlertDialog(
                  title: Container(
                width: MediaQuery.sizeOf(context).width * 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 20),
                        child: Stack(alignment: Alignment.center, children: [
                          settingW!.editImage.isEmpty
                              ? const CircleAvatar(
                                  radius: 50,
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      FileImage(File(settingW!.editImage!)),
                                ),
                        ]),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoButton(
                            onPressed: () async {
                              ImagePicker picker = ImagePicker();
                              XFile? image = await picker.pickImage(
                                  source: ImageSource.camera);
                              settingR!.editIm(image!.path);
                            },
                            child: const Icon(CupertinoIcons.camera)),
                        CupertinoButton(
                            onPressed: () async {
                              ImagePicker picker = ImagePicker();
                              XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              settingR!.editIm(image!.path);
                            },
                            child: const Icon(CupertinoIcons.photo))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CupertinoTextFormFieldRow(
                            controller: txtName,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "name is required";
                              }
                              return null;
                            },
                            placeholder: "Name",
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: CupertinoColors.activeBlue)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CupertinoTextFormFieldRow(
                            controller: txtMobile,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "mobile no. is required";
                              } else if (value!.length != 10) {
                                return "Enter the valid number";
                              }
                              return null;
                            },
                            placeholder: "Mobile Number",
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: CupertinoColors.activeBlue)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CupertinoTextFormFieldRow(
                            controller: txtEmail,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is required ";
                              } else if (!RegExp(
                                      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                                  .hasMatch(value)) {
                                return "enter the valid email";
                              }
                              return null;
                            },
                            placeholder: "Email",
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: CupertinoColors.activeBlue)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: CupertinoButton(
                            child: const Text("Update"),
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                List<String> p1 = [];
                                p1.add(settingW!.editImage);
                                p1.add(txtName.text);
                                p1.add(txtMobile.text);
                                p1.add(txtEmail.text);
                                settingR!.editUserAccount(p1);
                                Navigator.pop(context);
                              }
                            },
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
        });
  }
}
