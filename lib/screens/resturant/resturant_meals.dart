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
import 'package:resturants/screens/admin/add_resturant.dart';
import 'package:resturants/screens/models/resturant_model.dart';
import 'package:resturants/screens/resturant/add_meal.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../auth/login.dart';
import '../models/meal_model.dart';
import '../models/users_model.dart';

class ResturantMeals extends StatefulWidget {
  String resturantName;
  static const routeName = '/resturantMeals';
  ResturantMeals({required this.resturantName});

  @override
  State<ResturantMeals> createState() => _ResturantMealsState();
}

class _ResturantMealsState extends State<ResturantMeals> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Meal> mealList = [];
  List<String> keyslist = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchResturant();
  }

  @override
  void fetchResturant() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("meals").child("${widget.resturantName}");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Meal p = Meal.fromJson(event.snapshot.value);
      mealList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddMeal(
                    resturantName: '${widget.resturantName}',
                  );
                }));
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // circular shape
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfff8a55f),
                      Color(0xfff1665f),
                    ],
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
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
                          width: 150.w,
                        ),
                        Text(
                          "الوجبات",
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
                Expanded(
                  flex: 8,
                  child: ListView.builder(
                      itemCount: mealList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 15.w, left: 15.w),
                              child: Card(
                               
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        right: 15,
                                        left: 15,
                                        bottom: 10),
                                    child: Row(children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 10.w),
                                        child: Column(
                                          children: [
                                            Text(
                                              '${mealList[index].name.toString()}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            
                                            Text(
                                              'النوع : ${mealList[index].type.toString()} ',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              'السعر : EGP ${mealList[index].price.toString()}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            super.widget));
                                                base
                                                    .child(mealList[index]
                                                        .id
                                                        .toString())
                                                    .remove();
                                              },
                                              child: Icon(Icons.delete,
                                                  color: Color.fromARGB(
                                                      255, 122, 122, 122)),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60.w,
                                      ),
                                      Container(
                                          width: 110.w,
                                          height: 170.h,
                                          child: Image.network(
                                              '${mealList[index].imageUrl.toString()}')),
                                    ]),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            )
                          ],
                        );
                      }),
                ),
              ],
            )),
      ),
    );
  }
}
