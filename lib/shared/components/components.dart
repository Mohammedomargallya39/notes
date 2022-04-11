import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes/shared/style/colors.dart';

import 'constant.dart';

void navigateAndEnd(context,Widget widget){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
}
void navigateTo(context,Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget),);
}
void showToast({required String message, required ToastStates state}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum ToastStates{SUCCESS, ERROR , WARNING}
Color toastColor(ToastStates state){
  Color color ;
  switch (state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}
Widget defaultFormField({
  String? text,
  isPassword = false,
  required TextEditingController controller,
  IconData? prefix,
  ValueChanged<String>? onChange,
  IconData? suffix,
  Function? suffixPressed,
  Function? validate,
  Function? onSubmit,
  required TextInputType type ,
  required context,
  dynamic textColor,
  dynamic labelStyleColor,
  dynamic fillColor,
  dynamic suffixIconColor,
  dynamic borderColor,
  dynamic cursorColor,
  String? hintText,
  dynamic hintStyle,
  int maxLines = 1,
})
{
  return TextFormField(
    cursorColor: cursorColor,
    maxLines: maxLines,
    controller: controller,
    obscureText: isPassword,
    onChanged: onChange,
    validator:(value){
      return validate!(value);
    },
    keyboardType: type,
    style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle,
      isDense: true,
      labelText: text,
      filled: false,
      labelStyle: TextStyle(
          color:  labelStyleColor
      ),
      fillColor: fillColor ,
      // prefixIcon: Icon(prefix, color: Colors.white,textDirection: TextDirection.ltr,),
      // suffixIcon: IconButton(onPressed: (){
      //   return suffixPressed!();
      // }, icon: Icon(suffix),color:suffixIconColor,),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0 ),
        borderSide:  BorderSide(color: borderColor , width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0 ),
        borderSide:  BorderSide(color: borderColor , width: 1),
      ),
    ),
  );
}

Widget buildNotesItems( Map model,
{
  required dynamic width
})
{
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.02),
        color: greyIIColor.withOpacity(0.1)
    ),
    padding: EdgeInsets.all(width * paddingIcon),
    margin: EdgeInsets.all(width * 0.03),
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${model['title']}',
          style: TextStyle(
              color: greyIIColor,
              fontSize: width * 0.04
          ),
        ),
        SizedBox(height: width * 0.05,),
        Text(
          '${model['date']} ${model['time']}',
          style: TextStyle(
              color: greyIIColor.withOpacity(0.6),
              fontSize: width * 0.03
          ),
        ),
      ],
    ),
    // Text('sss',style: TextStyle(color: whiteColor),),
  );
}