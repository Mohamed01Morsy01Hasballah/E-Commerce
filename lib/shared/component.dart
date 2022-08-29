import 'package:e_commerce/pages/Login/LoginScreen.dart';
import 'package:e_commerce/shared/Network/local/CacheHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../layout/Cubit.dart';

Widget BuiltTextField(
{
  required String label,
  required TextInputType  type,
  required TextEditingController controller,
 required IconData prefix,
   IconData? suffix,
   validate,
  bool secure=false,
  suffixPressed,
  Function? onsubmit,

}
    )=> TextFormField(
  keyboardType: type,
  controller:controller ,
  obscureText: secure,
  onFieldSubmitted:(s){
    onsubmit!(s);
  } ,
  decoration: InputDecoration(
      labelText:label,

      prefixIcon: Icon(
        prefix
      ),
      suffixIcon: TextButton(
        onPressed:suffixPressed ,
       child: Icon(
            suffix
        ),
      ),
      border:OutlineInputBorder()
  ),
  validator: validate
);
Widget BuiltButton(
{
  required double height,
  required Color color,
  required String text,
 required  Function function,
}
    )=>
    Container(
      width: double.infinity,
      height: height,
      color: color,
      child: MaterialButton(
  onPressed:(){
    function();
  },
  child: Text(text.toUpperCase()),

      ),
    );
void navigatePush({
  required Widget widget,
   context
})=>Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
void navigateFininsh({
   Widget ,
  context
})=>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context)=>Widget)
        ,(route) => false
    );
void ShowToast(
{
  required String text,
  required ToastState state
}
    )
{
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: ChooseColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum ToastState{Success,Error,Warning}
Color? ChooseColor(ToastState state){
  Color? color;
  switch(state){
    case ToastState.Success:
      color=Colors.orange;
      break;
    case ToastState.Error:
      color=Colors.red;
      break;
    case ToastState.Warning:
      color=Colors.yellow;
  }

}
void SignOut(context){
  CacheHelper.RemoveData(key: 'token').then((value){
    navigateFininsh(context: context,Widget:LoginScreen());
  });
}
Widget GridViewItem( model,context)=>Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child:   Container(

    height: 110,

    color: Colors.white,

    child:Row(

      mainAxisAlignment: MainAxisAlignment.start,

      mainAxisSize: MainAxisSize.min,

      children: [

        Stack(

          alignment:AlignmentDirectional.bottomStart ,

          children: [

            Image(



              image: NetworkImage('${model.image}'),



              fit: BoxFit.fill,

              height: 110,

              width: 110,



            ),

            if(model.discount !=0)

              Container(

                color: Colors.deepOrangeAccent,

                height: 20,

                width: 60,

                child: Text(

                  'Discount',

                  textAlign:TextAlign.center,

                  style: TextStyle(

                      color: Colors.white

                  ),



                ),

              )

          ],

        ),

        SizedBox(

          width: 10,

        ),

        Expanded(

          child: Padding(

            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,



              children: [

                Text(

                 '${model.name}',

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(

                      fontSize: 13

                  ),

                ),

                Spacer(),

                Row(

                  children: [

                    Text(

                      model.price.toString(),

                      style: TextStyle(

                          color:  Colors.indigo,

                          fontSize: 15

                      ),

                    ),

                    SizedBox(

                      width: 10,

                    ),
                    if(model.discount !=0)
                    Text(
                      model.oldprice.toString(),
                      style: TextStyle

                        (

                          fontSize: 15,

                          color:  Colors.grey,

                          decoration:TextDecoration.lineThrough

                      ),

                    ),

                    Spacer(),

                    IconButton(

                        onPressed: (){

                          //print(model.id);

                          ShopCubit.get(context).Favorite(model.id!);

                        },



                        icon: CircleAvatar(

                          radius: 20,

                          backgroundColor: ShopCubit.get(context).favortie[model.id]!  ? Colors.redAccent:Colors.grey,

                          child: Icon(

                            Icons.favorite_border,

                            color: Colors.white,

                          ),

                        )

                    ),



                  ],

                ),

              ],

            ),

          ),

        )



      ],

    ),

  ),
);
Widget myDivider()=>Container(
  height: 2,
  width: double.infinity,
  color: Colors.grey[300],
);

String? token;