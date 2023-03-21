import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:resturants/screens/user/user_home.dart';

import '../models/users_model.dart';

class FetchMeals extends StatefulWidget {
  String name;
  String price;
  String content;
  String date;
  String imageUrl;
  String type;
  String resturantName;
  FetchMeals({
    required this.name,
    required this.price,
    required this.content,
    required this.date,
    required this.imageUrl,
    required this.type,
    required this.resturantName,
  });

  @override
  State<FetchMeals> createState() => _FetchMealsState();
}

class _FetchMealsState extends State<FetchMeals> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  var amountController = TextEditingController();

    late Users currentUser;

  @override
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
      print(currentUser.fullName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
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
                        width: 150.w,
                      ),
                      Text(
                        "${widget.name}",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'ElMessiri',
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 90.w,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xfff8a55f), //<-- SEE HERE
                        child: IconButton(
                          icon: Center(
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 15, bottom: 15),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 15.w),
                              child: Image.network('${widget.imageUrl}'),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'نوع الوجبة : ${widget.type}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'السعر : EGP${widget.price}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'المحتوى: ${widget.content}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'مدة التحضير : ${widget.date}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0.0),
                  elevation: 5,
                ),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Notice"),
                        content: SizedBox(
                          height: 65.h,
                          child: TextField(
                            controller: amountController,
                            decoration: InputDecoration(
                              fillColor: HexColor('#155564'),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xfff8a55f), width: 2.0),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'ادخل الكمية',
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: HexColor('#6bbcba'),
                            ),
                            child: Text("اضافة"),
                            onPressed: () async {
                              String name = widget.name.toString();
                              int? price = int.parse(widget.price);
                              int amount =
                                  int.parse(amountController.text.trim());
                              int total = price* amount;
                              String imageUrl =
                                  widget.imageUrl.toString();

                              if (amount == 0) {
                                MotionToast(
                                        primaryColor: Colors.blue,
                                        width: 300,
                                        height: 50,
                                        position: MotionToastPosition.center,
                                        description: Text('ادخل الكمية'))
                                    .show(context);
                                return;
                              }

                              User? user = FirebaseAuth.instance.currentUser;

                              if (user != null) {
                                String uid = user.uid;

                                DatabaseReference companyRef = FirebaseDatabase
                                    .instance
                                    .reference()
                                    .child('cart')
                                    .child(uid);

                                String? id = companyRef.push().key;

                                await companyRef.child(id!).set({
                                  'id': id,
                                  'name': name,
                                  'price': price,
                                  'amount': amount,
                                  'total': total,
                                  'imageUrl': imageUrl,
                                  'resturantName': widget.resturantName,
                                  'userName': currentUser.fullName,
                                  'userPhone': currentUser.phoneNumber,
                                  
                                });
                               
                              }

                              showAlertDialog(context);
                              Navigator.pushNamed(
                                  context, UserHome.routeName);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xfff8a55f),
                      Color(0xfff1665f),
                    ]),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    constraints: const BoxConstraints(minWidth: 88.0),
                    child: const Text('أضافة الى السلة',
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, UserHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم الأضافة فى سلة المشتريات"),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
