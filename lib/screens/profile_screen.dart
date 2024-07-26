import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/user_model.dart';
import 'package:untitled/providers/user_provider.dart';
import 'package:untitled/screens/auth/login.dart';
import 'package:untitled/screens/init_screen/viewed_recently.dart';
import 'package:untitled/screens/init_screen/wishlist.dart';
import 'package:untitled/services/assets_manages.dart';
import 'package:untitled/services/myapp_function.dart';
import 'package:untitled/widgets/app_name_text.dart';
import 'package:untitled/widgets/loading_manager.dart';
import 'package:untitled/widgets/order/order_screen.dart';
import 'package:untitled/widgets/subtitle_text.dart';
import 'package:untitled/widgets/title_text.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive =>true;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  bool _isLoading = true;

  Future<void> fetchUserInfo() async{

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try{
      setState(() {
        _isLoading =true;
      });
      userModel = await userProvider.fetchUserInfo();

    }catch (error){
      await MyAppFunctions.showErrorOrWaningDialog(
          context: context, subtitle: error.toString(), fct: (){}
      );
    }
    finally{
      setState(() {
        _isLoading=false;
      });
    }



  }

  @override
  void initState(){
    fetchUserInfo();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return  Scaffold(
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
      body: LoadingManager(isLoading: _isLoading, child:  Column(
        crossAxisAlignment:  user == null ? CrossAxisAlignment.center : CrossAxisAlignment.center,
        mainAxisAlignment: user == null ? MainAxisAlignment.center  : MainAxisAlignment.start,
        children: [
          // Kullanıcı Giriş Uyarısı
          Visibility(
              visible: user == null ? true : false,
              child: Padding(padding: const EdgeInsets.all(8.0),
                child: TitleTextWidget(label: "Erişime sahip olmak için lütfen giriş yapın"),)
          ),


          userModel == null
              ? const SizedBox.shrink()
              :
          Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.background,
                            width: 3
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            userModel!.userImage,
                          ),
                          fit: BoxFit.fill,
                        ),




                      ),

                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        TitleTextWidget(label: userModel!.userName),
                        SizedBox(
                          height:6,
                        ),
                        SubTitleTextWidget(label: userModel!.userEmail)

                      ],

                    )
                  ],
                ),
              )


          ),
          const SizedBox(
            height: 15,
          ),
          userModel == null
              ? const SizedBox.shrink()
              :
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                const TitleTextWidget(
                    label: "Bilgi"
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomListTile(
                    imagePath:
                    AssetsManager.bagimg2,
                    text: "Tüm Ürünler",
                    function: () {
                      Navigator.pushNamed(context, OrderScreen.routName);

                    }
                ),
                CustomListTile(
                    imagePath:
                    AssetsManager.bagimg1,
                    text: "Favoriler",
                    function: () {
                      Navigator.pushNamed(context, WishlistScreen.routName);
                    }
                ),
                CustomListTile(
                    imagePath:
                    AssetsManager.clock,
                    text: "Son Görüntülenenler",
                    function: () {
                      Navigator.pushNamed(context, ViewedRecentlyScreen.routName);
                    }
                ),
                CustomListTile(
                    imagePath:
                    AssetsManager.location,
                    text: "Adresler",
                    function: () {}
                ),
                const Divider(
                  thickness: 1,
                ),
                //CustomListTile(
                //  imagePath:
                //AssetsManager.privacy,
                //text: "Settings",
                //function: () {}
                //),
                const SizedBox(height: 10),
                SwitchListTile(
                    title: Text(
                        themeProvider.getIsDarkTheme?"Dark Mode" : "LightM Mode"
                    ),
                    value: themeProvider.getIsDarkTheme,
                    onChanged: (value){
                      themeProvider.setDarkTheme(themeValue: value);
                    })
              ],

            ),
          ),

          Center(
            child: ElevatedButton.icon(

                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),


                onPressed: () async {

                  if(user==null) {
                    Navigator.pushNamed(context, LoginScreen.routName);
                  }
                  else
                  {
                    await MyAppFunctions.showErrorOrWaningDialog(
                        context: context,
                        subtitle: "Emin misin ? ",
                        fct: () async{
                          await FirebaseAuth.instance.signOut();
                          if(!mounted) return;
                          Navigator.pushReplacementNamed(context, LoginScreen.routName);
                        },

                        isError : false
                    );

                  }


                },



                icon:  Icon(user==null ?  Icons.login : Icons.logout),
                label:  Text(user==null ? "Giriş Yap" : "Çıkış Yap")


            ),
          )


        ],
      ),
      ),
    );
  }
}


class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,

  });
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap:(){
        function();
      },
      title: SubTitleTextWidget(label: text),
      leading: Image.asset(
        imagePath,
        height: 34,
      ),
      trailing:  const Icon(CupertinoIcons.chevron_right),

    );
  }
}

