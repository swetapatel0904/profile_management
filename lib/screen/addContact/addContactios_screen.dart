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
  String path="";
  @override
  Widget build(BuildContext context) {
    providerR = context.read<ProfileProvider>();
    providerW = context.watch<ProfileProvider>();
    return  CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text("Add New Contacts")),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top:100),
            child: Column(
              children: [
                providerW!.path!.isEmpty
                    ?  CircleAvatar(
                  radius: 50,
                )
                    : CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  FileImage(File(providerW!.path)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  CupertinoButton(onPressed: () async {
                    ImagePicker picker = ImagePicker();
                    XFile? image = await picker.pickImage(
                        source: ImageSource.camera);
                    providerR!.addPath(image!.path);
                  },
                      child:Icon(CupertinoIcons.camera)),
                    CupertinoButton(onPressed: () async {
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
                      CupertinoTextField(
                        keyboardType: TextInputType.name,
                        controller: txtName,
                        placeholder: "Name",
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CupertinoTextField(
                        keyboardType: TextInputType.phone,
                        controller: txtMobile,
                        placeholder: "Phone Number",
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CupertinoTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: txtEmail,
                        placeholder: "email",
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: CupertinoButton(
                          onPressed: () {
                            if(key.currentState!.validate()) {
                              ProfileModel p2 = ProfileModel(
                                name: txtName.text,
                                mobile: txtMobile.text,
                                email: txtEmail.text,
                                image: providerR!.path,
                              );
                              providerR!.contactList.add(p2);
                              Navigator.pop(context);
                              providerW!.path="";
                            }
                          },
                          child: const Text("Save",
                              style: TextStyle(
                                color: CupertinoColors.activeBlue,
                                fontSize: 25,
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
