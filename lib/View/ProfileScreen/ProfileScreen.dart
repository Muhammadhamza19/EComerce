import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/Controller/authController.dart';
import 'package:emart_app/Controller/profileController.dart';
import 'package:emart_app/Services/Firestore_service.dart';
import 'package:emart_app/View/ProfileScreen/EditScreen.dart';
import 'package:emart_app/View/ProfileScreen/components/details_cards.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FireStoreService.getUser(currentUser!.uid),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(whiteColor),
            ),
          );
        } else {
          var data = snapshot.data!.docs[0];
          return SafeArea(
              child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.edit,
                  color: whiteColor,
                ),
              ).onTap(() {
                controller.nameController.text = data['name'];

                Get.to(() => EditScreen(
                      data: data,
                    ));
              }),
              Row(
                children: [
                  data['imageUrl'] == ''
                      ? Image.asset(
                          imgProfile2,
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.network(
                          // 'https://firebasestorage.googleapis.com/v0/b/emart-912e2.appspot.com/o/images%2FnxVYYOO5JvSnaWYesF7ZKFBW6d52%2FWhatsApp%20Image%202023-10-29%20at%201.15.43%20PM%20(2).jpeg?alt=media&token=e39b0384-a4b9-44f6-9931-a1d15ca7c28b',
                          data['imageUrl'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.fill,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
                  10.widthBox,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "${data['name']}".text.fontFamily(semibold).white.make(),
                      5.heightBox,
                      "${data['email']}".text.white.make()
                    ],
                  )),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white)),
                      onPressed: () async {
                        Get.put(AuthController()).isLoading(false);
                        await Get.put(AuthController()).signOutMethod(context);
                        Get.to(() => const LoginScreen());
                      },
                      child: logout.text.fontFamily(semibold).white.make()),
                ],
              ),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  detailCards(
                      count: "${data['cart_count']}",
                      title: "in Your cart",
                      width: context.screenWidth / 3.4),
                  detailCards(
                      count: "${data['wishlist_count']}",
                      title: "in Your wishlist",
                      width: context.screenWidth / 3.4),
                  detailCards(
                      count: "${data['order_count']}",
                      title: "Your orders",
                      width: context.screenWidth / 3.4),
                ],
              ),
              40.heightBox,
              ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.asset(
                            profileButoonIcons[index],
                            width: 22,
                          ),
                          title: profileButoonItems[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: profileButoonItems.length)
                  .box
                  .white
                  .padding(const EdgeInsets.symmetric(horizontal: 16))
                  .shadowSm
                  .make()
            ]),
          ));
        }
      },
    )));
  }
}
