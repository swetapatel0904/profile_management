import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashIosScreen extends StatefulWidget {
  const SplashIosScreen({super.key});

  @override
  State<SplashIosScreen> createState() => _SplashIosScreenState();
}

class _SplashIosScreenState extends State<SplashIosScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),()=>Navigator.pushReplacementNamed(context, 'ioshome' ));
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton.outlined(onPressed: () {}, icon: Icon(CupertinoIcons.phone,size: 80,)),
            SizedBox(height: 10,),
            Text("Contact App",style: TextStyle(fontSize: 20,color: Colors.blue)),
          ],
        ),
      ),
    );;
  }
}
