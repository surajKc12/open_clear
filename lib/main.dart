import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_clear/screens/addcard_screen.dart';
import 'package:open_clear/screens/edit_card.dart';
import 'package:open_clear/screens/forgetPassword_screen.dart';
import 'package:open_clear/screens/home_screen.dart';
import 'package:open_clear/screens/login_screen.dart';
import 'package:open_clear/screens/signup_screen.dart';
import 'package:open_clear/screens/splash_screen.dart';

import 'model/card.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MaterialApp(
        title: 'OpenClear',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        routes: <String, WidgetBuilder>{
          '/signup': (BuildContext context) =>  SignupPage(),
          '/login': (BuildContext context) =>  LoginScreen(),
          '/homeScreen': (BuildContext context) => HomeScreen(),
          '/forgetPasswordScreen': (BuildContext context) => ForgotPassword(),
          '/addCardScreen': (BuildContext context) => AddCardScreen()

        },
        home: SplashScreen(),
      ),
    );
  }
}

