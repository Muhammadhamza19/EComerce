import 'package:emart_app/Constant/MyExport.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var changeColorIndexvalue = 0.obs;
  var totalprice = 0.obs;
  var subcat = [];
  var isfav = false.obs;
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

  addtoCart(
      {title, img, sellerName, color, qty, tprice, context, vendorID}) async {
    await firestore
        .collection(cartCollection)
        .doc()
        .set(({
          'title': title,
          'img': img,
          'sellerName': sellerName,
          'vendor_id': vendorID,
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

  addtowishList(docid, context) async {
    await firestore.collection(productsCollection).doc(docid).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isfav(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  removefromwishList(docid, context) async {
    await firestore.collection(productsCollection).doc(docid).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));

    isfav(false);
    VxToast.show(context, msg: "Removed to wishlist");
  }

  checkIffav(data) async {
    if (await data['p_wishlist'].contains(currentUser!.uid)) {
      isfav(true);
    } else {
      isfav(false);
    }
  }
}
