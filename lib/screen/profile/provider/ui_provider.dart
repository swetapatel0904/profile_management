import 'package:flutter/cupertino.dart';

import '../../../utils/shared_helper.dart';

class UiProvider with ChangeNotifier{
  bool iosUi=false;
  bool androidUi=false;
  bool isLight = true;
  void setUi()
  async {
    iosUi=!iosUi;
    saveUi(isUi: iosUi);
    androidUi=(await applyUi())!;
    notifyListeners();
  }
  void getUi()
  async{
    if(await applyUi()==null)
    {
      androidUi=false;
    }
    else
    {
      androidUi=(await applyUi())!;
    }
    notifyListeners();
  }
  void changeTheme()
  {
    isLight=!isLight;
    notifyListeners();
  }

}