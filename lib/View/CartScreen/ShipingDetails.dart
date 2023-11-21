import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/Controller/cartController.dart';
import 'package:emart_app/View/CartScreen/PayementMethod.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
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
              if (controller.addressController.text.length > 10) {
                Get.to(() => PayementMethods());
              } else {
                VxToast.show(context, msg: "Please fill the form");
              }
            },
            textcolor: whiteColor,
            title: "Continue"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomTextWidget(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            CustomTextWidget(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            CustomTextWidget(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            CustomTextWidget(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalCodeController),
            CustomTextWidget(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
