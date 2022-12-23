import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:pay/pay.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

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
                  fontSize: 20,
                  fontFamily: 'Outfit',
                  color: Colors.black
                ),
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
                style: TextStyle(fontSize: 20,
                color: Colors.black),
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
              child: Text('Acces to History', style: TextStyle(fontSize: 20,
              color: Colors.black)))
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
                  style: TextStyle(fontSize: 20,
                  color: Colors.black)))
        ],
      ),
    )
  ];

  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }

  final _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '9.99', // revenuecat goog_glFmBwXeSyCIWyfPTrewGJjhVuM
      status: PaymentItemStatus.final_price,
    )
  ];

  

  @override
  void initState() {


    super.initState();
  }

  int activeIndex = 0;

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
              onPressed: () async {
                
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
