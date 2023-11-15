import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/Controller/ProductController.dart';
import 'package:emart_app/View/Categories/CategoryDetail.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 200),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Image.asset(
                  categoriesImages[index],
                  height: 120,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                10.heightBox,
                categorieslist[index]
                    .text
                    .color(darkFontGrey)
                    .align(TextAlign.center)
                    .make()
              ],
            )
                .box
                .white
                .rounded
                .clip(Clip.antiAlias)
                .outerShadow
                .make()
                .onTap(() {
              controller.getCategories(categorieslist[index]);
              Get.to(() => Categorydetail(title: categorieslist[index]));
            });
          },
        ),
      ),
    ));
  }
}
