import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_management/screen/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../profile/model/profile_model.dart';

class DetailIosScreen extends StatefulWidget {
  const DetailIosScreen({super.key});

  @override
  State<DetailIosScreen> createState() => _DetailIosScreenState();
}

class _DetailIosScreenState extends State<DetailIosScreen> {
  ProfileProvider? providerR;
  ProfileProvider? providerW;
  int index = 0;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ProfileProvider>();
    providerW = context.watch<ProfileProvider>();
    index = ModalRoute.of(context)!.settings.arguments as int;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Details"),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              providerW!.contactList[index].image!.isEmpty
                  ? Container(
                      height: 250,
                      width: MediaQuery.sizeOf(context).width,
                      color: CupertinoColors.tertiaryLabel,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:70),
                            child: CircleAvatar(
                              radius: 45,
                              child: Text(
                                  "${providerW!.contactList[index].name?.substring(0, 1)}",
                                  style: const TextStyle(fontSize: 35)),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("${providerW!.contactList[index].name}",
                              style: const TextStyle(fontSize: 20))
                        ],
                      ),

                    )
                  : Container(
                      height: 250,
                      width: MediaQuery.sizeOf(context).width,
                      color: CupertinoColors.tertiaryLabel,
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(
                                File("${providerW!.contactList[index].image}"),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("${providerW!.contactList[index].name}",
                              style: const TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left:20,right:20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mobile",
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                        Text(
                          "+91 ${providerW!.contactList[index].mobile}",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    IconButton.filledTonal(
                        onPressed: () async {
                          String link =
                              "tel:+91${providerW!.contactList[index].mobile}";
                          await launchUrl(Uri.parse(link));
                        },
                        icon: const Icon(CupertinoIcons.phone)),
                  ],
                ),
              ),
              CupertinoListSection(
                children: [
                  CupertinoListTile(
                    title: const Text("FaceTime", style: TextStyle(fontSize: 20)),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton.filledTonal(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.videocam_fill))
                      ],
                    ),
                  ),
                  CupertinoListTile(
                    title: const Text("Share Contact",
                        style: TextStyle(fontSize: 20)),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Share.share(
                                  "${providerW!.contactList[index].name}\n${providerW!.contactList[index].mobile}");
                            },
                            icon: const Icon(CupertinoIcons.share)),
                      ],
                    ),
                  ),
                  CupertinoListTile(
                    title: const Text("Edit Contact",
                        style: TextStyle(fontSize: 20)),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              dialog();
                            },
                            icon: const Icon(CupertinoIcons.eyedropper)),
                      ],
                    ),
                  ),
                  CupertinoListTile(
                    title: const Text("Delete Contact",
                        style: TextStyle(fontSize: 20)),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  title: const Text("Alert"),
                                  content:
                                      const Text("Are you sure you want to delete?"),
                                  actions: [
                                    CupertinoDialogAction(
                                        onPressed: () {
                                          providerR!.deleteContact(index);
                                          Navigator.pop(context);
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
                            },
                            icon: const Icon(CupertinoIcons.delete)),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void dialog()
  {
    txtMobile.text = providerR!.contactList[index].mobile!;
    txtEmail.text = providerR!.contactList[index].email!;
    txtName.text = providerR!.contactList[index].name!;
    providerR!.editI(providerR!.contactList[index].image!);
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Form(
            key: key,
            child: SingleChildScrollView(
              child: CupertinoAlertDialog(
                  title: Container(
                    width:MediaQuery.sizeOf(context).width * 0.85,
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
                              providerW!.editImage!.isEmpty
                                  ? const CircleAvatar(
                                radius: 50,
                              )
                                  : CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                FileImage(File(providerW!.editImage!)),
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
                                controller: txtName,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "name is required";
                                  }
                                  return null;
                                },
                                placeholder: "Name",
                                decoration: BoxDecoration(border: Border.all(color: CupertinoColors.activeBlue)),
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
                                decoration: BoxDecoration(border: Border.all(color: CupertinoColors.activeBlue)),
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
                                decoration: BoxDecoration(border: Border.all(color: CupertinoColors.activeBlue)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: CupertinoButton(
                                  onPressed: () {
                                    if (key.currentState!.validate()) {
                                      ProfileModel c4 = ProfileModel(
                                          name: txtName.text,
                                          mobile: txtMobile.text,
                                          image: providerR!.editImage!,
                                          email: txtEmail.text);
                                      providerR!.updateContact(i: index, c3: c4);
                                      txtName.clear();
                                      txtMobile.clear();
                                      txtEmail.clear();
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)!.showSnackBar(
                                          const SnackBar(
                                              content:
                                              Text("Your Contact is updated")));
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text("update",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 25,
                                      )),
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
  }

