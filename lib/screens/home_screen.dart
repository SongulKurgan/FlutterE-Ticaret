import 'package:card_swiper/card_swiper.dart';
import 'package:untitled/constans/app_constans.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/providers/theme_provider.dart';
import 'package:untitled/services/assets_manages.dart';
import 'package:untitled/widgets/app_name_text.dart';
import 'package:untitled/widgets/products/category_roundend_widget.dart';
import 'package:untitled/widgets/products/top_product.dart';
import 'package:untitled/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final productsProvider = Provider.of<ProductProvider>(context);

    Size size  = MediaQuery.of(context).size;
    return Scaffold(
      // APPBAR ------------------->
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
              AssetsManager.card
          ),

        ),
        title: const AppNameTextWidget(fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: size.height *0.25,
                  child: ClipRRect(
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index){
                        return Image.asset(
                          AppConstans.bannerImages[index],
                          fit:BoxFit.fill,
                        );

                      },
                      itemCount: AppConstans.bannerImages.length,
                      pagination: SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                              activeColor: Colors.red, color: Colors.green
                          )
                      ),

                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const TitleTextWidget(label: "Tüm Ürünler"),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: size.height* 0.2,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productsProvider.getProducts.length,
                      itemBuilder: (context, index){
                        return ChangeNotifierProvider.value(
                          value: productsProvider.getProducts[index],
                          child: const TopProductWidget(),

                        );
                      }
                  ),
                ),
                const TitleTextWidget(label: "Kategoriler"),
                const SizedBox(
                  height: 15.0,
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children:
                  List.generate(AppConstans.categoriesList.length, (index) {
                    return CategoryRoundenWidget(
                      image: AppConstans.categoriesList[index].image,
                      name: AppConstans.categoriesList[index].name,
                    );

                  }),
                ),
              ],
            )
        ),
      ),
    );
  }
}
