import 'package:emart_app/Constant/MyExport.dart';
import 'package:flutter/services.dart';

Widget exitdialog(context) {
  return Dialog(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
      const Divider(),
      10.heightBox,
      "Are You Sure You want to exit".text.size(18).color(darkFontGrey).make(),
      10.heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyButton(
              color: redColor,
              textcolor: whiteColor,
              title: "Yes",
              OnPress: () {
                SystemNavigator.pop();
              }),
          MyButton(
              color: redColor,
              textcolor: whiteColor,
              title: "No",
              OnPress: () {
                Navigator.pop(context);
              }),
        ],
      )
    ]).box.color(lightGrey).padding(const EdgeInsets.all(12)).rounded.make(),
  );
}
