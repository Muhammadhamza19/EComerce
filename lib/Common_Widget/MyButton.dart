import 'package:emart_app/Constant/MyExport.dart';

Widget MyButton({OnPress, String? title, color, textcolor}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color, padding: const EdgeInsets.all(12)),
      onPressed: OnPress,
      child: title!.text.color(textcolor).fontFamily(bold).make());
}
