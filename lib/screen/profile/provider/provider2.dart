import 'package:flutter/cupertino.dart';

import '../../../utils/shared_helper.dart';

class Provider2 with ChangeNotifier{
  bool iosUi=false;
  bool androidUi=false;
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

}