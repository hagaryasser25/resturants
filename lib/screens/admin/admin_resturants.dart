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
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../auth/login.dart';

class AdminResturants extends StatefulWidget {
  static const routeName = '/adminResturants';
  const AdminResturants({super.key});

  @override
  State<AdminResturants> createState() => _AdminResturantsState();
}

class _AdminResturantsState extends State<AdminResturants> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Resturant> resturantList = [];
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
    base = database.reference().child("resturant");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Resturant p = Resturant.fromJson(event.snapshot.value);
      resturantList.add(p);
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
                Navigator.pushNamed(context, AddResturant.routeName);
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
                          "المطاعم",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'ElMessiri',
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 90.w,),
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
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w, left: 20.w),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Container(
                          child: StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 15.w,
                              bottom: 15.h,
                            ),
                            crossAxisCount: 6,
                            itemCount: resturantList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: InkWell(
                                  onTap: () {},
                                  child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 10.w, left: 10.w),
                                      child: Center(
                                        child: Column(children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 10.h,
                                            ),
                                            child: CircleAvatar(
                                              radius: 37,
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                  '${resturantList[index].imageUrl.toString()}'),
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '${resturantList[index].name}',
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '${resturantList[index].email}',
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '${resturantList[index].phoneNumber}',
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '${resturantList[index].password}',
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          super.widget));
                                              FirebaseDatabase.instance
                                                  .reference()
                                                  .child('resturant')
                                                  .child(
                                                      '${resturantList[index].id}')
                                                  .remove();
                                            },
                                            child: Icon(Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 122, 122, 122)),
                                          )
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (int index) =>
                                new StaggeredTile.count(
                                    3, index.isEven ? 3 : 3),
                            mainAxisSpacing: 45.0.h,
                            crossAxisSpacing: 5.0.w,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
