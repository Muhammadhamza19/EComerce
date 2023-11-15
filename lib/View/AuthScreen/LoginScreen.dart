import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/Controller/authController.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
      child: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
          5.heightBox,
          Obx(
            () => Column(
              children: [
                CustomTextWidget(
                    title: email,
                    hint: emailHint,
                    isPass: false,
                    controller: controller.emailController),
                CustomTextWidget(
                    title: password,
                    hint: passwordHint,
                    isPass: true,
                    controller: controller.passwordController),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetpassword.text.make())),
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : MyButton(
                        color: MyColor.themecolor,
                        textcolor: MyColor.backgroudColorLight,
                        title: login,
                        OnPress: () async {
                          controller.isLoading(true);
                          try {
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loggedin);
                                controller.isLoading(false);

                                Get.to(() => Home());
                              } else {
                                controller.isLoading(false);
                              }
                            });
                          } catch (e) {
                            controller.isLoading(false);
                          }
                        }).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                createaccount.text.color(fontGrey).make(),
                5.heightBox,
                MyButton(
                    color: MyColor.colorsLightShade,
                    textcolor: MyColor.backgroudColorLight,
                    title: signup,
                    OnPress: () {
                      Get.to(() => SignupScreen());
                    }).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                loginwith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(
                              socailIconList[index],
                              width: 30,
                            ),
                          )),
                )
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(20))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ),
        ],
      )),
    );
  }
}
