import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/Controller/ProductController.dart';
import 'package:emart_app/Services/Firestore_service.dart';
import 'package:emart_app/View/Categories/item_details.dart';

class Categorydetail extends StatefulWidget {
  final String? title;
  Categorydetail({Key? key, required this.title}) : super(key: key);

  @override
  State<Categorydetail> createState() => _CategorydetailState();
}

class _CategorydetailState extends State<Categorydetail> {
  var controller = Get.find<ProductController>();
  dynamic productMethod;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCase(widget.title);
  }

  switchCase(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FireStoreService.getSubCategoryProducts(title);
    } else {
      productMethod = FireStoreService.getProducts(title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: widget.title!.text.fontFamily(bold).white.make(),
            ),
            body: Column(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        controller.subcat.length,
                        (index) => "${controller.subcat[index]}"
                                .text
                                .size(12)
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .makeCentered()
                                .box
                                .white
                                .rounded
                                .size(150, 60)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .make()
                                .onTap(() {
                              switchCase("${controller.subcat[index]}");
                              setState(() {});
                            })),
                  ),
                ),
                20.heightBox,
                StreamBuilder(
                  stream: productMethod,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(whiteColor),
                        ),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: "No Product Found"
                              .text
                              .color(darkFontGrey)
                              .make());
                    } else {
                      var data = snapshot.data!.docs;
                      return Expanded(
                          child: Container(
                        color: lightGrey,
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 250),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_img'][0],
                                  width: 200,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                10.heightBox,
                                "${data[index]['p_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${data[index]['p_price']}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make()
                              ],
                            )
                                .box
                                .white
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .roundedSM
                                .outerShadow
                                .padding(const EdgeInsets.all(8))
                                .make()
                                .onTap(() {
                              controller.checkIffav(data[index]);
                              Get.to(() => ItemDetails(
                                    title: "${data[index]['p_name']}",
                                    data: data[index],
                                  ));
                            });
                          },
                        ),
                      ));
                    }
                  },
                ),
              ],
            )));
  }
}
