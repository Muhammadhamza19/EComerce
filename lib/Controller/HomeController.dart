import 'package:emart_app/Constant/MyExport.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  var currentnavIndex = 0.obs;
  var username = "";

  getUserName() async {
    var name = await firestore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = name;
  }
}
