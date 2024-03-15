import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_management/screen/profile/provider/profile_provider.dart';
import 'package:profile_management/screen/profile/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class HomeiosScreen extends StatefulWidget {
  const HomeiosScreen({super.key});

  @override
  State<HomeiosScreen> createState() => _HomeiosScreenState();
}

class _HomeiosScreenState extends State<HomeiosScreen> {
  ProfileProvider? providerR;
  ProfileProvider? providerW;
  UiProvider? uiR;
  UiProvider? uiW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ProfileProvider>();
    providerW = context.watch<ProfileProvider>();
    uiR = context.read<UiProvider>();
    uiW = context.watch<UiProvider>();
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: const Text("Contacts"),
            trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'iosadd_data');
                      },
                      child: Icon(CupertinoIcons.add)),
                  SizedBox(width: 20,),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'iossetting');
                      },
                      child: Icon(CupertinoIcons.settings)),
                ])),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: providerR!.contactList.length,
                itemBuilder: (context, index) => Column(children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'iosdetail',
                                arguments: index);
                          },
                          child: Container(
                            height: 80,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: FileImage(File(
                                          "${providerW!.contactList[index].image}")),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${providerW!.contactList[index].name}",
                                            style:
                                                const TextStyle(fontSize: 25)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                    ]))));
  }
}
