// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:party/core/strings/constans.dart';
import 'package:party/core/util/snackbar_message.dart';
import 'package:party/features/auth/domain/entities/shopper_entity.dart';
import 'package:party/features/auth/domain/entities/user_entity.dart';
import 'package:party/features/auth/presentation/bloc/post_put_delet_shopper/post_put_delet_shopper_bloc.dart';
import 'package:party/features/auth/presentation/bloc/post_put_delet_user/post_put_delet_user_bloc.dart';
import 'package:party/features/auth/presentation/pages/sing_up_page.dart';
import 'package:party/features/auth/presentation/widgets/button.dart';
import 'package:party/features/auth/presentation/widgets/text_from_feald_auth.dart';
import 'package:party/features/hotel/presentation/pages/hotel/post_hotel/hotel_post.dart';

TextEditingController emailLog = TextEditingController();
TextEditingController passwordLog = TextEditingController();

class MyFormSingIn extends StatelessWidget {
  final GlobalKey<FormState> formSignupKey;
  final bool isUserSelected;
  const MyFormSingIn(
      {super.key, required this.formSignupKey, required this.isUserSelected});
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formSignupKey,
      child: Column(children: [
        TextFromFieldForAuth(
          icon: const Icon(Icons.email),
          title: 'Email Address',
          hintText: 'Enter your email',
          textEditingController: emailLog,
          obscureText: false,
        ),
        TextFromFieldForAuth(
          icon: const Icon(Icons.lock),
          title: 'Password',
          hintText: 'Enter your password',
          textEditingController: passwordLog,
          obscureText: true,
        ),
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
              onPressed: () {},
              child: const Text(
                "Forgot Password ?",
                style: TextStyle(color: Colors.black),
              )),
        ),
        isUserSelected
            ? BlocConsumer<PostPutDeletUserBloc, PostPutDeletUserState>(
                listener: (context, state) {
                  if (state is MessagePostPutDeletUserState) {
                    SnackBarMessage().showSuccessSnackBar(
                        message: state.message, context: context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => Scaffold()),
                        (route) => false);
                  } else if (state is ErrorPostPutDeletUserState) {
                    SnackBarMessage().showErrorSnackBar(
                        message: 'Email and Password is Incorrect...!',
                        context: context);
                  }
                },
                builder: (context, state) {
                  if (state is LoadingPostPutDeletUserState) {
                    return CircularProgressIndicator();
                  }
                  return ButtonAuth(
                      title: 'SingIn',
                      onPressed: () {
                        if (formSignupKey.currentState!.validate()) {
                          BlocProvider.of<PostPutDeletUserBloc>(context).add(
                              LoginUserEvent(
                                  user: User(
                                      password: passwordLog.text,
                                      email: emailLog.text)));
                        }
                      },
                      width: width - 20);
                },
              )
            : BlocConsumer<PostPutDeletShopperBloc, PostPutDeletShopperState>(
                listener: (context, state) {
                  if (state is MessagePostPutDeletShopperState) {
                    SnackBarMessage().showSuccessSnackBar(
                        message: state.message, context: context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => PostHotel()),
                        (route) => false);
                  } else if (state is ErrorPostPutDeletShopperState) {
                    SnackBarMessage().showErrorSnackBar(
                        message: 'Email and Password is Incorrect...!',
                        context: context);
                  }
                },
                builder: (context, state) {
                  if (state is LoadingPostPutDeletShopperState) {
                    return CircularProgressIndicator();
                  }
                  return ButtonAuth(
                      title: 'SingIn',
                      onPressed: () {
                        if (formSignupKey.currentState!.validate()) {
                          BlocProvider.of<PostPutDeletShopperBloc>(context).add(
                              LoginShopperEvent(
                                  shopper: Shopper(
                                      password: passwordLog.text,
                                      email: emailLog.text)));
                        }
                      },
                      width: width - 20);
                },
              ),
        const Text("ــــــــــــــ Or continue with ــــــــــــــ "),
        ButtonAuth(
          title: 'Continue With Google',
          onPressed: () {},
          width: width - 20,
          icon: const FlutterLogo(),
          colorBag: Colors.white,
          colorText: Colors.black,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("ـــــــــــــــــــــــــــــــــــــــــــ "),
        TextNavigator(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => SingUpPage())),
          title: 'Don\'t have an account? ',
          textNav: 'SignUp',
        ),
        const SizedBox(
          height: 20,
        )
      ]),
    );
  }
}
