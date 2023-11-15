import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/Controller/authController.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? CheckValue = false;
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Join the $appname".text.fontFamily(bold).white.size(18).make(),
          5.heightBox,
          Obx(
            () => Column(
              children: [
                CustomTextWidget(
                    title: name,
                    hint: nameHint,
                    controller: nameController,
                    isPass: false),
                CustomTextWidget(
                    title: email,
                    hint: emailHint,
                    controller: emailController,
                    isPass: false),
                CustomTextWidget(
                    title: password,
                    hint: passwordHint,
                    controller: passwordController,
                    isPass: true),
                CustomTextWidget(
                    title: reTypepassword,
                    hint: passwordHint,
                    controller: retypeController,
                    isPass: true),
                Row(
                  children: [
                    Checkbox(
                        checkColor: redColor,
                        value: CheckValue,
                        onChanged: (newValue) {
                          setState(() {
                            CheckValue = newValue;
                          });
                        }),
                    Expanded(
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "I am agreed",
                            style: TextStyle(
                                fontFamily: bold,
                                color: MyColor.colorsLightShade)),
                        TextSpan(
                            text: terms,
                            style:
                                TextStyle(fontFamily: bold, color: redColor)),
                        TextSpan(
                            text: "&",
                            style: TextStyle(
                                fontFamily: bold,
                                color: MyColor.colorsLightShade)),
                        TextSpan(
                            text: PrivacyPolicy,
                            style:
                                TextStyle(fontFamily: bold, color: redColor)),
                      ])),
                    ),
                  ],
                ),
                5.heightBox,
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : MyButton(
                        color: MyColor.themecolor,
                        textcolor: MyColor.backgroudColorLight,
                        title: signup,
                        OnPress: () async {
                          if (CheckValue != false) {
                            if (emailController.text != "" &&
                                passwordController.text != "" &&
                                nameController.text != "") {
                              try {
                                await controller
                                    .signupMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) {
                                  return controller.storeUserData(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text);
                                }).then((value) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.to(() => const Home());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                              }
                            } else {
                              VxToast.show(context,
                                  msg: "Feild Should not be Empty");
                            }
                          }
                        }).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: aleardy,
                      style: TextStyle(fontFamily: bold, color: redColor)),
                  TextSpan(
                      text: login,
                      style: TextStyle(fontFamily: bold, color: redColor)),
                ])).onTap(() {
                  Get.back();
                }),
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
