import 'dart:ffi';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class premium extends StatefulWidget {
  premium({Key? key}) : super(key: key);

  @override
  State<premium> createState() => premiumState();
}

class premiumState extends State<premium> {
  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);

    PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration =
          PurchasesConfiguration("goog_lerxVMViMarxCepdPPuKGxuLRmH");
    } else if (Platform.isIOS) {
      configuration =
          await PurchasesConfiguration("appl_GSXZCxTbaIRrStwvuRoXjhIFRlj");
      print('IOS DEVICE');
    } else {
      configuration =
          PurchasesConfiguration("appl_GSXZCxTbaIRrStwvuRoXjhIFRlj");
    }
    await Purchases.configure(configuration);
    print(configuration.store);
  }

  List<StoreProduct>? storeProduct;
  fetchPrice() async {
    storeProduct = await Purchases.getProducts(['premium_1200_1y']);
    print(storeProduct?.first.price);
  }

  @override
  void initState() {
    initPlatformState();
    fetchPrice();
    super.initState();
  }

  int activeIndex = 0;

  void makePurchase() async {
    try {
      await Purchases.purchaseProduct('premium_1200_1y');
    } catch (e) {
      print(e);
    }
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    if (!customerInfo.activeSubscriptions.isEmpty) {
      unlockPremium();
    }
  }

  unlockPremium() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('premium', 1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                padding:
                    EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  AppLocalizations.of(context)!.premium_i1,
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
                padding:
                    EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: AutoSizeText(
                  AppLocalizations.of(context)!.premium_i2,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  overflow: TextOverflow.visible,
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
                  child: Center(
                      child: Image.asset('assets/images/3_premium.png'))),
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
              child: Text(AppLocalizations.of(context)!.premium_i3,
                  style: TextStyle(
                      fontFamily: 'Outfit', fontSize: 20, color: Colors.black)),
            )
          ],
        ),
      ),
    ];

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
          Center(child: buildIndicator(slidingColumns)),
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
                      Text(
                          AppLocalizations.of(context)!
                              .premium_buy_button_header,
                          style: TextStyle(fontSize: 20)),
                      Text(AppLocalizations.of(context)!
                              .premium_buy_button_context +
                          ' ' +
                          (storeProduct?.first == null
                              ? ''
                              : storeProduct!.first.priceString)),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget buildIndicator(slidingColumns) {
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
