import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resturants/screens/admin/add_resturant.dart';
import 'package:resturants/screens/admin/admin_home.dart';
import 'package:resturants/screens/admin/admin_resturants.dart';
import 'package:resturants/screens/auth/admin_login.dart';
import 'package:resturants/screens/auth/login.dart';
import 'package:resturants/screens/auth/resturant_login.dart';
import 'package:resturants/screens/auth/signup.dart';
import 'package:resturants/screens/resturant/add_meal.dart';
import 'package:resturants/screens/resturant/resturant_home.dart';
import 'package:resturants/screens/resturant/resturant_meals.dart';
import 'package:resturants/screens/user/user_cart.dart';
import 'package:resturants/screens/user/user_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginPage()
          : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? const AdminHome()
              : FirebaseAuth.instance.currentUser!.displayName == 'مطعم'
                  ? const ResturantHome()
                  : UserHome(),
      routes: {
        SignupPage.routeName: (ctx) => SignupPage(),
        LoginPage.routeName: (ctx) => LoginPage(),
        AdminHome.routeName: (ctx) => AdminHome(),
        AdminLogin.routeName: (ctx) => AdminLogin(),
        ResturantLogin.routeName: (ctx) => ResturantLogin(),
        AdminResturants.routeName: (ctx) => AdminResturants(),
        AddResturant.routeName: (ctx) => AddResturant(),
        UserHome.routeName: (ctx) => UserHome(),
        UserCart.routeName: (ctx) => UserCart(),
        ResturantHome.routeName: (ctx) => ResturantHome(),
        
      },
    );
  }
}
