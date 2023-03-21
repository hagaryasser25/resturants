import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:ndialog/ndialog.dart';

import '../../fade_animation.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signupPage';
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();
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
                    margin: const EdgeInsets.only(top: 30),
                    child: const FadeAnimation(
                      2,
                      Text(
                        "انشاء حساب",
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
                              height: 10,
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
                                      const Icon(Icons.text_fields),
                                      Expanded(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: TextFormField(
                                            controller: nameController,
                                            maxLines: 1,
                                            decoration: const InputDecoration(
                                              label: Text("الأسم"),
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
                                      const Icon(Icons.phone),
                                      Expanded(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: TextFormField(
                                            controller: phoneNumberController,
                                            maxLines: 1,
                                            decoration: const InputDecoration(
                                              label: Text("رقم الهاتف"),
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
                                      const Icon(Icons.place),
                                      Expanded(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: TextFormField(
                                            controller: addressController,
                                            maxLines: 1,
                                            decoration: const InputDecoration(
                                              label: Text("العنوان"),
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
                              height: 10,
                            ),
                            FadeAnimation(
                              2,
                              ElevatedButton(
                                onPressed: () async {
                                  var name = nameController.text.trim();
                                  var phoneNumber =
                                      phoneNumberController.text.trim();
                                  var email = emailController.text.trim();
                                  var password = passwordController.text.trim();
                                  var address = addressController.text.trim();

                                  if (name.isEmpty ||
                                      email.isEmpty ||
                                      password.isEmpty ||
                                      phoneNumber.isEmpty ||
                                      address.isEmpty) {
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

                                  if (password.length < 6) {
                                    // show error toast
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description: Text(
                                                "Weak Password, at least 6 characters are required"))
                                        .show(context);

                                    return;
                                  }

                                  ProgressDialog progressDialog =
                                      ProgressDialog(context,
                                          title: Text('Signing Up'),
                                          message: Text('Please Wait'));
                                  progressDialog.show();

                                  try {
                                    FirebaseAuth auth = FirebaseAuth.instance;

                                    UserCredential userCredential = await auth
                                        .createUserWithEmailAndPassword(
                                      email: email,
                                      password: password,
                                    );
                                    User? user = userCredential.user;

                                    if (userCredential.user != null) {
                                      DatabaseReference userRef =
                                          FirebaseDatabase.instance
                                              .reference()
                                              .child('users');

                                      String uid = userCredential.user!.uid;
                                      int dt =
                                          DateTime.now().millisecondsSinceEpoch;

                                      await userRef.child(uid).set({
                                        'name': name,
                                        'email': email,
                                        'password': password,
                                        'uid': uid,
                                        'dt': dt,
                                        'phoneNumber': phoneNumber,
                                        'address': address,
                                      });

                                      Navigator.canPop(context)
                                          ? Navigator.pop(context)
                                          : null;
                                    } else {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description: Text("failed"))
                                          .show(context);
                                    }
                                    progressDialog.dismiss();
                                  } on FirebaseAuthException catch (e) {
                                    progressDialog.dismiss();
                                    if (e.code == 'email-already-in-use') {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description: Text(
                                                  "email is already exist"))
                                          .show(context);
                                    } else if (e.code == 'weak-password') {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description:
                                                  Text("password is weak"))
                                          .show(context);
                                    }
                                  } catch (e) {
                                    progressDialog.dismiss();
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description:
                                                Text("something went wrong"))
                                        .show(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    onPrimary: Color(0xfff8a55f),
                                    shadowColor: Color(0xfff8a55f),
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
                                      'انشاء حساب',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            )
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
