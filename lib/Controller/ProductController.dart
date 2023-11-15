import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/Models/category_model.dart';
import 'package:flutter/services.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var changeColorIndexvalue = 0.obs;
  var totalprice = 0.obs;
  var subcat = [];
  getCategories(title) async {
    subcat.clear();
    var data =
        await rootBundle.loadString("lib/Services/categories_model.json");

    var decoded = categoryModelFromJson(data);

    var s = decoded.categories.where((element) {
      return element.name == title;
    }).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    changeColorIndexvalue.value = index;
    update();
  }

  increaseQuantitiy(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
    update();
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
    update();
  }

  calculateTotalPrice(price) {
    totalprice.value = price * quantity.value;
    update();
  }

  addtoCart({title, img, sellerName, color, qty, tprice, context}) async {
    await firestore
        .collection(cartCollection)
        .doc()
        .set(({
          'title': title,
          'img': img,
          'sellerName': sellerName,
          'color': color,
          'qty': qty,
          'tprice': tprice,
          'added_by': currentUser!.uid
        }))
        .catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    totalprice.value = 0;
    quantity.value = 0;
    changeColorIndexvalue.value = 0;
  }
}
