import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/cart_provider.dart';
import 'package:untitled/screens/cart/buttom_checkout.dart';
import 'package:untitled/screens/cart/payment_screen.dart';
import 'package:untitled/services/assets_manages.dart';
import 'package:untitled/widgets/app_name_text.dart';
import 'package:untitled/screens/cart/cart_widget.dart';
import 'package:untitled/screens/cart/empty_bag.dart';
import 'package:untitled/widgets/title_text.dart';

class CartScreen extends StatelessWidget {
  static const routName = '/CartScreen';
  const CartScreen({super.key});
  final bool isEmpty = true;


  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty ?
    Scaffold(
        body: EmptyBagWidget(
            imagePath: AssetsManager.card2,
            title: "Sepetiniz Boş",
            subtitle: "Sepetiniz boş olabilir",
            buttonText: "Alışverişe yap")
    )
        :Scaffold(
        bottomSheet: CartBottomSheetWidget(),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
                AssetsManager.bagimg2
            ),

          ),
          title:  TitleTextWidget(label: "Sepet (${cartProvider.getCartItems.length})"),
          actions: [
            IconButton(onPressed: (){
              //sepet ürün  silme
              cartProvider.clearLocalCart();
            }, icon: const Icon(Icons.delete_forever_rounded, color:Colors.red))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: cartProvider.getCartItems.length,
                    itemBuilder: (context, index){
                      return ChangeNotifierProvider.value(
                        value: cartProvider.getCartItems.values.toList()[index],
                        child: const CardWidget(),
                      );
                    }
                )
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(PaymentScreen.routName);
                    },
                    child: Text('Onayla'),
                )
            )
          ],
        )


    );
  }
}

