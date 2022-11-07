import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Flutter Demo Home Page');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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

  void addWaterToHist(int wateramount, String drinktype) {
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
            width: 30,
          ),
          Text('${saveWater[0]}ml'),
          Text(DateFormat.Hm().format(DateTime.now()).toString())
        ],
      ),
    ); //ITS WATER RN
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

  @override
  void initState() {
    // TODO: implement initState
    SetSpecificDay(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
                .toString() +
            'Z');
    FetchDayToList(today);
    water_int_list = [];
    super.initState();
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
            Navigator.pop(context);
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
                      IconButton(
                          onPressed: () {
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
                          },
                          icon: Icon(Icons.arrow_back_rounded)),
                      ElevatedButton(
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
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text(
                                          'This is a premium feature'),
                                      content: const Text(
                                          'Buy Premium To Unlock This Feature'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              reverseDuration:
                                                  Duration(milliseconds: 300),
                                              child: premium(),
                                            ),
                                          ),
                                          child: const Text('Buy Premium Now'),
                                        ),
                                      ],
                                    ));
                          }
                        },
                        child: Text(
                          DateFormat.MMMEd().format(tody).toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
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
                          },
                          icon: Icon(Icons.arrow_forward_rounded)),
                    ],
                  ))),
          SizedBox(
            height: 25,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: AddRow(),
          ),
        ],
      ),
    );
  }

  void addToWaterList(Widget widget) {
    waterList.add(widget);
  }

  List<Widget> AddRow() {
    int coltoCreate = waterList.length;
    int something = 0;
    return List.generate(
        coltoCreate,
        (index1) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                if (waterList.length > something) {
                  something++;
                  return waterList[something - 1];
                } else {
                  return SizedBox(
                    width: 40,
                  );
                }
              }),
            ));
  }
}
