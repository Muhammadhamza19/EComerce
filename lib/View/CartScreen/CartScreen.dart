import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/Controller/cartController.dart';
import 'package:emart_app/Services/Firestore_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:
              "Shopping Cart".text.color(darkFontGrey).fontFamily(bold).make(),
        ),
        body: StreamBuilder(
          stream: FireStoreService.getCarts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(whiteColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is Empty".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;

              Future.delayed(Duration.zero, () {
                controller.calculate(data);
              });

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network('${data[index]['img']}'),
                          title:
                              "${data[index]['title']} (x${data[index]['qty']})"
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                          subtitle: "${data[index]['tprice']}"
                              .numCurrency
                              .text
                              .color(redColor)
                              .fontFamily(semibold)
                              .make(),
                          trailing: const Icon(
                            Icons.delete,
                            color: redColor,
                          ).onTap(() {
                            FireStoreService.deletItems(data[index].id);
                          }),
                        );
                      },
                    )),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(() => "${controller.totalP.value}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .make()),
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(12))
                        .color(Colors.orange.shade200)
                        .roundedSM
                        .width(context.screenWidth - 60)
                        .make(),
                    10.heightBox,
                    SizedBox(
                      width: context.screenWidth - 60,
                      child: MyButton(
                          color: redColor,
                          OnPress: () {},
                          textcolor: whiteColor,
                          title: "Proceed to Shipping"),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
