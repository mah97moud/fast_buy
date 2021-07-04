import 'package:buy_now_demo/layouts/home/home_layout.dart';
import 'package:buy_now_demo/modules/login/login_screen.dart';
import 'package:buy_now_demo/shared/app_cubit/cubit.dart';
import 'package:buy_now_demo/shared/components/constants.dart';
import 'package:buy_now_demo/shared/components/widgets.dart';
import 'package:buy_now_demo/shared/di/di.dart';
import 'package:buy_now_demo/shared/network/local/cache_helper.dart';
import 'package:buy_now_demo/shared/styles/color.dart';
import 'package:buy_now_demo/shared/styles/my_icons_icons.dart';
import 'package:buy_now_demo/shared/user_cubit/cubit.dart';
import 'package:buy_now_demo/shared/user_cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUPScreen extends StatelessWidget {
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passCon = TextEditingController();
  final TextEditingController nameCon = TextEditingController();
  final TextEditingController phoneCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppCubit.get(context).textDirection,
      child: BlocProvider(
        create: (BuildContext context) => di<UserCubit>(),
        child: BlocConsumer<UserCubit, UserStates>(
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.0),
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Text(
                        appLang(context).signUp,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        appLang(context).signupText1,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        appLang(context).signupText2,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50.0,
                            ),
                            buildTextFormField(
                              context,
                              control: nameCon,
                              validateText: appLang(context).validName,
                              text: appLang(context).name,
                              keyboardType: TextInputType.text,
                              icon: Icon(MyIcons.head),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            buildTextFormField(
                              context,
                              control: phoneCon,
                              validateText: appLang(context).validPhone,
                              text: appLang(context).phone,
                              keyboardType: TextInputType.number,
                              icon: Icon(MyIcons.telephone_1),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            buildTextFormField(
                              context,
                              control: emailCon,
                              validateText: appLang(context).validMail,
                              text: appLang(context).email,
                              keyboardType: TextInputType.emailAddress,
                              icon: Icon(MyIcons.mail),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            buildTextFormField(
                              context,
                              control: passCon,
                              text: appLang(context).password,
                              validateText: appLang(context).validPassword,
                              isObscure: true,
                              keyboardType: TextInputType.text,
                              icon: Icon(MyIcons.padlock),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! UserLoginLoadingState,
                              builder: (context) {
                                return buildDefaultButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      UserCubit.get(context).userSignup(
                                        phone: phoneCon.text,
                                        name: nameCon.text,
                                        context: context,
                                        email: emailCon.text,
                                        password: passCon.text,
                                      );
                                    }
                                  },
                                  text: appLang(context).signUp,
                                );
                              },
                              fallback: (context) => linerProgressIndicator(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(appLang(context).haveAnAccount),
                          TextButton(
                            onPressed: () {
                              navigateTo(
                                context: context,
                                widgetScreen: LoginScreen(),
                              );
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                kAppLightGreyColor,
                              ),
                            ),
                            child: Text(
                              appLang(context).signIn,
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is UserLoginSuccessState) {
              di<CacheHelper>()
                  .put('userData', state.userModel.data)
                  .then((value) {
                di<CacheHelper>()
                    .put('userToken', state.userModel.data.token)
                    .then((value) {
                  print('Token ------> ${di<CacheHelper>().get('usrToken')}');
                  navigateAndFinish(
                    context: context,
                    widgetScreen: HomeLayout(),
                  );
                  showToast(
                    text: state.userModel.message,
                    color: ToastColors.SUCCESS,
                  );
                });
              }).catchError((error) {});
            }
          },
        ),
      ),
    );
  }
}
