// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names
import 'package:flutter/material.dart';
import '../../../../core/strings/constans.dart';
import '../widgets/app_bar_auth.dart';
import '../widgets/my_form_sing_up.dart';
import 'component/curve_cliper.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _formSignupKeyUser = GlobalKey<FormState>();
  final _formSignupKeyVendor = GlobalKey<FormState>();
  bool isUserSelected = false;
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
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
              if (isUserSelected)
                MyFormSingUp(
                    formSignupKey: _formSignupKeyUser,
                    isUserSelected: isUserSelected),
              if (!isUserSelected)
                MyFormSingUp(
                    formSignupKey: _formSignupKeyVendor,
                    isUserSelected: isUserSelected),
            ],
          ),
        ),
      ),
    );
  }
}
