import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/View/Categories/item_details.dart';
import 'package:emart_app/View/HomeScreen/Search_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var contoller = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: contoller.searchController,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search).onTap(() {
                    if (contoller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            title: contoller.searchController.text,
                          ));
                    }
                  }),
                  filled: true,
                  border: InputBorder.none,
                  fillColor: whiteColor,
                  hintText: searchAnything,
                  hintStyle: TextStyle(color: textfieldGrey)),
            ),
          ),
          20.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //Swipper
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    height: 200,
                    enlargeCenterPage: true,
                    itemCount: SliderList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        SliderList[index],
                        fit: BoxFit.fill,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    },
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => HomeButton(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 2.5,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todayDeal : flashsale)),
                  ),
                  20.heightBox,
//Second Slider
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    height: 200,
                    enlargeCenterPage: true,
                    itemCount: secondSliderList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        secondSliderList[index],
                        fit: BoxFit.fill,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    },
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => HomeButton(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 3.5,
                            icon: index == 0
                                ? icTopCategories
                                : index == 1
                                    ? icBrands
                                    : icTopSeller,
                            title: index == 0
                                ? topCategories
                                : index == 1
                                    ? brands
                                    : topSeller)),
                  ),
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuresCategories.text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make(),
                  ),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  FeatureButton(
                                      icon: featuredImages1[index],
                                      title: featuredTitleList1[index],
                                      data: featuredTitleList1[index]),
                                  20.heightBox,
                                  FeatureButton(
                                      icon: featuredImages2[index],
                                      title: featuredTitleList2[index],
                                      data: featuredTitleList2[index]),
                                ],
                              )).toList(),
                    ),
                  ),
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: redColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text.white
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder(
                            future: FireStoreService.allFeaturedProducts(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                );
                              } else if (snapshot.hasError ||
                                  snapshot.data == null) {
                                return const Text("Error loading data");
                              } else if (snapshot.data!.docs.isEmpty) {
                                return const Text("No Featured Products");
                              } else {
                                var featuredData = snapshot.data!.docs;
                                return Row(
                                  children: List.generate(
                                    featuredData.length,
                                    (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          featuredData[index]['p_img'][0],
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                        10.heightBox,
                                        "${featuredData[index]['p_name']}"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "${featuredData[index]['p_price']}"
                                            .numCurrency
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
                                        .make()
                                        .onTap(() {
                                      Get.put(ProductController())
                                          .checkIffav(featuredData[index]);
                                      Get.to(() => ItemDetails(
                                          title:
                                              "${featuredData[index]['p_name']}",
                                          data: featuredData[index]));
                                    }),
                                  ),
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  20.heightBox,
                  //Slider Three
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    height: 200,
                    enlargeCenterPage: true,
                    itemCount: secondSliderList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        secondSliderList[index],
                        fit: BoxFit.fill,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    },
                  ),
                  //Grid View
                  20.heightBox,

                  Align(
                    alignment: Alignment.centerLeft,
                    child: "All Products"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .size(16)
                        .make(),
                  ),
                  20.heightBox,
                  StreamBuilder(
                    stream: FireStoreService.allProducts(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        );
                      } else {
                        var allproductsdata = snapshot.data!.docs;
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: allproductsdata.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 300),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  allproductsdata[index]['p_img'][0],
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                Spacer(),
                                "${allproductsdata[index]['p_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${allproductsdata[index]['p_price']}"
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make()
                              ],
                            )
                                .box
                                .white
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .roundedSM
                                .padding(const EdgeInsets.all(12))
                                .make()
                                .onTap(() {
                              Get.put(ProductController())
                                  .checkIffav(allproductsdata[index]);
                              Get.to(() => ItemDetails(
                                  title: allproductsdata[index]['p_name'],
                                  data: allproductsdata[index]));
                            });
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
