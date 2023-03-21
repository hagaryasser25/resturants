import 'package:animated_flip_card/animated_flip_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:resturants/screens/admin/admin_resturants.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../auth/login.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/adminHome';
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
                child: Center(
                    child: Text(
                  "الصفحة الرئيسية",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ElMessiri',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )),
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
                      Navigator.pushNamed(context, AdminResturants.routeName);
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
                            Image.asset('assets/images/logo.jfif',
                                width: 120.w, height: 120.h),
                            SizedBox(
                              height: 10.h,
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "أضافة مطعم",
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
                            Image.asset('assets/images/logout.png',
                                width: 120.w, height: 120.h),
                            SizedBox(
                              height: 10.h,
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "تسجيل الخروج",
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
