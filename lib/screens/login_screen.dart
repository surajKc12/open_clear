import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_clear/service/firebaseaAuth_service.dart';
import 'package:open_clear/validator.dart';
import 'package:open_clear/widgets/my_dialog.dart';

import '../constant.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  late _Controller con;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    con = _Controller(this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    height: 80.h,
                    child: Image.asset('assets/images/logo.png',height: 100,),
                  ),
                  Positioned(
                      right: 0,
                      top: 15.h,
                      child: Text("TM"))
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0.h, left: 20.0.w, right: 20.0.h),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: Validation.validateEmail,
                        onSaved: con.saveEmail,
                        decoration: const InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 20.0.h),
                      TextFormField(
                        validator: Validation.validatePassword,
                        onSaved: con.savePassword,
                        decoration: const InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                      ),
                      SizedBox(height: 5.0.h),
                      Container(
                        alignment: const Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(top: 15.0.h, left: 20.0.w),
                        child:  InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/forgetPasswordScreen');

                          },
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0.h),
                      SizedBox(
                        height: 40.0,
                        child: GestureDetector(
                          onTap: con.signIn,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0.r),
                            shadowColor: Colors.blueAccent,
                            color: Colors.blue,
                            elevation: 7.0,
                            child: const Center(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 15.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'New to OpenClear?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0.w),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }
}

class _Controller {
  late _LoginScreenState state;
  _Controller(this.state);
  String? email;
  String? password;

  String? saveEmail(String? value) {
    if (value != null) email = value;
    return email;
  }

  String? savePassword(String? value) {
    if (value != null) password = value;
    return password;
  }

  void signIn() async {
    FormState? currentState = state.formkey.currentState;
    if (currentState == null || !currentState.validate()) return;

    currentState.save();

    User? user;
    MyDialog.circularProgressStart(state.context);
    try {
      if (email == null || password == null) {
        throw 'Email or passowrd is null';
      }
      user = await FirebaseAuthController.signIn(
          email: email!, password: password!);
      print('${user?.email}');
      if(user!=null) {
        Navigator.of(state.context).pushNamedAndRemoveUntil('/homeScreen', (route) => false);
      }

    } catch (e) {
      MyDialog.circularProgressStop(state.context);
      // ignore: avoid_print
      if (Constant.DEV) print('----Signin error: $e');
      MyDialog.showSnackBar(
        context: state.context,
        message: 'Sign In Error: $e',
        seconds: 30,
      );
    }
  }
}
