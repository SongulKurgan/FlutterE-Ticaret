import 'package:flutter/cupertino.dart';
import 'package:untitled/screens/search_screen.dart';
import 'package:untitled/widgets/subtitle_text.dart';

class CategoryRoundenWidget extends StatelessWidget {
  const CategoryRoundenWidget({
    super.key,
    required this.image,
    required this.name,});

  final String image,name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, SearchScreen.routName, arguments: name);
      },
      child: Column(
        children: [
          Image.asset(image, height: 50, width: 50,),
          const SizedBox(height: 5,),
          SubTitleTextWidget(label: name, fontSize: 13, fontWeight: FontWeight.w900,)
        ],
      ),


    );


  }
}
