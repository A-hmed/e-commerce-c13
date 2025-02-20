import 'package:ecommerce_app/core/di/di.dart';
import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/core/utils/dialog_utils.dart';
import 'package:ecommerce_app/core/widget/custom_elevated_button.dart';
import 'package:ecommerce_app/core/widget/main_text_field.dart';
import 'package:ecommerce_app/core/widget/validators.dart';
import 'package:ecommerce_app/features/auth/presentation/screens/sign_in/cubit/signIn_cubit.dart';
import 'package:ecommerce_app/features/auth/presentation/screens/sign_in/cubit/signin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

///Bloc Listener - Bloc Builder - Bloc Consumer
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  SignInCubit cubit = getIt();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
        bloc: cubit,

        ///Line is required if we did not add BlocProvider
        listener: (context, state) {
          if (state.loginApiState.hasError) {
            showMessage(context, state.loginApiState.errorMessage);
          }
          if (state.loginApiState.isSuccess) {
            Navigator.pushNamed(context, Routes.mainRoute);
          }
          if (state.loginApiState.isLoading) {
            showLoading(context);
          }
        },
        child: buildPageBody(context));
  }

  Scaffold buildPageBody(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppSize.s40.h,
                ),
                Center(child: SvgPicture.asset(SvgAssets.routeLogo)),
                SizedBox(
                  height: AppSize.s40.h,
                ),
                Text(
                  'Welcome Back To Route',
                  style: getBoldStyle(color: ColorManager.white)
                      .copyWith(fontSize: FontSize.s24.sp),
                ),
                Text(
                  'Please sign in with your mail',
                  style: getLightStyle(color: ColorManager.white)
                      .copyWith(fontSize: FontSize.s16.sp),
                ),
                SizedBox(
                  height: AppSize.s50.h,
                ),
                buildEmailTextField(),
                SizedBox(
                  height: AppSize.s28.h,
                ),
                buildPasswordTextField(),
                SizedBox(
                  height: AppSize.s8.h,
                ),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Forget password?',
                          style: getMediumStyle(color: ColorManager.white)
                              .copyWith(fontSize: FontSize.s18.sp),
                        )),
                  ],
                ),
                SizedBox(
                  height: AppSize.s60.h,
                ),
                buildLoginButton(context),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: getSemiBoldStyle(color: ColorManager.white)
                          .copyWith(fontSize: FontSize.s16.sp),
                    ),
                    SizedBox(
                      width: AppSize.s8.w,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.signUpRoute),
                      child: Text(
                        'Create Account',
                        style: getSemiBoldStyle(color: ColorManager.white)
                            .copyWith(fontSize: FontSize.s16.sp),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center buildLoginButton(BuildContext context) {
    return Center(
      child: SizedBox(
        // width: MediaQuery.of(context).size.width * .8,
        child: CustomElevatedButton(
          // borderRadius: AppSize.s8,
          isStadiumBorder: false,
          label: 'Login',
          backgroundColor: ColorManager.white,
          textStyle:
              getBoldStyle(color: ColorManager.primary, fontSize: AppSize.s18),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.mainRoute, (route) => false);
          },
        ),
      ),
    );
  }

  BuildTextField buildPasswordTextField() {
    return BuildTextField(
      hint: 'enter your password',
      backgroundColor: ColorManager.white,
      label: 'Password',
      validation: AppValidators.validatePassword,
      isObscured: true,
      textInputType: TextInputType.text,
    );
  }

  BuildTextField buildEmailTextField() {
    return BuildTextField(
      backgroundColor: ColorManager.white,
      hint: 'enter your name',
      label: 'User name',
      textInputType: TextInputType.emailAddress,
      validation: AppValidators.validateEmail,
    );
  }
}
