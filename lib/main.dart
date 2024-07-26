import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/constans/theme_data.dart';
import 'package:untitled/providers/cart_provider.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/providers/theme_provider.dart';
import 'package:untitled/providers/user_provider.dart';
import 'package:untitled/providers/viewed_recently_providers.dart';
import 'package:untitled/providers/wishlist_provider.dart';
import 'package:untitled/root_screen.dart';
import 'package:untitled/screens/auth/forgot_password.dart';
import 'package:untitled/screens/auth/login.dart';
import 'package:untitled/screens/auth/register.dart';
import 'package:untitled/screens/chatbox_screen.dart';
import 'package:untitled/screens/init_screen/viewed_recently.dart';
import 'package:untitled/screens/init_screen/wishlist.dart';
import 'package:untitled/screens/search_screen.dart';
import 'package:untitled/widgets/order/order_screen.dart';
import 'package:untitled/widgets/products/product_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>
      (future: Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyCJccvULX11P639b63tgUdyQOlr3tzduoM',
          appId: '1:183304837148:android:0a066fddd03750834f67d9',
          messagingSenderId: '183304837148',
          projectId: 'ecommerce-bitirme-40020',
          storageBucket: 'ecommerce-bitirme-40020.appspot.com',
        )
    ),
        builder: (context, snapshot){
          if(snapshot.connectionState== ConnectionState.waiting){
            return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home:Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            );
          }
          else if(snapshot.hasError){
            return  MaterialApp(
                debugShowCheckedModeBanner: false,
                home:Scaffold(
                  body: Center(
                    child: SelectableText(snapshot.error.toString()),
                  ),
                )
            );

          }




          return MultiProvider(providers: [
            ChangeNotifierProvider(create: (_){
              return ThemeProvider();
            }),
            ChangeNotifierProvider(create: (_){
              return ProductProvider();
            }),
            ChangeNotifierProvider(create: (_){
              return CartProvider();
            }),
            ChangeNotifierProvider(create: (_){
              return WishlistProvider();
            }),
            ChangeNotifierProvider(create: (_){
              return ViewedProdProvider();
            }),
            ChangeNotifierProvider(create: (_){
              return UserProvider();
            }),

          ],
            child: Consumer<ThemeProvider>(builder: (context, themeProvider, child){
              return MaterialApp(
                title: 'Alışveriş Ap ',
                theme: Styles.themeData(isDarkTheme: themeProvider.getIsDarkTheme, context: context),

                home:const LoginScreen(),
                //home:const RootScreen(),
                //home: ChatboxScreen(),
                routes: {
                  ProductDetailScreen.routName : (context)=> const ProductDetailScreen(),
                  RootScreen.routName : (context)=> const RootScreen(),
                  WishlistScreen.routName : (context)=> const WishlistScreen(),
                  ViewedRecentlyScreen.routName : (context)=> const ViewedRecentlyScreen(),
                  RegisterScreen.routName : (context)=> const RegisterScreen(),
                  OrderScreen.routName : (context)=> const OrderScreen(),
                  ForgotPassword.routName : (context)=> const ForgotPassword(),
                  SearchScreen.routName : (context)=> const SearchScreen(),
                  LoginScreen.routName : (context)=> const LoginScreen(),


                },
              );


            }),

          );
        }
    );
  }
}



