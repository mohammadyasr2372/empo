// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../../../core/strings/constans.dart';
import '../widgets/app_bar_auth.dart';
import '../widgets/my_form_sing_in.dart';
import 'component/curve_cliper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formSignInKeyUser = GlobalKey<FormState>();
  final _formSignInKeyVendor = GlobalKey<FormState>();
  bool isUserSelected = false;
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBady(),
    );
  }

  SingleChildScrollView _buildBady() {
    return SingleChildScrollView(
      child: Container(
        // height: height,
        child: Column(
          children: [
            ClipPath(
              clipper: CurveCliper(),
              child: Image.asset(
                IMAGE_BAGRAOUND,
                fit: BoxFit.cover,
              ),
            ),
            AppBarAuth(
              isUserSelected: isUserSelected,
              onPressedVendor: () {
                setState(() {
                  isUserSelected = false;
                });
              },
              onPressedUser: () {
                setState(() {
                  isUserSelected = true;
                });
              },
            ),
            isUserSelected
                ? MyFormSingIn(
                    formSignupKey: _formSignInKeyUser,
                    isUserSelected: isUserSelected)
                : MyFormSingIn(
                    formSignupKey: _formSignInKeyVendor,
                    isUserSelected: isUserSelected),
          ],
        ),
      ),
    );
  }
}
