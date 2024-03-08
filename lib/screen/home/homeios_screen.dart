import 'package:flutter/cupertino.dart';
import 'package:profile_management/screen/profile/provider/profile_provider.dart';
import 'package:profile_management/screen/profile/provider/provider2.dart';
import 'package:provider/provider.dart';

class HomeiosScreen extends StatefulWidget {
  const HomeiosScreen({super.key});

  @override
  State<HomeiosScreen> createState() => _HomeiosScreenState();
}

class _HomeiosScreenState extends State<HomeiosScreen> {
  ProfileProvider? providerR;
  ProfileProvider? providerW;
  Provider2? uiR;
  Provider2? uiW;
  @override
  Widget build(BuildContext context) {
    providerR = context.read<ProfileProvider>();
    providerW = context.watch<ProfileProvider>();
    uiR = context.read<Provider2>();
    uiW = context.watch<Provider2>();
    return CupertinoPageScaffold(
      child: Center(),
      navigationBar: CupertinoNavigationBar(
          middle: Text("iOS"),
          trailing: CupertinoSwitch(value:uiW!.iosUi ,onChanged: (value) {
            uiR!.setUi();
          },
          )
      ),

    );
  }
}
