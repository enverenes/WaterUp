import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watetlo/main_fixed/main_fixed_widget.dart';
import 'dart:convert';
import 'calendar.dart';
import 'dayhistory.dart' as hist;
import 'package:intl/intl.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:watetlo/premiumpage.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final animationsMap = {
    'buttonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 250.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 250.ms,
          duration: 600.ms,
          begin: Offset(0, 64),
          end: Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 250.ms,
          duration: 600.ms,
        ),
      ],
    ),
  };

  List<Widget> waterList = [];

  List saveWater = [];
  List water_int_list = [];

  removeLastBeverage() async {
    String today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
                .toString() +
            'Z';
    final prefs = await SharedPreferences.getInstance();

    var drinklist = await prefs.getString(today);

    List drinklistAdd = [];
    (drinklist == null) ? null : drinklistAdd = jsonDecode(drinklist);
    List lastItem = [];
    if (drinklistAdd.length > 0) {
      lastItem = drinklistAdd.removeLast();
    }

    await prefs.setString(today, jsonEncode(drinklistAdd));
    return lastItem;
  }

  addWaterToHist(int wateramount, String drinktype) {
    saveWater = [
      wateramount,
      drinktype,
      DateFormat.Hm().format(DateTime.now())
    ];

    SaveHistoryToDate(
        //save to local
        saveWater,
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
                .toString() +
            'Z');

    addToWaterList(
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/images/bardak_light.png',
            width: 50,
          ),
          Text('${saveWater[0]}ml'),
          Text(DateFormat.Hm().format(DateTime.now()).toString())
        ],
      ),
    );
  }

  double? _percentagetoday;
  String? _percentagetodayashund;
  void getPercentage(String day) async {
    final prefs = await SharedPreferences.getInstance();
    String today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .toString();

    if (day == today) {
      _percentagetoday =
          (FFAppState().dranksofar / FFAppState().initialtotalwater);
      if (_percentagetoday! > 1.0) {
        _percentagetoday = 1.0;
      }
    } else {
      _percentagetoday = prefs.getDouble(day + 'percentage');
    }

    _percentagetodayashund = ((_percentagetoday ?? 0) * 100).toStringAsFixed(1);
  }

  void SetSpecificDay(String day) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('specday', day);
  }

  void SetSpecificDayToday() async {
    final prefs = await SharedPreferences.getInstance();
    String today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
                .toString() +
            'Z';
    await prefs.setString('specday', today);
  }

  Future SaveHistoryToDate(List waterToadd, String Date) async {
    // W FOR WATER C FOR COFFEEE ..ETC
    final prefs = await SharedPreferences.getInstance();
    String today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
                .toString() +
            'Z';
    var specday = await prefs.getString('specday');
    var drinklist = await prefs.getString(today);

    List drinklistAdd = [];
    (drinklist == null) ? null : drinklistAdd = jsonDecode(drinklist);
    drinklistAdd.add(waterToadd);
    prefs.setString(today, jsonEncode(drinklistAdd));
  }

  void FetchDayToList(String day) async {
    final prefs = await SharedPreferences.getInstance();
    var specday = await prefs.getString('specday');
    var drinklist = await prefs.getString(day);

    (drinklist == null) ? null : addDrink(jsonDecode(drinklist));
  }

  void addDrink(List w) {
    setState(() {
      List.generate(w.length, (index) {
        if (w[index][1] == 'W') {
          addToWaterList(
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/bardak_light.png',
                  width: 50,
                ),
                Text(w[index][0].toString() + ' ml'),
                Text(w[index][2].toString())
              ],
            ),
          );
        } else if (w[index][1] == 'C') {
          //coffee
          addToWaterList(
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/coffeelogo_flutter.png',
                  width: 50,
                ),
                Text(w[index][0].toString() + ' ml'),
                Text(w[index][2].toString())
              ],
            ),
          );
        } else if (w[index][1] == 'J') {
          //juice
          addToWaterList(
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/oj_flutter.png',
                  width: 50,
                ),
                Text(w[index][0].toString() + ' ml'),
                Text(w[index][2].toString())
              ],
            ),
          );
        } else if (w[index][1] == 'M') {
          //milk
          addToWaterList(
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/glassmilk.png',
                  width: 50,
                ),
                Text(w[index][0].toString() + ' ml'),
                Text(w[index][2].toString())
              ],
            ),
          );
        }
      });
    });
  }

  String today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
              .toString() +
          'Z';

  DateTime tody = DateTime.now();

  void addDay() {
    tody = tody.add(Duration(days: 1));
  }

  void decDay() {
    tody = tody.subtract(Duration(days: 1));
    print(tody);
  }

  void setTody(DateTime sendTody) {
    tody = sendTody;

    tody = DateTime(tody.year, tody.month, tody.day, 0, 0, 0, 0, 0);
    print(tody.toString() + 'Z');
  }

  final BannerAd bannerAdHist = BannerAd(
    adUnitId: 'ca-app-pub-5585667908104814/3093630293',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  void initState() {
    // TODO: implement initState

    setTody(selectedDay1 ?? DateTime.now());
    SetSpecificDay(tody.toString() + 'Z');
    FetchDayToList(tody.toString() + 'Z');
    water_int_list = [];
    getPercentage(tody.toString());

    bannerAdHist.load();
    super.initState();
    adActionsGet();
  }

  bool adsonline = true;
  adActionsGet() async {
    final prefs = await SharedPreferences.getInstance();

    int? premiumi = prefs.getInt('premium');

    if (premiumi == 1) {
      setState(() {
        adsonline = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        title: Text(
          "Today's Recap",
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
            setState(() {
              tody = DateTime.now();
              selectedDay1 = DateTime.now();
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainFixedWidget(),
              ),
            );
          },
        ),
        actions: [],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 25,
          ),
          Align(
              child: Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  width: 300,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFF003366), shape: BoxShape.circle),
                        child: IconButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              int? premium1 = prefs.getInt('premium');
                              if (premium1 == 1 ) {
                                setState(() {
                                  waterList.clear();
                                  decDay();
                                });

                                SetSpecificDay(
                                    DateTime(tody.year, tody.month, tody.day)
                                            .toString() +
                                        'Z');

                                FetchDayToList(
                                    DateTime(tody.year, tody.month, tody.day)
                                            .toString() +
                                        'Z');
                                getPercentage(
                                    DateTime(tody.year, tody.month, tody.day)
                                        .toString());
                              } else {
                               showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                            title: Row(
                                                              children: [
                                                                const Text(
                                                                    'Previous Days '),
                                                               
                                                              ],
                                                            ),
                                                            content: const Text(
                                                                'Buy Premium to unlock this feature'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () =>
                                                                    showModalBottomSheet(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return premium();
                                                                        }),
                                                                child: Center(
                                                                  child: const Text(
                                                                      'Buy Premium Now',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                              }
                            },
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                            )),
                      ),
                      ButtonTheme(
                        child: MaterialButton(
                          height: 40.0,
                          minWidth: 170.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide()),
                          color: Color(0xFF003366),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            int? premium1 = prefs.getInt('premium');
                            if (premium1 == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Calendar()),
                              );
                            } else {
                               showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                            title: Row(
                                                              children: [
                                                                const Text(
                                                                    'Calendar '),
                                                               
                                                              ],
                                                            ),
                                                            content: const Text(
                                                                'Buy Premium to unlock this feature'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () =>
                                                                    showModalBottomSheet(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return premium();
                                                                        }),
                                                                child: Center(
                                                                  child: const Text(
                                                                      'Buy Premium Now',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                            }
                          },
                          child: Text(
                            DateFormat.MMMEd().format(tody).toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFF003366), shape: BoxShape.circle),
                        child: IconButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              int? premium1 = prefs.getInt('premium');

                              if (premium1 == 1) {
                                setState(() {
                                  waterList.clear();
                                  addDay();
                                });

                                SetSpecificDay(
                                    DateTime(tody.year, tody.month, tody.day)
                                            .toString() +
                                        'Z');
                                FetchDayToList(
                                    DateTime(tody.year, tody.month, tody.day)
                                            .toString() +
                                        'Z');
                                getPercentage(
                                    DateTime(tody.year, tody.month, tody.day)
                                        .toString());
                              } else {
                                showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                            title: Row(
                                                              children: [
                                                                const Text(
                                                                    'This is a premium feature '),
                                                               
                                                              ],
                                                            ),
                                                            content: const Text(
                                                                'Buy Premium to unlock this feature'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () =>
                                                                    showModalBottomSheet(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return premium();
                                                                        }),
                                                                child: Center(
                                                                  child: const Text(
                                                                      'Buy Premium Now',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                              }
                            },
                            icon: Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ))),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularPercentIndicator(
                    center: Text(
                      (_percentagetodayashund ?? '0') + ' %',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Outfit',
                            color: FlutterFlowTheme.of(context).primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    animation: true,
                    animationDuration: 1000,
                    radius: 80,
                    lineWidth: 20,
                    percent: _percentagetoday ?? 0.0,
                    progressColor: Color(0xFF003366),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ]),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Divider(
              color: Color.fromARGB(73, 102, 100, 100),
              thickness: 1,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: AddRow(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          width: bannerAdHist.size.width.toDouble(),
          height: bannerAdHist.size.height.toDouble(),
          alignment: AlignmentDirectional.bottomCenter,
          child: bottomAd(),
        ),
        elevation: 0,
      ),
    );
  }

  Widget bottomAd() {
    if (adsonline) {
      return AdWidget(ad: bannerAdHist);
    } else {
      return Container(
        height: 10,
      );
    }
  }

  void addToWaterList(Widget widget) {
    waterList.add(widget);
  }

  List<Widget> AddRow() {
    int coltoCreate = waterList.length;
    int something = 0;
    return List.generate(
      coltoCreate,
      (index1) => Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            if (waterList.length > something) {
              something++;
              return waterList[something - 1];
            } else {
              return SizedBox(
                width: 50,
              );
            }
          }),
        ),
      ),
    );
  }
}
