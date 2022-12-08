import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:pay/pay.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class premium extends StatefulWidget {
  premium({Key? key}) : super(key: key);

  @override
  State<premium> createState() => _premiumState();
}

class _premiumState extends State<premium> {
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
                  color: Color(0xFF003366), shape: BoxShape.circle),
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
                style: TextStyle(fontSize: 20),
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
                  color: Color(0xFF003366), shape: BoxShape.circle),
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
                style: TextStyle(fontSize: 20),
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
                    color: Color(0xFF003366), shape: BoxShape.circle),
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
              child: Text('Acces to History', style: TextStyle(fontSize: 20)))
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
                  color: Color(0xFF003366), shape: BoxShape.circle),
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
                  style: TextStyle(fontSize: 20)))
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
      amount: '9.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        title: Text(
          'Premium Package',
          style: FlutterFlowTheme.of(context).title1.override(
                fontFamily: 'Outfit',
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
        ),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryColor,
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider.builder(
              itemCount: slidingColumns.length,
              itemBuilder: ((context, index, realIndex) {
                final slidingColumn = slidingColumns[index];
                return buildColumn(slidingColumn, index);
              }),
              options: CarouselOptions(
                height: 300,
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              )),
          SizedBox(
            height: 30,
          ),
          buildIndicator(),
          SizedBox(
            height: 30,
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
                if (Platform.isAndroid) {
                  dialogBuilder(context);
                }
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text('Buy Premium One Year Package',
                        style: TextStyle(fontSize: 20)),
                    Text('Only 9.99 USD'),
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
      color: FlutterFlowTheme.of(context).primaryBackground,
      child: column,
    );
  }

  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment'),
          content: GooglePayButton(
            paymentConfigurationAsset: 'payment/gpay.json',
            paymentItems: _paymentItems,
            type: GooglePayButtonType.pay,
            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: onGooglePayResult,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Go Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> dialogBuilderIOS(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Premium Package Payment'),
          content: Container(
            child: ApplePayButton(
              paymentConfigurationAsset: 'payment/apple_pay.json',
              paymentItems: _paymentItems,
              style: ApplePayButtonStyle.black,
              type: ApplePayButtonType.buy,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: onApplePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Go Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
