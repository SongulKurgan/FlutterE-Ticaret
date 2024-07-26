
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/viewed_recently_providers.dart';
import 'package:untitled/screens/cart/cart_widget.dart';
import 'package:untitled/screens/cart/empty_bag.dart';
import 'package:untitled/services/assets_manages.dart';
import 'package:untitled/widgets/products/product_widget.dart';
import 'package:untitled/widgets/title_text.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const routName = "/ViewedRecentlyScreen";

  const ViewedRecentlyScreen({super.key});
  final bool isEmpty = true;


  @override
  Widget build(BuildContext context) {
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);

    return viewedProdProvider.getViewedProds.isEmpty ?
    Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: (){
                if(Navigator.canPop(context)){
                  Navigator.pop(context);
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
            ),
            title: const TitleTextWidget(label: "Viewed Recently")
        ),
        body: EmptyBagWidget(
            imagePath: AssetsManager.searchrecent,
            title: "Son Görüntülenenler boş",
            subtitle: "Son Görüntülenenler boş gözüküyor",
            buttonText: "Alışveriş Yap")
    )
        :Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: (){
                if(Navigator.canPop(context)){
                  Navigator.pop(context);
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
            ),
            title:  TitleTextWidget(label: "Son Görüntülenler ${viewedProdProvider.getViewedProds.length}")
        ),
        body: DynamicHeightGridView(
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          builder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductWidget(
                productId: viewedProdProvider.getViewedProds.values.toList()[index].productId,

              ),
            );

          },
          itemCount: viewedProdProvider.getViewedProds.length,
          crossAxisCount: 2,
        )

    );
  }
}
