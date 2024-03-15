import 'dart:io';

import 'package:flutter/material.dart';
import 'package:profile_management/screen/profile/provider/profile_provider.dart';
import 'package:profile_management/screen/profile/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

    return Scaffold(
      appBar:
          AppBar(title: const Text("Contacts"), centerTitle: true, actions: [
        Switch(
          value: uiW!.iosUi,
          onChanged: (value) {
            uiR!.setUi();
          },
        ),
        PopupMenuButton(itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () {
                providerR!.setTheme();
              },
              child: Text("Mode"),
            ),
          ];
        }),
            InkWell(onTap: (){
              Navigator.pushNamed(context, 'setting');
            },child: Icon(Icons.settings))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: providerR!.contactList.length,
          itemBuilder: (context, index) => Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'details', arguments: index);
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
                            radius: 30,
                            backgroundImage: FileImage(
                                File("${providerW!.contactList[index].image}")),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${providerW!.contactList[index].name}",
                                  style: const TextStyle(fontSize: 20)),
                              Text("${providerW!.contactList[index].mobile}",
                                  style: const TextStyle(fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.pushNamed(context, 'add_data').then((value) {
              setState(() {});
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
