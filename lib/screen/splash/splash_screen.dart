import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../profile/provider/ui_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),()=>Navigator.pushReplacementNamed(context, "home" ));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton.outlined(onPressed: () {}, icon: Icon(Icons.call,size: 80,)),
            SizedBox(height: 10,),
            Text("Contact App",style: TextStyle(fontSize: 20,color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
