import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/Controller/ProductController.dart';
import 'package:emart_app/View/chatScreen/ChatScreen.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            IconButton(
                onPressed: () {
                  if (controller.isfav.value) {
                    controller.removefromwishList(data.id);
                    controller.isfav(false);
                  } else {
                    controller.addtowishList(data.id);
                    controller.isfav(true);
                  }
                },
                icon: Icon(Icons.favorite)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                // color: redColor,
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                      autoPlay: true,
                      height: 350,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      itemCount: data['p_img'].length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          data['p_img'][index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    10.heightBox,
                    title!.text
                        .size(16)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    VxRating(
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      maxRating: 5,
                      stepInt: true,
                    ),
                    10.heightBox,
                    "${data['p_price']}"
                        .numCurrency
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller".text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            "${data['p_seller']}"
                                .text
                                .white
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(16)
                                .make()
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        ).onTap(() {
                          Get.to(() => const ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']]);
                        })
                      ],
                    )
                        .box
                        .height(70)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),
                    10.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Color:".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                    data['p_color'].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .color(Color(
                                                        data['p_color'][index])
                                                    .withOpacity(1.0))
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6))
                                                .make()
                                                .onTap(() {
                                              controller
                                                  .changeColorIndex(index);
                                            }),
                                            Visibility(
                                                visible: index ==
                                                    controller
                                                        .changeColorIndexvalue
                                                        .value,
                                                child: Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                ))
                                          ],
                                        )),
                              )
                            ],
                          )
                        ],
                      ).box.white.padding(const EdgeInsets.all(8)).make(),
                    ),
                    10.heightBox,
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                                  "Quantity:".text.color(textfieldGrey).make(),
                            ),
                            Obx(
                              () => Row(children: [
                                IconButton(
                                    onPressed: () {
                                      controller.decreaseQuantity();
                                      controller.calculateTotalPrice(
                                          int.parse(data['p_price']));
                                    },
                                    icon: const Icon(Icons.remove)),
                                controller.quantity.value.text
                                    .size(16)
                                    .color(darkFontGrey)
                                    .fontFamily(bold)
                                    .make(),
                                IconButton(
                                    onPressed: () {
                                      controller.increaseQuantitiy(
                                          num.parse(data['p_quantity']));
                                      controller.calculateTotalPrice(
                                          int.parse(data['p_price']));
                                    },
                                    icon: const Icon(Icons.add)),
                                10.widthBox,
                                "(${data['p_quantity']} available)"
                                    .text
                                    .color(textfieldGrey)
                                    .make()
                              ]),
                            )
                          ],
                        ),
                        Obx(
                          () => Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Total:".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalprice.value}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ),
                        ),
                      ],
                    ).box.white.padding(const EdgeInsets.all(8)).make(),
                    10.heightBox,
                    "Description"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    "${data['p_desc']}".text.color(darkFontGrey).make(),
                    10.heightBox,
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          itemDetailsButtonList.length,
                          (index) => ListTile(
                                title: "${itemDetailsButtonList[index]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                    ),
                    10.heightBox,
                    productmay.text
                        .fontFamily(bold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      // decoration: const BoxDecoration(color: redColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  6,
                                  (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            imgP1,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          "Laptop 4GB/6GB"
                                              .text
                                              .fontFamily(semibold)
                                              .color(darkFontGrey)
                                              .make(),
                                          10.heightBox,
                                          "\$6000"
                                              .text
                                              .color(redColor)
                                              .fontFamily(bold)
                                              .size(16)
                                              .make()
                                        ],
                                      )
                                          .box
                                          .white
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .roundedSM
                                          .padding(const EdgeInsets.all(8))
                                          .make()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: MyButton(
                  color: redColor,
                  OnPress: () {
                    controller.addtoCart(
                      color: data['p_color']
                          [controller.changeColorIndexvalue.value],
                      context: context,
                      img: data['p_img'][0],
                      qty: controller.quantity.value,
                      sellerName: data['p_seller'],
                      title: data['p_name'],
                      tprice: controller.totalprice.value,
                    );
                    VxToast.show(context, msg: "Added to Cart");
                  },
                  textcolor: whiteColor,
                  title: "Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}
