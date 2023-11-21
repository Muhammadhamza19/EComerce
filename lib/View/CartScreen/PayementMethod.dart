import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/Controller/cartController.dart';

class PayementMethods extends StatelessWidget {
  const PayementMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Choose Payment Method"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: MyButton(
            color: redColor,
            OnPress: () {
              controller.placeMyOrder(
                  orderPaymentMethod:
                      paymentMethod[controller.paymentIndex.value],
                  totalAmount: controller.totalP.value);
            },
            textcolor: whiteColor,
            title: "Place my order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(
          () => Column(
            children: List.generate(paymentMethodsList.length, (index) {
              return GestureDetector(
                onTap: () {
                  controller.changePaymentMethod(index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: controller.paymentIndex.value == index
                            ? redColor
                            : Colors.transparent,
                        width: 5,
                      )),
                  margin: EdgeInsets.only(bottom: 8),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        paymentMethodsList[index],
                        width: double.infinity,
                        height: 100,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        fit: BoxFit.cover,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                activeColor: Colors.green,
                                value: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                onChanged: (value) {},
                              ),
                            )
                          : Container(),
                      Positioned(
                          bottom: 0,
                          right: 10,
                          child: paymentMethod[index]
                              .text
                              .white
                              .fontFamily(semibold)
                              .size(16)
                              .make())
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
