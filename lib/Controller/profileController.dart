import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Constant/MyExport.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var selectedFile = RxList<Uint8List>();
  var nameController = TextEditingController();
  var newPassController = TextEditingController();
  var oldPassController = TextEditingController();

  var fileName = ''.obs;
  var isLoading = false.obs;
  var profileImageLink = '';
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    try {
      if (result != null && result.files.isNotEmpty) {
        String name = result.files.first.name;
        Uint8List fileBytes = result.files.first.bytes!;
        fileName.value = name;
        selectedFile.assign(fileBytes);

        //   // Handle the selected file as needed
      } else {
        // User canceled the file picking operation or no file was selected
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadfile() async {
    var destination = 'images/${currentUser!.uid}/$fileName';

    try {
      // Convert Uint8List to List<int>
      List<int> fileBytes = selectedFile.first.toList();

      // Upload the bytes to Firebase Storage using putData
      await FirebaseStorage.instance
          .ref(destination)
          .putData(Uint8List.fromList(fileBytes));

      // Get the download URL after the upload is successful
      profileImageLink =
          await FirebaseStorage.instance.ref(destination).getDownloadURL();
    } catch (e) {
      // Handle the error as needed
    }
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(userCollection).doc(currentUser!.uid);
    await store.set({'name': name, 'password': password, 'imageUrl': imgUrl},
        SetOptions(merge: true));
    isLoading(false);
  }

  changeAuthPassowrd({email, password, newpass}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPass);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
