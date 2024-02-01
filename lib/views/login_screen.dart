import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:peanut/common/app_color.dart';
import 'package:peanut/service/auth_services.dart';
import 'package:peanut/service/network_service.dart';
import 'package:peanut/widget/custom_button.dart';
import 'package:peanut/widget/custom_progress_indicator.dart';
import 'package:peanut/widget/custom_snackbar.dart';
import 'package:peanut/widget/custom_text_field.dart';
import 'package:peanut/widget/my_text_style.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _userIdController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: size.width > 400 ? size.width * 0.60 : size.width,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height < 400 ? 200 : size.height * 0.35,
                      child: Center(
                        child: Container(
                          height: 280,
                          width: 360,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/logo.png',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height < 400 ? 400 : size.height * 0.65,
                      child: Container(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 10.0),
                        decoration: const BoxDecoration(
                          color: Color(0xffC8E6C9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'LogIn',
                                      style: myTextStyle(
                                          size: 30.0,
                                          fw: FontWeight.bold,
                                          clr: kPrimaryColor),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Login and start managing your account',
                                      style: myTextStyle(
                                          size: 15.0, clr: Colors.black38),
                                    ),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    CustomTextField(
                                      controller: _userIdController,
                                      hintText: 'Enter user id',
                                      lebelText: 'User Id',
                                      validatorText:
                                          'Please enter your user id',
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: kPrimaryColor,
                                      ),
                                      textInputAction: TextInputAction.next,
                                    ),
                                    const SizedBox(
                                      height: 12.0,
                                    ),
                                    CustomTextField(
                                      controller: _passwordController,
                                      hintText: 'Enter your password',
                                      lebelText: 'User Password',
                                      validatorText:
                                          'Please enter your password',
                                      obscureText: isObscure,
                                      radius: 30,
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: kPrimaryColor,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          // isObscure(!isObscure.value);
                                          setState(() {
                                            isObscure = !isObscure;
                                          });
                                        },
                                        child: Icon(
                                          isObscure == true
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25.0,
                                    ),
                                    CustomButton(
                                      onTap: () {
                                        _login(
                                            userId:
                                                _userIdController.text.trim(),
                                            userPass: _passwordController.text
                                                .trim());
                                      },
                                      title: 'LogIn',
                                      fontSize: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => SizedBox(
              height: double.infinity,
              width: double.infinity,
        
              // ignore: unrelated_type_equality_checks
              child: AuthServices.isLoading == true
                  ? Container(
                      color: Colors.black.withOpacity(0.5),
                      child: CustomProgressIndicator(),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
//------------------------Api Function---------------

  Future _login({required String userId, required String userPass}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      await NetworkService.checkInternetConnectivity().then((internet) async {
        if (internet) {
          await AuthServices().login(userId: userId, userPass: userPass);
        } else {
          customSnackBar(bgClr: Colors.red, msg: "Please check your internet");
        }
      });
    }
  }
}
