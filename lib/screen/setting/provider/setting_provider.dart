import 'package:flutter/cupertino.dart';
import 'package:profile_management/utils/shared_helper.dart';

class SettingProvider with ChangeNotifier{
  bool isOn = false;
  List<String> profileList=[];
  String image="";
  String editImage="";
  void toggleUser()
  {
    isOn = !isOn;
    notifyListeners();
  }
  void createUserAccount(List <String> l1)
  async{
    saveAccount(l1: l1);
    profileList=(await getAccount())!;
    notifyListeners();
  }
  void createIm(String s1)
  {
    image =s1;
    notifyListeners();
  }
  void editUserAccount(List <String> l1)
  async{
    saveAccount(l1: l1);
    profileList=(await getAccount())!;
    notifyListeners();
  }
  void editIm(String p1)
  {
    editImage = p1;
    notifyListeners();
  }
  void getprofileList()
  async{
    if(await getAccount()==null)
      {
        profileList=[];
      }
    else
      {
        profileList=(await getAccount())!;
      }
    notifyListeners();
  }

}
