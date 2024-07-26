import 'package:flutter/material.dart';
import 'package:untitled/constans/app_colors.dart';

//Dark ve Light mod yapma işlemi. Şart blogu ile
class Styles{
  static ThemeData themeData(
       {required bool isDarkTheme, required BuildContext context}){
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme
          ? AppColors.darkScaffoldColor
          : AppColors.lightScaffoldColor,
      //Yukarıdaki işlemin aynısı ama ürünler vb işelemler için
      cardColor: isDarkTheme
          ? AppColors.darkScaffoldColor
          : AppColors.lightScaffoldColor,
      //dark- yazıları beyaza , diğer durumda da yazıları siyaha çevir
      brightness: isDarkTheme ? Brightness.dark: Brightness.light,
      //Arama butonu için siyah beyaz ekran
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black
        ),
        backgroundColor: isDarkTheme
            ? AppColors.darkScaffoldColor
            : AppColors.lightScaffoldColor,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black
        )
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.transparent
          ),
          borderRadius: BorderRadius.circular(12)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(
                width: 1,
                color: isDarkTheme ? Colors.white : Colors.black
            ),
            borderRadius: BorderRadius.circular(12)
        ),

        errorBorder: OutlineInputBorder(
            borderSide:  BorderSide(
                width: 1,
                color: Theme.of(context).colorScheme.error,
            ),
            borderRadius: BorderRadius.circular(12)
        ),

        focusedErrorBorder: OutlineInputBorder(
            borderSide:  BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.error,
            ),
            borderRadius: BorderRadius.circular(12)
        ),
      ),
    );
  }
}