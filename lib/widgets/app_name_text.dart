import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:untitled/widgets/title_text.dart';

class AppNameTextWidget extends StatelessWidget {
  const AppNameTextWidget({super.key, this.fontSize=30});

  final double fontSize;


  //Başlık Efekti
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 22),
      baseColor: Colors.purpleAccent,
      highlightColor: Colors.yellow,
      child: TitleTextWidget(
        label: "ALIŞVERİŞ",
        fontSize: fontSize,
      ),
    );
  }
}
