// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:party/core/strings/constans.dart';
import 'package:party/core/util/snackbar_message.dart';
import 'package:party/features/auth/domain/entities/shopper_entity.dart';
import 'package:party/features/auth/domain/entities/user_entity.dart';
import 'package:party/features/auth/presentation/bloc/post_put_delet_shopper/post_put_delet_shopper_bloc.dart';
import 'package:party/features/auth/presentation/bloc/post_put_delet_user/post_put_delet_user_bloc.dart';
import 'package:party/features/auth/presentation/pages/login_screen.dart';
import 'package:party/features/auth/presentation/widgets/button.dart';
import 'package:party/features/auth/presentation/widgets/drop_down_item_event_type.dart';
import 'package:party/features/auth/presentation/widgets/text_from_feald_auth.dart';

import '../../../hotel/presentation/pages/hotel/post_hotel/hotel_post.dart';

TextEditingController email = TextEditingController();
TextEditingController name = TextEditingController();
TextEditingController mobile = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController location = TextEditingController();

class MyFormSingUp extends StatelessWidget {
  final GlobalKey<FormState> formSignupKey;
  final bool isUserSelected;
  const MyFormSingUp(
      {super.key, required this.formSignupKey, required this.isUserSelected});
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formSignupKey,
      child: Column(children: [
        TextFromFieldForAuth(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Email';
            } else if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
              return "it is not email";
            }
            return null;
          },
          icon: const Icon(Icons.email),
          title: 'Email Address',
          hintText: 'Enter your email',
          textEditingController: email,
          obscureText: false,
        ),
        TextFromFieldForAuth(
          icon: const Icon(Icons.person),
          title: 'Name',
          hintText: 'Enter your email',
          textEditingController: name,
          obscureText: false,
        ),
        TextFromFieldForAuth(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone';
            } else if (mobile.text.length < 10) {
              return 'the phone is not correct';
              // return "Success";
            } else {
              try {
                int.parse(value);
              } catch (e) {
                return 'this isn\'t number';
              }
            }
            return null;
          },
          icon: const Icon(Icons.mobile_friendly),
          title: 'Mobile phone',
          hintText: 'Enter your mobile phone',
          textEditingController: mobile,
          obscureText: false,
        ),
        TextFromFieldForAuth(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Password';
            } else if (password.text.length < 8) {
              return 'the password is short';
            } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                .hasMatch(value)) {
              return 'the password need char smoll,capital,num';
              // return "Success";
            }
            return null;
          },
          icon: const Icon(Icons.lock),
          title: 'Password',
          hintText: 'Enter your password',
          textEditingController: password,
          obscureText: true,
        ),
        if (isUserSelected)
          TextFromFieldForAuth(
            icon: const Icon(Icons.location_city),
            title: 'location',
            hintText: 'Enter your location',
            textEditingController: location,
            obscureText: false,
          ),
        if (!isUserSelected)
          const SizedBox(
            height: 20,
          ),
        if (!isUserSelected)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: DropDownItemEvent(),
          ),
        const SizedBox(
          height: 10,
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
                        message: 'email Already Exists!', context: context);
                  }
                },
                builder: (context, state) {
                  if (state is LoadingPostPutDeletUserState) {
                    return CircularProgressIndicator();
                  }
                  return ButtonAuth(
                      title: 'SingUp',
                      onPressed: () {
                        if (formSignupKey.currentState!.validate()) {
                          BlocProvider.of<PostPutDeletUserBloc>(context).add(
                              RegisterUserEvent(
                                  user: User(
                                      mobile: mobile.text,
                                      name: name.text,
                                      location: location.text,
                                      password: password.text,
                                      email: email.text)));
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
                        MaterialPageRoute(
                            builder: (_) => /*AddInfoShopper CreateWallet*/
                                PostHotel()),
                        (route) => false);
                  } else if (state is ErrorPostPutDeletShopperState) {
                    SnackBarMessage().showErrorSnackBar(
                        message: 'email Already Exists!', context: context);
                  }
                },
                builder: (context, state) {
                  if (state is LoadingPostPutDeletShopperState) {
                    return CircularProgressIndicator();
                  }
                  return ButtonAuth(
                      title: 'SingUp',
                      onPressed: () {
                        if (formSignupKey.currentState!.validate()) {
                          BlocProvider.of<PostPutDeletShopperBloc>(context).add(
                              RegisterShopperEvent(
                                  shopper: Shopper(
                                      mobile: mobile.text,
                                      name: name.text,
                                      event_type: selectedValue,
                                      password: password.text,
                                      email: email.text)));
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
        ButtonAuth(
          title: 'Continue With Fasebook',
          onPressed: () {},
          width: width - 20,
          icon: const FlutterLogo(),
          colorBag: Colors.white,
          colorText: Colors.black,
        ),
        const Text("ـــــــــــــــــــــــــــــــــــــــــــ "),
        TextNavigator(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage())),
            title: 'Already have an account? ',
            textNav: 'Sign in'),
        const SizedBox(
          height: 20,
        )
      ]),
    );
  }
}
