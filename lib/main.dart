import 'package:buy_now_demo/modules/login/login_screen.dart';
import 'package:buy_now_demo/shared/app_cubit/cubit.dart';
import 'package:buy_now_demo/shared/app_cubit/states.dart';
import 'package:buy_now_demo/shared/components/constants.dart';
import 'package:buy_now_demo/shared/di/di.dart';
import 'package:buy_now_demo/shared/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'layouts/home/home_layout.dart';
import 'modules/select_language/select_language_screen.dart';
import 'shared/styles/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  appLanguage = await getAppLanguage;
  userToken = await getUserToken;

  print(' => userToken'+ userToken.toString());

  String translation = await getTranslationFile(
    appLanguage: appLanguage,
  );
  Widget startPoint;

  if (appLanguage != null && userToken == null) {
    startPoint = LoginScreen();
  } else if (appLanguage != null && userToken != null) {
    startPoint = HomeLayout();
  } else {
    startPoint = SelectLanguageScreen();
  }


  runApp(
    MyApp(
      translateFile: translation,
      code: translation,
      startPoint: startPoint,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String translateFile;
  final String code;
  final Widget startPoint;

  const MyApp({@required this.translateFile, this.code, this.startPoint});
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(kAppWhiteColor);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di<AppCubit>()
            ..setAppLanguage(
              translateFile: translateFile,
              code: code,
            )
            ..getHomeData()
            ..getCategoriesData()
            ..getCartData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Buy Now Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: kAppWhiteColor,
              primaryColor: kAppRedColor,
              fontFamily: 'Montesrrat',
              appBarTheme: AppBarTheme(
                color: kAppWhiteColor,
                elevation: 0.0,
              ),
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(kAppBlackColor),
                  overlayColor: MaterialStateProperty.all(kAppLightRedColor),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.all(
                      2.0,
                    ),
                  ),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => kAppRedColor,
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => kAppWhiteColor,
                  ),
                  textStyle: MaterialStateProperty.resolveWith(
                    (states) => TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              textTheme: TextTheme(
                headline5: TextStyle(
                  color: kAppDarkColor,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(
                  color: kAppRedColor,
                ),
                subtitle1: TextStyle(
                  color: kAppBlackColor,
                ),
                subtitle2: TextStyle(
                  color: kAppRedColor,
                ),
                overline: TextStyle(
                  color: kAppWhiteColor,
                ),
              ),
              iconTheme: IconThemeData(
                color: kAppGreyColor,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: kAppRedColor,
                unselectedItemColor: kAppGreyColor,
                type: BottomNavigationBarType.shifting,
                backgroundColor: kAppWhiteColor,
              ),
            ),
            darkTheme: ThemeData(),
            themeMode: ThemeMode.light,
            home: Directionality(
              child: startPoint,
              textDirection: AppCubit.get(context).textDirection,
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
