import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:pay/pay.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Color(0xFF57636C), shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  Icons.ad_units,
                  color: Colors.white,
                  size: 70,
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: 30),
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
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Color(0xFF57636C), shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  Icons.notifications_active,
                  color: Colors.white,
                  size: 70,
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: 30),
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
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    color: Color(0xFF57636C), shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.history,
                    color: Colors.white,
                    size: 70,
                  ),
                )),
          ),
          Container(
              margin: EdgeInsets.only(top: 30),
              child: Text('Acces to History',
                  style: TextStyle(fontSize: 20, color: Colors.black)))
        ],
      ),
    ),
    Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Color(0xFF57636C), shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  Icons.coffee,
                  color: Colors.white,
                  size: 70,
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: 30),
              child: Text('Select Different Drinks',
                  style: TextStyle(fontSize: 20, color: Colors.black)))
        ],
      ),
    )
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
      height: 700,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          CarouselSlider.builder(
              itemCount: slidingColumns.length,
              itemBuilder: ((context, index, realIndex) {
                final slidingColumn = slidingColumns[index];
                return buildColumn(slidingColumn, index);
              }),
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              )),
          SizedBox(
            height: 10,
          ),
          buildIndicator(),
          SizedBox(
            height: 60,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Color(0xFF003366)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xFF003366))))),
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
              ))
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
      margin: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white,
      child: column,
    );
  }
}
