import 'package:emart_app/Constant/MyExport.dart';

Widget orderStatus({IconData? icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    )
        .box
        .border(color: color)
        .roundedSM
        .padding(const EdgeInsets.all(4))
        .make(),
    trailing: SizedBox(
      width: 120,
      height: 100,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        "$title".text.color(darkFontGrey).make(),
        showDone
            ? const Icon(
                Icons.done,
                color: redColor,
              )
            : Container()
      ]),
    ),
  );
}
