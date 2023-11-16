import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/Controller/chatController.dart';
import 'package:emart_app/Services/Firestore_service.dart';
import 'package:emart_app/View/chatScreen/component/senderBubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      appBar: AppBar(
        title: "${controller.friendName}"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    )
                  : Expanded(
                      child: StreamBuilder(
                          stream: FireStoreService.getChatsMessage(
                              controller.chatDocId.toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                ),
                              );
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: "Send a message..."
                                    .text
                                    .color(darkFontGrey)
                                    .make(),
                              );
                            } else {
                              return ListView(
                                  children: snapshot.data!.docs
                                      .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];

                                return Align(
                                    alignment: data['uid'] == currentUser!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: senderBubble(data));
                              }).toList());
                            }
                          })),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.msgController,
                    decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: textfieldGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: textfieldGrey))),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      color: redColor,
                    )),
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 8))
                .make(),
          ],
        ),
      ),
    );
  }
}
