import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/View/Categories/CategoryDetail.dart';

Widget FeatureButton({String? title, icon, data}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .white
      .padding(const EdgeInsets.all(2))
      .make()
      .onTap(() {
    Get.put(ProductController()).getCategories(data);
    Get.to(() => Categorydetail(
          title: title,
        ));
  });
}
