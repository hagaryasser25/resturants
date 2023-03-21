import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturants/screens/user/user_cart.dart';
import 'package:resturants/screens/user/user_list.dart';
import 'package:resturants/screens/user/user_meals.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../auth/login.dart';
import '../models/resturant_model.dart';
import '../models/users_model.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/userHome';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Resturant> resturantList = [];
  List<Resturant> searchList = [];
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
      searchList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
      setState(() {});
    });
  }

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

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            key: _scaffoldKey,
            drawer: Container(
                width: 270.w,
                child: Drawer(
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        height: 200.h,
                        child: DrawerHeader(
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
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/logo.jfif'),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return UserList(
                                      name: '${currentUser.fullName}',
                                    );
                                  }));
                                },
                                title: Text('مشترياتى'),
                                leading: Icon(Icons.shopping_bag),
                              ))),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, UserCart.routeName);
                                },
                                title: Text('سلة المشتريات'),
                                leading: Icon(Icons.shopping_cart),
                              ))),
                      Divider(
                        thickness: 0.8,
                        color: Colors.grey,
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              child: ListTile(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('تأكيد'),
                                          content: Text(
                                              'هل انت متأكد من تسجيل الخروج'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                                Navigator.pushNamed(context,
                                                    LoginPage.routeName);
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
                                title: Text('تسجيل الخروج'),
                                leading: Icon(Icons.exit_to_app_rounded),
                              )))
                    ],
                  ),
                )),
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
                          width: 10.w,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xfff8a55f), //<-- SEE HERE
                          child: IconButton(
                            icon: Center(
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              _scaffoldKey.currentState!.openDrawer();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 110.w,
                        ),
                        Text(
                          "المطاعم",
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
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 10.h,
                    left: 10.h,
                  ),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "بحث عن مطعم",
                    ),
                    onChanged: (char) {
                      setState(() {
                        if (char.isEmpty) {
                          setState(() {
                            resturantList = searchList;
                          });
                        } else {
                          resturantList = [];
                          for (Resturant model in searchList) {
                            if (model.name!.contains(char)) {
                              resturantList.add(model);
                            }
                          }
                          setState(() {});
                        }
                      });
                    },
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
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return UserMeals(
                                        resturantName:
                                            '${resturantList[index].name}',
                                      );
                                    }));
                                  },
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
                                          RatingBar.builder(
                                            initialRating: resturantList[index]
                                                .rating!
                                                .toDouble(),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 18,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 2.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate:
                                                (double rating2) async {
                                              rating2.toDouble();
                                              User? user = FirebaseAuth
                                                  .instance.currentUser;

                                              if (user != null) {
                                                String uid = user.uid;
                                                int date = DateTime.now()
                                                    .millisecondsSinceEpoch;

                                                DatabaseReference companyRef =
                                                    FirebaseDatabase.instance
                                                        .reference()
                                                        .child('resturant')
                                                        .child(
                                                            resturantList[index]
                                                                .id
                                                                .toString());

                                                await companyRef.update({
                                                  'rating': rating2.toInt(),
                                                });
                                              }
                                            },
                                          ),
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
                            mainAxisSpacing: 30.0.h,
                            crossAxisSpacing: 5.0,
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
