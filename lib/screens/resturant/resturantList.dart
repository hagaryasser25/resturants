import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/bookings_model.dart';

class ResturantList extends StatefulWidget {
  String name;
  static const routeName = '/resturantList';
  ResturantList({required this.name});

  @override
  State<ResturantList> createState() => _ResturantListState();
}

class _ResturantListState extends State<ResturantList> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Booking> bookingList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchBookings();
  }

  @override
  void fetchBookings() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("bookings");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Booking p = Booking.fromJson(event.snapshot.value);
      bookingList.add(p);
      keyslist.add(event.snapshot.key.toString());
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
            body: Column(children: [
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
                          "قائمة الحجوزات",
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
                  itemCount: bookingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.name == bookingList[index].resturantName) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 15, left: 15, bottom: 10),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'اسم المنتج:  ${bookingList[index].name.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'سعر المنتج : ${bookingList[index].price.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'الكمية المطلوبة : ${bookingList[index].amount.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'اجمالى السعر : ${bookingList[index].total.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'اسم العميل : ${bookingList[index].userName.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'رقم الهاتف : ${bookingList[index].userPhone.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'العنوان : ${bookingList[index].userAddress.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                       
                                        InkWell(
                                          onTap: () async {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        super.widget));
                                            base
                                                .child(bookingList[index]
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
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Text('');
                    }
                  },
                ),
              ),
             
            ]),
          ),
        ));
  }
}