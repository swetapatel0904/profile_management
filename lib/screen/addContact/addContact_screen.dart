import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_management/screen/profile/model/profile_model.dart';
import 'package:profile_management/screen/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
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
    return Form(
      key: key,
      child: Scaffold(
        appBar: AppBar(title: Text("Add New Contact"),
        centerTitle: true,),
        body: SingleChildScrollView(
          child: Column(
            children: [
              providerW!.path!.isEmpty
                  ? const CircleAvatar(
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
                  IconButton(
                      onPressed: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? image = await picker.pickImage(
                            source: ImageSource.camera);
                        providerR!.addPath(image!.path);
                      },
                      icon: const Icon(Icons.camera)),
                  IconButton(
                      onPressed: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? image = await picker.pickImage(
                            source: ImageSource.gallery);
                        providerR!.addPath(image!.path);
                      },
                      icon: const Icon(Icons.image)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: txtName,
                      validator: (value) {
                        if (value!.isEmpty)
                        {
                          return "name is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter Name", border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: txtMobile,
                      validator: (value) {
                        if(value!.isEmpty)
                        {
                          return "mobile no. is required";
                        }
                        else if (value!.length!=10)
                        {
                          return "Enter the valid number";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter Mobile Number", border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: txtEmail,
                      validator: (value) {
                        if(value!.isEmpty)
                        {
                          return "Email is required ";
                        }
                        else if(!RegExp("^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$").hasMatch(value))
                        {
                          return "enter the valid email";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter Email id", border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () async{
                          DateTime? d1 = await showDatePicker(context: context, firstDate: DateTime(2020), lastDate: DateTime(2100));
                          providerR!.changeDate(d1!);
                        }, icon: Icon(Icons.calendar_month)),
                        Text("${providerR!.d1.day}-${providerR!.d1.month}-${providerR!.d1.year}")
                      ],
                    ),

                    Row(
                      children: [
                        IconButton(onPressed: () async{
                          TimeOfDay? t1 = await showTimePicker(context: context, initialTime: providerR!.t1);
                          TimeOfDay t2 = TimeOfDay(hour: t1!.hour, minute: t1!.minute);
                          providerR!.changeTime(t2!);
                        }, icon: Icon(Icons.timer)),
                        Text("${providerR!.t1.hour}:${providerR!.t1.minute}")
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
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
                              color: Colors.blue,
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
      ),
    );

  }
}

