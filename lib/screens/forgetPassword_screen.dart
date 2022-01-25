
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../validator.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late String email;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.h),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                    SizedBox(height: 20.h,),
                    Text("We will sent you the reset request "
                        "to your email. Check your inbox", textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 15.h
                    ),),
                    SizedBox(
                      height: 50.h,
                    ),
                    Container(
                      child: Form(
                        key: formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              onSaved: (newValue) {
                                setState(() {
                                  email=newValue!;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  email=value;
                                });
                              },
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

                            SizedBox(height: 20,),

                            SizedBox(
                                height: 40.0,
                                child: GestureDetector(
                                  onTap: () {
                                    if(formkey.currentState!.validate())
                                      {
                                        FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                                          Navigator.pop(context);
                                      }

                                   // Get.to(() => ForgotPassword1());
                                  },
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20.0.r),
                                    shadowColor: Colors.blueAccent,
                                    color: Colors.blue,
                                    elevation: 7.0,
                                    child: const Center(
                                      child: Text(
                                        'SEND',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
