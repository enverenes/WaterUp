import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class premium extends StatefulWidget {
  premium({Key? key}) : super(key: key);

  @override
  State<premium> createState() => premiumState();
}

class premiumState extends State<premium> {
  final slidingColumns = [
    Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 250,
              height: 250,
              child: Image.asset(
                'assets/images/1_premium.png',
              )),
          Container(
              padding: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                )
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Text(
                'Remove all ads',
                style: TextStyle(
                    fontSize: 20, fontFamily: 'Outfit', color: Colors.black),
              ))
        ],
      ),
    ),
    Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(),
              child: Image.asset(
                'assets/images/2_premium.png',
                fit: BoxFit.contain,
              )),
          Container(
              padding: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                )
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Text(
                'Get daily reminders',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ))
        ],
      ),
    ),
    Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(),
                child:
                    Center(child: Image.asset('assets/images/3_premium.png'))),
          ),
          Container(
            padding: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text('Access to History',
                style: TextStyle(
                    fontFamily: 'Outfit', fontSize: 20, color: Colors.black)),
          )
        ],
      ),
    ),
  ];

  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);

    PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration =
          PurchasesConfiguration("goog_lerxVMViMarxCepdPPuKGxuLRmH");
    } else if (Platform.isIOS) {
      configuration =
          await PurchasesConfiguration("appl_lpfudKmsGMForwQndSQZrMijbcC");
      print('IOS DEVICE');
    } else {
      configuration =
          PurchasesConfiguration("appl_lpfudKmsGMForwQndSQZrMijbcC");
    }
    await Purchases.configure(configuration);
    print(configuration.store);
  }

  @override
  void initState() {
    //initPlatformState();
    super.initState();
  }

  int activeIndex = 0;

  void makePurchase() async {
    Offerings? offerings;

    try {
      offerings = await Purchases.getOfferings();

      if (offerings.current != null) {
        print(offerings.current!.availablePackages.first);
      }

      CustomerInfo customerInfo = await Purchases.purchasePackage(
          offerings.current!.availablePackages.first);
      if (customerInfo.entitlements.all['premium']!.isActive) {
        print('NOW PREMiUM');
        await unlockPremium();
      }
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              content: Text('This package is currently unavailable'),
            );
          }));
    }
  }

  unlockPremium() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('premium', 1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 900,
      child: Column(
        children: [
          CarouselSlider.builder(
              itemCount: slidingColumns.length,
              itemBuilder: ((context, index, realIndex) {
                final slidingColumn = slidingColumns[index];
                return buildColumn(slidingColumn, index);
              }),
              options: CarouselOptions(
                height: 350,
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              )),
          Center(child: buildIndicator()),
          SizedBox(
            height: 10,
          ),
          Container(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Color(0xFF003366)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {
                  makePurchase();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text('Premium One Year Package',
                          style: TextStyle(fontSize: 20)),
                      Text('Only 0.99 USD/mo'),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
        activeIndex: activeIndex, count: slidingColumns.length);
  }

  Widget buildColumn(Widget column, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      color: Colors.white,
      child: column,
    );
  }
}
