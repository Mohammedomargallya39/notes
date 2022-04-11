import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/cubit/cubit.dart';
import 'package:notes/shared/components/constant.dart';
import 'package:notes/shared/style/colors.dart';

class ShowNote extends StatelessWidget {
  ShowNote({Key? key,required this.title,required this.date,required this.time,required this.note,required this.id}) : super(key: key);
  dynamic title;
  dynamic date;
  dynamic time;
  dynamic note;
  dynamic id;
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: purpleColor.withOpacity(0.8),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        iconSize: size.width * 0.08,
        color: blueColor,
        alignment: Alignment.bottomRight,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: ()
        {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(size.width * paddingIcon),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.04,
                ),
               Container(
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(size.width * 0.02),
                     color: greyIIColor.withOpacity(0.1)
                 ),
                 padding: EdgeInsets.all(size.width * paddingIcon),
                 margin: EdgeInsets.all(size.width * 0.007),
                 width: size.width,
                 child: Text(
                   title,
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     color: greyIIColor,
                     fontSize: size.width * 0.05
                   ),
                 ),
               ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.02),
                      color: greyIIColor.withOpacity(0.1)
                  ),
                  padding: EdgeInsets.all(size.width * paddingIcon),
                  margin: EdgeInsets.all(size.width * 0.007),
                  width: size.width,
                  child: Text(
                    note,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: greyIIColor,
                        fontSize: size.width * 0.05
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Text(
                  'Note date: $date  $time',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: size.width * mainFontSize,
                      color: whiteColor.withOpacity(0.4),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Center(
                  child: TextButton(
                      onPressed: ()
                      {
                        AppCubit.get(context).deleteFromDB(id: id);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Delete Note',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: size.width * mainFontSize,
                          color: redColor,
                        ),
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
