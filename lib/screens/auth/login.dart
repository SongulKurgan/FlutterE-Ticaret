
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:untitled/constans/validator.dart';
import 'package:untitled/root_screen.dart';
import 'package:untitled/screens/auth/forgot_password.dart';
import 'package:untitled/screens/auth/register.dart';
import 'package:untitled/services/myapp_function.dart';
import 'package:untitled/widgets/app_name_text.dart';
import 'package:untitled/widgets/google_btn.dart';
import 'package:untitled/widgets/loading_manager.dart';
import 'package:untitled/widgets/subtitle_text.dart';
import 'package:untitled/widgets/title_text.dart';

class LoginScreen extends StatefulWidget {
  static const routName = "/LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  final _formkey = GlobalKey<FormState>();
  bool  _isLoading = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState(){
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose(){
    if(mounted){
      _emailController.dispose();
      _passwordController.dispose();

      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();

  }

  Future<void> _loginFct() async{
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if(isValid){
      try{
        setState(() {
          _isLoading=true;
        });
        await auth.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim()
        );
        Fluttertoast.showToast(msg: "Giriş Başarılı!", textColor: Colors.white);
        if(!mounted)
          return;
        Navigator.pushReplacementNamed(context, RootScreen.routName);
      }on FirebaseException catch( error){
        await MyAppFunctions.showErrorOrWaningDialog(
          context: context, subtitle: error.message.toString(), fct: (){},
        );

      }
      catch(error){
        await MyAppFunctions.showErrorOrWaningDialog(context: context, subtitle:
        error.toString(), fct: (){},);

      }
      finally{
        setState(() {
          _isLoading=false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: LoadingManager(isLoading: _isLoading, child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const AppNameTextWidget(
                    fontSize: 20,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: TitleTextWidget(label: "Hoşgeldiniz"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key:_formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              hintText: "Email Adresi",
                              prefixIcon: Icon ( IconlyLight.message)
                          ),
                          onFieldSubmitted: (value){
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          validator: (value){
                            return MyValidators.EmailValidator(value);
                          },



                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: "*********",
                              prefixIcon: Icon ( IconlyLight.password)
                          ),
                          onFieldSubmitted: (value) async {
                            await _loginFct();
                          },
                          validator: (value){
                            return MyValidators.PasswordValidator(value);
                          },



                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, ForgotPassword.routName);

                            },
                            child: const SubTitleTextWidget(
                              label: "Şifremi Unuttum",
                              fontStyle: FontStyle.italic,
                              textDecoration: TextDecoration.underline,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child:  ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0)
                                  )
                              ),
                              onPressed: () async { await _loginFct();},
                              icon: const Icon(Icons.login),
                              label: Text("Giriş")


                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),

                        SubTitleTextWidget(label: "Farklı şekilde giriş yap"),

                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          height: kBottomNavigationBarHeight  +10 ,
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight,
                                  child:  FittedBox(
                                    child: GoogleButton(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: kBottomNavigationBarHeight-15,
                                    child:  ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(5.0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(24.0)
                                            )
                                        ),
                                        onPressed: () async {

                                          Navigator.of(context).pushNamed(RootScreen.routName);
                                        },
                                        child: Text("Misafir Girişi")


                                    ),
                                  )
                              )
                            ],
                          ),
                        ),


                        const SizedBox(
                          height: 16.0,
                        ),

                        Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SubTitleTextWidget(label: "Hesabın yok mu?"),
                            TextButton(
                                onPressed: (){
                                  Navigator.of(context).pushNamed(RegisterScreen.routName);
                                },
                                child: const SubTitleTextWidget(label: "Kayıt Ol" , fontStyle: FontStyle.italic ,))

                          ],
                        )

                      ],
                    ),
                  )


                ],
              ),
            ),
          ),
          )
      ) ,
    );
  }
}
