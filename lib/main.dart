import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes/cubit/bloc_observer.dart';
import 'package:notes/shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'modules/layout_screen.dart';



void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await CacheHelper.init();

  Widget? widget;
  widget = LayoutScreen();
  runApp(
      MyApp(
        startWidget: widget,)
  );

}
class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({Key? key,
    required this.startWidget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()..createDB(),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splash: SvgPicture.asset(
            'assets/images/splash.svg',
          ),
          nextScreen: startWidget,
          duration: 500,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
