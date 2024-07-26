import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/cart_provider.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/screens/cart/cart_secreen.dart';
import 'package:untitled/screens/chatbox_screen.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/screens/profile_screen.dart';
import 'package:untitled/screens/search_screen.dart';

class RootScreen extends StatefulWidget {
  static const routName = "/RootScreen";
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  @override
  void initState(){
    super.initState();
    screens = const [
      HomeScreen(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    controller = PageController(initialPage: currentScreen);

  }
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return  Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index){
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.home),
            icon:Icon(CupertinoIcons.home),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.search),
            icon: Icon(CupertinoIcons.search),
            label: "Search",
          ),

          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.bag),
            icon: Badge(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              label: Text(cartProvider.getCartItems.length.toString()),
              child: Icon(IconlyLight.bag_2),
            ),
            label: "Cart",
          ),

          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.person),
            icon: Icon(CupertinoIcons.person),
            label: "Profile",
          ),

          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.chat_bubble),
            icon: Icon(CupertinoIcons.chat_bubble),
            label: "Chatbox",
          ),
        ],
      ),

    );
  }
}

