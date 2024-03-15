import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../profile/model/profile_model.dart';
import '../profile/provider/profile_provider.dart';

class AddContactiosScreen extends StatefulWidget {
  const AddContactiosScreen({super.key});

  @override
  State<AddContactiosScreen> createState() => _AddContactiosScreenState();
}

class _AddContactiosScreenState extends State<AddContactiosScreen> {
  ProfileProvider? providerR;
  ProfileProvider? providerW;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  String path = "";

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ProfileProvider>();
    providerW = context.watch<ProfileProvider>();
    return Form(
      key: key,
      child: CupertinoPageScaffold(
          navigationBar:
          CupertinoNavigationBar(middle: Text("Add New Contacts")),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  providerW!.path!.isEmpty
                      ? CircleAvatar(
                    radius: 50,
                  )
                      : CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(File(providerW!.path)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                          onPressed: () async {
                            ImagePicker picker = ImagePicker();
                            XFile? image = await picker.pickImage(
                                source: ImageSource.camera);
                            providerR!.addPath(image!.path);
                          },
                          child: Icon(CupertinoIcons.camera)),
                      CupertinoButton(
                          onPressed: () async {
                            ImagePicker picker = ImagePicker();
                            XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            providerR!.addPath(image!.path);
                          },
                          child: Icon(CupertinoIcons.photo))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CupertinoTextFormFieldRow(
                          keyboardType: TextInputType.name,
                          controller: txtName,
                          placeholder: "Name",

                          validator: (value) {
                            if (value!.isEmpty) {
                              return "name is required";
                            }
                            return null;
                          },
                          decoration: BoxDecoration(border:Border.all(color: CupertinoColors.activeBlue)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CupertinoTextFormFieldRow(
                          keyboardType: TextInputType.phone,
                          controller: txtMobile,
                          placeholder: "Phone Number",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "mobile number is required";
                            } else if (value!.length != 10) {
                              return "enter the valid number";
                            }
                            return null;
                          },
                          decoration: BoxDecoration(border:Border.all(color: CupertinoColors.activeBlue)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CupertinoTextFormFieldRow(
                          keyboardType: TextInputType.emailAddress,
                          controller: txtEmail,
                          placeholder: "email",
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
                          decoration: BoxDecoration(border:Border.all(color: CupertinoColors.activeBlue)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) =>
                                        Container(
                                          height: 200,
                                          child: CupertinoDatePicker(
                                            initialDateTime: providerR!.d1,
                                            mode: CupertinoDatePickerMode.date,
                                            onDateTimeChanged: (value) {
                                              providerR!.changeDate(value);
                                            },
                                          ),
                                        ),
                                  );
                                },
                                icon: Icon(CupertinoIcons.calendar)),
                            Text(
                                "${providerR!.d1.day}-${providerR!.d1
                                    .month}-${providerR!.d1.year}")
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) =>
                                        Container(
                                          height: 200,
                                          child: CupertinoDatePicker(
                                            initialDateTime: DateTime.now(),
                                            mode: CupertinoDatePickerMode.time,
                                            onDateTimeChanged: (value) {
                                              TimeOfDay? t1 = TimeOfDay(hour: value.hour, minute: value.minute);
                                              providerR!.changeTime(t1!);
                                            },
                                          ),
                                        ),
                                  );
                                  },
                                icon: Icon(CupertinoIcons.timer)),
                            Text(
                                "${providerW!.t1.hour}:${providerW!.t1.minute}")
                          ],
                        ),
                        Center(
                          child: CupertinoButton(
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                ProfileModel p2 = ProfileModel(
                                  name: txtName.text,
                                  mobile: txtMobile.text,
                                  email: txtEmail.text,
                                  image: providerR!.path,
                                );
                                providerR!.contactList.add(p2);
                                Navigator.pop(context);
                                providerW!.path = "";
                              }
                            },
                            child: const Text("Save",
                                style: TextStyle(
                                  color: CupertinoColors.activeBlue,
                                  fontSize: 25,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
