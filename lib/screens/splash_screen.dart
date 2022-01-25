import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_clear/screens/home_screen.dart';
import 'package:open_clear/screens/login_screen.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if(user==null)
      {
        Timer(Duration(seconds: 3), () async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
        });
      }
    else
      {
        Timer(Duration(seconds: 3), () async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 150.h,
                    width: 150.w,
                    child: Image.asset('assets/images/logo.png',height: 100.h,),
                  ),
                  Positioned(
                      right: 0,
                      top: 53.h,
                      child: Text("TM", style: TextStyle(fontSize: 12.h),))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
