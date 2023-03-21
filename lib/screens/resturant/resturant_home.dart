import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturants/screens/resturant/resturantList.dart';
import 'package:resturants/screens/resturant/resturant_meals.dart';

import '../auth/login.dart';
import '../models/users_model.dart';

class ResturantHome extends StatefulWidget {
  static const routeName = '/resturantHome';
  const ResturantHome({super.key});

  @override
  State<ResturantHome> createState() => _ResturantHomeState();
}

class _ResturantHomeState extends State<ResturantHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Users currentUser;

  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            body: Column(
          children: [
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [.01, .25],
                    colors: [
                      Color(0xfff8a55f),
                      Color(0xfff1665f),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100.w,
                    ),
                    Text(
                      "الصفحة الرئيسية",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'ElMessiri',
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 80.w,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xfff8a55f), //<-- SEE HERE
                      child: IconButton(
                        icon: Center(
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('تأكيد'),
                                  content: Text('هل انت متأكد من تسجيل الخروج'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                        Navigator.pushNamed(
                                            context, LoginPage.routeName);
                                      },
                                      child: Text('نعم'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('لا'),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Image.asset('assets/images/r.png'),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'الخدمات المتاحة',
              style: TextStyle(
                  fontSize: 27, color: Colors.black, fontFamily: 'ElMessiri'),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ResturantMeals(
                          resturantName: '${currentUser.fullName}',
                        );
                      }));
                    },
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w, left: 10.w),
                        child: Center(
                          child: Column(children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Image.asset('assets/images/meal.jfif',
                                width: 120.w, height: 120.h),
                            SizedBox(
                              height: 10.h,
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "أضافة وجبة",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 18,
                                    fontFamily: 'ElMessiri',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ResturantList(
                          name: '${currentUser.fullName}',
                        );
                      }));
                    },
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w, left: 10.w),
                        child: Center(
                          child: Column(children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Image.asset('assets/images/list.png',
                                width: 120.w, height: 120.h),
                            SizedBox(
                              height: 10.h,
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "قائمة الحجوزات",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 18,
                                    fontFamily: 'ElMessiri',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
