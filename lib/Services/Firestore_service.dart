import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/Constant/firebase_const.dart';

class FireStoreService {
  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getSubCategoryProducts(title) {
    return firestore
        .collection(productsCollection)
        .where('p_subCategory', isEqualTo: title)
        .snapshots();
  }

  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getCarts(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deletItems(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getChatsMessage(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection(orderCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Object?>> getWishLists() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessage() {
    return firestore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productsCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(orderCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

  static allFeaturedProducts() {
    return firestore
        .collection(productsCollection)
        .where('isFeatured', isEqualTo: true)
        .get();
  }

  static searchProducts({title}) {
    return firestore
        .collection(productsCollection)
        .where('p_name', isLessThanOrEqualTo: title)
        .get();
  }
}
