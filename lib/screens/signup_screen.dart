import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_clear/service/firebaseaAuth_service.dart';
import 'package:open_clear/service/firestore_service.dart';
import 'package:open_clear/validator.dart';
import 'package:open_clear/widgets/my_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant.dart';
import '../user_model.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0.w, 110.0.h, 0.0, 0.0),
                  child: Text(
                    'Signup',
                    style:
                    TextStyle(
                      color: Colors.green,
                        fontSize: 80.0.h, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(260.0.w, 125.0.h, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0.h, left: 20.0.w, right: 20.0.w),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onSaved: con.saveEmail,
                        validator: Validation.validateEmail,
                        decoration: const InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 10.0.h),
                      TextFormField(
                        onSaved: con.savePassword,
                        validator: Validation.validatePassword,
                        decoration: const InputDecoration(
                            labelText: 'PASSWORD ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                      ),
                      SizedBox(height: 10.0.h),
                      TextFormField(
                        onSaved: con.saveConfirmPassword,
                        validator: Validation.validatePassword,
                        decoration: const InputDecoration(
                            labelText: 'CONFIRM PASSWORD ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                      ),
                      SizedBox(height: 30.0.h),
                      RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                        style: TextStyle(
                        ),
                        children: [
                          TextSpan(
                            text: "By continuing and signing up for an account,"
                                " you confirm that you agree to OpenClear's ",
                            style: TextStyle(
                              color: Colors.black
                            ),
                          ),
                          TextSpan(
                            recognizer: new TapGestureRecognizer()..onTap = () {
                              launch('https://blue-cymbals-aslr.squarespace.com/');

                            },
                            text: 'User Agreement',
                            style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                          TextSpan(
                            text: " and acknowledge that you have "
                                "read OpenClear\'s ",
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                          TextSpan(
                            recognizer: new TapGestureRecognizer()..onTap = () {
                              launch('https://blue-cymbals-aslr.squarespace.com/');
                            },
                            text:  'Privacy Notice.',
                            style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),

                          )
                        ]
                      )),
                      SizedBox(height: 10.0.h),
                      SizedBox(
                          height: 40.0.h,
                          child: GestureDetector(
                            onTap: con.signUp,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.blueAccent,
                              color: Colors.blue,
                              elevation: 7.0,
                              child: const Center(
                                child: Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 20.0.h),
                      Container(
                        height: 40.0.h,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0.r)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child:

                            const Center(
                              child: Text('Go Back',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),


                          ),
                        ),
                      ),
                      SizedBox(height: 20.0.h),

                    ],
                  ),
                )),
            // SizedBox(height: 15.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text(
            //       'New to Spotify?',
            //       style: TextStyle(
            //         fontFamily: 'Montserrat',
            //       ),
            //     ),
            //     SizedBox(width: 5.0),
            //     InkWell(
            //       child: Text('Register',
            //           style: TextStyle(
            //               color: Colors.green,
            //               fontFamily: 'Montserrat',
            //               fontWeight: FontWeight.bold,
            //               decoration: TextDecoration.underline)),
            //     )
            //   ],
            // )
          ]),
        ));
  }
}

class _Controller {
  late _SignupPageState state;
  _Controller(this.state);
  String? email;
  String? password;
  String? confirmPassword;
  Person person = Person();

  String? saveEmail(String? value) {
    if (value != null) email = value;
    return email;
  }

  String? savePassword(String? value) {
    if (value != null) password = value;
    return password;
  }
  String? saveConfirmPassword(String? value) {
    if (value != null) confirmPassword = value;
    return confirmPassword;
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
     // if(user!=null)
       // Get.off(() => BottomNavBar());
    } catch (e) {
      MyDialog.circularProgressStop(state.context);
      if (Constant.DEV) print('----Signin error: $e');
      MyDialog.showSnackBar(
        context: state.context,
        message: 'Sign In Error: $e',
        seconds: 30,
      );
    }
  }
  void signUp() async {
    FormState? currentState = state.formkey.currentState;
    if (currentState == null || !currentState.validate()) return;
    currentState.save();

    if (password != confirmPassword) {
      MyDialog.showSnackBar(
        context: state.context,
        message: 'Password and confirm do not match',
        seconds: 3,
      );
      return;
    }

    MyDialog.circularProgressStart(state.context);

    try {
      await FirebaseAuthController.createAccount(
          email: email!, password: password!);
      User? user =FirebaseAuth.instance.currentUser;
      person.email=email!;
      person.password=password;
      person.timestamp = DateTime.now();

      await FirestoreConroller.addPerson(person: person);
      MyDialog.circularProgressStop(state.context);
      Navigator.of(state.context).pushNamed('/login');
      MyDialog.showSnackBar(
          context: state.context,
          message: 'Account created! Sign in to use the App.');


    } catch (e) {
      MyDialog.circularProgressStop(state.context);
      if (Constant.DEV) print('---create account error: $e');
      MyDialog.showSnackBar(
        context: state.context,
        message: 'Cannot create account: $e',
      );
    }
  }
}
