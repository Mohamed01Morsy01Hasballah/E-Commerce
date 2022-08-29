import 'package:e_commerce/pages/Login/LoginScreen.dart';
import 'package:e_commerce/shared/Network/local/CacheHelper.dart';
import 'package:e_commerce/shared/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class board{
  String? title;
  String? Text;
  String? image;
  board({this.title,this.Text,this.image});
}

class OnBoarding extends StatefulWidget{
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  bool last=false;
  var controller=PageController();
  List<board> list=[
    board(
      title: 'Shoping Online',
      Text:'Welcome E_Commerce ',
      image:'images/img.png'
    ),
    board(
        title: 'Shoping Clothes online',
        Text:'Welcome E_Commerce ',
        image:'images/m1.png'
    ),
    board(
        title: 'Shoping  all Products online',
        Text:'Welcome E_Commerce ',
        image:'images/m2.png'
    ),
    board(
        title: 'Shoping Online',
        Text:'Welcome E_Commerce ',
        image:'images/m3.png'
    ),
  ];
  void submit(){
    CacheHelper.SaveData(key: 'onBoarding', value: true).then((value) {
      navigateFininsh(context: context,Widget: LoginScreen());
    });
  }

  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       actions: [
         TextButton(
             onPressed:submit,

             child: Text(
                 'Skip',
               style:  TextStyle(
                 fontSize: 15,
                 fontWeight: FontWeight.bold
               ),
             )
         )
       ],
     ),
     body: Padding(
       padding: const EdgeInsets.all(20.0),
       child: Column(
         children: [
           Expanded(
             child: PageView.builder(
               physics: BouncingScrollPhysics(),
               onPageChanged: (int value){
                 if(value==list.length-1){
                   setState(() {
                     last=true;
                   });
                 }
                 else{
                   setState(() {
                     last=false;
                   });
                 }

               },
               controller: controller,
               itemBuilder: (context,index)=>BuiltItem(list[index]),
               itemCount: list.length,
             ),
           ),
           Row(
             children: [
               SmoothPageIndicator(
                   controller: controller,
                   count: list.length,
                    effect:ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.deepOrange,
                      expansionFactor: 4,
                      spacing: 5
                    ),
               ),
               Spacer(),
               FloatingActionButton(
                   onPressed: (){
                     if(last){
                       submit();
                     }
                     else{
                       controller.nextPage(duration: Duration(
                         milliseconds: 750
                       ), curve:Curves.fastLinearToSlowEaseIn );
                     }
                   },
                 child: Icon(Icons.arrow_forward_ios),
               )
             ],
           )
         ],
       ),
     )
   );
  }
}
Widget BuiltItem(board item)=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(child: Image(image: AssetImage('${item.image}'))),
    Text('${item.Text}'),
    SizedBox(
      height: 20,
    ),
    Text('${item.title}'),

  ],
);