import 'package:buy_now_demo/models/language/language_model.dart';
import 'package:buy_now_demo/modules/on_boarding/on_boarding_screen.dart';
import 'package:buy_now_demo/shared/app_cubit/cubit.dart';
import 'package:buy_now_demo/shared/app_cubit/states.dart';
import 'package:buy_now_demo/shared/components/constants.dart';
import 'package:buy_now_demo/shared/components/widgets.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectLanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 50.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        'Select your language.',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        'من فضلك اختار اللغة',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return buildLanguageItem(
                      context,
                      model: languageList[index],
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: buildSeparator(),
                  ),
                  itemCount: languageList.length,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: BlocConsumer<AppCubit, AppStates>(
                  builder: (context, state) {
                    return ConditionalBuilder(
                      fallback: (context) => linerProgressIndicator(),
                      builder: (context) {
                        return buildDefaultButton(
                          text: appLang(context).continueText,
                          onPressed: () {
                            int currentIndex =
                                AppCubit.get(context).selectedLanguageIndex;
                            var model = languageList[currentIndex];
                            if (currentIndex == null) {
                              showToast(
                                text: 'Please select a language!',
                                color: ToastColors.WARNING,
                              );
                            } else {
                              setAppLanguageToShared(code: model.code)
                                  .then((value) {
                                getTranslationFile(appLanguage: model.code)
                                    .then((value) {
                                  AppCubit.get(context)
                                      .setAppLanguage(
                                    translateFile: value,
                                    code: model.code,
                                  )
                                      .then((value) {
                                    navigateAndFinish(
                                        context: context,
                                        widgetScreen: OnBoardScreen());
                                  });
                                }).catchError((error) {});
                              }).catchError((error) {
                                print(error.toString());
                              });

                              print(model.code);
                            }
                          },
                        );
                      },
                      condition: state is! AppSetDirectionState ||
                          state is! AppSetLanguageState,
                    );
                  },
                  listener: (context, state) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
