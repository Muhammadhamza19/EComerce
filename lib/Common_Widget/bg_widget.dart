import 'package:emart_app/Constant/MyExport.dart';

Widget bgWidget({Widget? child}) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Container(
      color: redColor,
      // decoration: const BoxDecoration(
      //     image: DecorationImage(
      //         image: AssetImage(imgBackground), fit: BoxFit.contain)),
      child: child,
    ),
  );
}
