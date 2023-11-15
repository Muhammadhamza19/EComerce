import 'dart:io';

import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/Controller/profileController.dart';

class EditScreen extends StatelessWidget {
  final dynamic data;

  EditScreen({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Obx(() {
            if (data['imageUrl'] == '' && controller.selectedFile.isEmpty) {
              return Image.asset(
                imgProfile2,
                width: 100,
                fit: BoxFit.cover,
              ).box.roundedFull.clip(Clip.antiAlias).make();
            } else if (data['imageUrl'] != '' &&
                controller.selectedFile.isEmpty) {
              return Image.network(
                data['imageUrl'],
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              ).box.roundedFull.clip(Clip.antiAlias).make();
            } else {
              return Image.memory(
                controller.selectedFile[0],
                width: 100,
                fit: BoxFit.cover,
              ).box.roundedFull.clip(Clip.antiAlias).make();
            }
          }),
          10.heightBox,
          MyButton(
              color: redColor,
              OnPress: () {
                controller.pickFile();
              },
              textcolor: whiteColor,
              title: "Change"),
          Divider(),
          20.heightBox,
          CustomTextWidget(
              controller: controller.nameController,
              hint: nameHint,
              title: name,
              isPass: false),
          20.heightBox,
          CustomTextWidget(
              controller: controller.oldPassController,
              hint: password,
              title: oldPass,
              isPass: true),
          CustomTextWidget(
              controller: controller.newPassController,
              hint: password,
              title: newPass,
              isPass: true),
          20.heightBox,
          controller.isLoading.value == true
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                )
              : SizedBox(
                  width: context.screenWidth - 40,
                  child: MyButton(
                      color: redColor,
                      OnPress: () async {
                        controller.isLoading(true);
                        print(
                            "${data['password']} ${controller.oldPassController.text} ${data['password'] == controller.oldPassController.text}");
                        if (controller.profileImageLink.isNotEmpty) {
                          await controller.uploadfile();
                        } else {
                          controller.profileImageLink = data['imageUrl'];
                        }
                        if (data['password'] ==
                            controller.oldPassController.text) {
                          await controller.changeAuthPassowrd(
                              email: data['email'],
                              password: controller.oldPassController.text,
                              newpass: controller.newPassController.text);
                          await controller.updateProfile(
                              imgUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.newPassController.text);

                          VxToast.show(context, msg: "Uploaded");
                        } else {
                          VxToast.show(context, msg: "Wrong old Password");
                          controller.isLoading(false);
                        }
                      },
                      textcolor: whiteColor,
                      title: "Save"),
                ),
        ])
            .box
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .white
            .margin(const EdgeInsets.only(top: 50, right: 15, left: 15))
            .rounded
            .make(),
      ),
    ));
  }
}
