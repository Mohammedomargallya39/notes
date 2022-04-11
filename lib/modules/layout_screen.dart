import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:notes/cubit/cubit.dart';
import 'package:notes/cubit/states.dart';
import 'package:notes/modules/show_note_screen.dart';
import 'package:notes/shared/components/components.dart';
import 'package:notes/shared/components/constant.dart';
import 'package:notes/shared/style/colors.dart';

class LayoutScreen extends StatelessWidget {
  LayoutScreen({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: purpleColor.withOpacity(0.8),
          floatingActionButton: IconButton(
              icon: Icon(AppCubit.get(context).fabIcon),
              iconSize: size.width * 0.08,
              color: blueColor,
              alignment: Alignment.bottomRight,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              padding: EdgeInsets.fromLTRB(
                  size.width * paddingIcon,
                  size.width * paddingIcon,
                  size.width * paddingIcon,
                  size.width * paddingIcon
              ),
              onPressed: () {

                if(AppCubit.get(context).isBottomSheetShown == false)
                {
                  titleController.text = '';
                  noteController.text = '';
                  scaffoldKey.currentState!.showBottomSheet((context) {
                    return Container(
                      height: size.height * 0.7,
                      width: size.width,
                      color: purpleColor,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.all(size.width * paddingIcon),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: Text(
                                    'Add new note',
                                    style: TextStyle(
                                        fontSize: size.width * mainFontSize,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.04,
                                ),
                                Text(
                                  'Add title',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: size.width * mainFontSize,
                                      color: whiteColor,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                defaultFormField(
                                    cursorColor: whiteColor,
                                    controller: titleController,
                                    type: TextInputType.text,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'Title must not be empty';
                                      }
                                    },
                                    maxLines: 1,
                                    textColor: whiteColor.withOpacity(0.5),
                                    borderColor: greyIIColor,
                                    context: context
                                ),
                                SizedBox(
                                  height: size.height * 0.04,
                                ),
                                Text(
                                  'Add note',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: size.width * mainFontSize,
                                      color: whiteColor,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                defaultFormField(
                                    cursorColor: whiteColor,
                                    controller: noteController,
                                    type: TextInputType.text,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'Note must not be empty';
                                      }
                                    },
                                    maxLines: 22,
                                    textColor: whiteColor.withOpacity(0.5),
                                    hintStyle: TextStyle(
                                      color: whiteColor,
                                    ),
                                    borderColor: greyIIColor,
                                    context: context
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).closed.then((value) {
                    AppCubit.get(context).changeBottomSheet(isShow: false, icon: Icons.edit);
                  });
                  AppCubit.get(context).changeBottomSheet(isShow: true, icon: Icons.add);
                } else
                {
                  if(formKey.currentState!.validate())
                  {
                    AppCubit.get(context).insertToDB(
                        title: titleController.text,
                        note: noteController.text,
                        date: DateFormat.yMd().format(DateTime.now()),
                        time: DateFormat.Hms().format(DateTime.now())
                    );
                    Navigator.pop(context);
                  }
                }
              }
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Column(
                children: [
                  // ignore: unnecessary_null_comparison
                  if(AppCubit.get(context).notes.isEmpty)
                    Container(
                      margin: EdgeInsets.all(size.width * 0.2),
                      child: SvgPicture.asset(
                        'assets/images/no_data.svg',
                        height: size.height * 0.5,
                        alignment: Alignment.center,
                      ),
                    ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index)
                      {
                        return InkWell(
                          child: buildNotesItems(AppCubit.get(context).notes[index], width: size.width),
                          onTap: ()
                          {
                            navigateTo(context, ShowNote(
                              time: AppCubit.get(context).notes[index]['time'],
                              date: AppCubit.get(context).notes[index]['date'],
                              title: AppCubit.get(context).notes[index]['title'],
                              note: AppCubit.get(context).notes[index]['note'],
                              id: AppCubit.get(context).notes[index]['id'],
                            )
                            );
                          },
                        );
                      },
                      separatorBuilder: (context,index)
                      {
                        return SizedBox(
                          height: size.height * 0.02,
                        );
                      },
                      itemCount: AppCubit.get(context).notes.length
                  ),


                ],
              ),
            ),
          ),
        );
      },
    );
  }


}
