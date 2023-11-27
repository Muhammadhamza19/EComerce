import 'package:emart_app/Constant/MyExport.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FireStoreService.searchProducts(title: title),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No products found".text.makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where(
                  (element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()),
                )
                .toList();
            return GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 300),
              children: filtered
                  .mapIndexed((currentValue, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            filtered[index]['p_img'][0],
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          Spacer(),
                          "${filtered[index]['p_name']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          10.heightBox,
                          "${filtered[index]['p_price']}"
                              .text
                              .color(redColor)
                              .fontFamily(bold)
                              .size(16)
                              .make()
                        ],
                      )
                          .box
                          .white
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .outerShadowMd
                          .roundedSM
                          .padding(const EdgeInsets.all(12))
                          .make()
                          .onTap(() {
                        Get.to(() => ItemDetails(
                            title: filtered[index]['p_name'],
                            data: filtered[index]));
                      }))
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
