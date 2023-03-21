import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:ndialog/ndialog.dart';
import 'package:resturants/screens/auth/signup.dart';

import '../../fade_animation.dart';
import '../admin/admin_home.dart';

class AdminLogin extends StatefulWidget {
  static const routeName = '/adminLogin';
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  // Colors.purple,
                  Color(0xfff8a55f),
                  Color(0xfff1665f),
                ])),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: const FadeAnimation(
                      2,
                      Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      margin: const EdgeInsets.only(top: 30),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            FadeAnimation(
                              2,
                              Container(
                                  width: double.infinity,
                                  height: 60,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xfff8a55f), width: 1),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0xfff8a55f),
                                            blurRadius: 10,
                                            offset: Offset(1, 1)),
                                      ],
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.email_outlined),
                                      Expanded(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: TextFormField(
                                            controller: emailController,
                                            maxLines: 1,
                                            decoration: const InputDecoration(
                                              label: Text("البريد الألكترونى"),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            FadeAnimation(
                              2,
                              Container(
                                  width: double.infinity,
                                  height: 60,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xfff8a55f), width: 1),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0xfff8a55f),
                                            blurRadius: 10,
                                            offset: Offset(1, 1)),
                                      ],
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.password_outlined),
                                      Expanded(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: TextFormField(
                                            controller: passwordController,
                                            maxLines: 1,
                                            decoration: const InputDecoration(
                                              label: Text("كلمة المرور"),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                              2,
                              ElevatedButton(
                                onPressed: () async {
                                  var email = emailController.text.trim();
                                  var password = passwordController.text.trim();

                                  if (email.isEmpty || password.isEmpty) {
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description:
                                                Text("please fill all fields"))
                                        .show(context);

                                    return;
                                  }

                                  if (email != 'admin@gmail.com') {
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description:
                                                Text("wrong email or password"))
                                        .show(context);

                                    return;
                                  }

                                  if (password != '123456789') {
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description:
                                                Text("wrong email or password"))
                                        .show(context);

                                    return;
                                  }

                                  ProgressDialog progressDialog =
                                      ProgressDialog(context,
                                          title: Text('Logging In'),
                                          message: Text('Please Wait'));
                                  progressDialog.show();

                                  try {
                                    FirebaseAuth auth = FirebaseAuth.instance;
                                    UserCredential userCredential =
                                        await auth.signInWithEmailAndPassword(
                                            email: email, password: password);

                                    if (userCredential.user != null) {
                                      progressDialog.dismiss();
                                       Navigator.pushNamed(context, AdminHome.routeName);
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    progressDialog.dismiss();
                                    if (e.code == 'user-not-found') {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description:
                                                  Text("user not found"))
                                          .show(context);

                                      return;
                                    } else if (e.code == 'wrong-password') {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description: Text(
                                                  "wrong email or password"))
                                          .show(context);

                                      return;
                                    }
                                  } catch (e) {
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description:
                                                Text("something went wrong"))
                                        .show(context);

                                    progressDialog.dismiss();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.purpleAccent,
                                    shadowColor: Colors.purpleAccent,
                                    elevation: 18,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [
                                        Color(0xfff8a55f),
                                        Color(0xfff1665f),
                                      ]),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'سجل دخول',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
