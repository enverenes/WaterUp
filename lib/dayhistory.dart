import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';

class SpecificDay extends StatefulWidget {
  SpecificDay({Key? key}) : super(key: key);

  @override
  State<SpecificDay> createState() => _SpecificDayState();
}

class _SpecificDayState extends State<SpecificDay> {
  List<Widget> waterList = [];

  List saveWater = [];
  List water_int_list = [];

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

  void FetchDayToList() async {
    
    final prefs = await SharedPreferences.getInstance();
    var specday =  prefs.getString('specday');
    var drinklist = prefs.getString(specday!);

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
                Text('Date: ' + w[index][2].toString())
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
                Text('Date: ' + w[index][2].toString())
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
                Text('Date: ' + w[index][2].toString())
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
                Text('Date: ' + w[index][2].toString())
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

    FetchDayToList();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
           title: Text(
          DateFormat.MMMEd().format(selectedDay1),
          style: FlutterFlowTheme.of(context).title1.override(
                fontFamily: 'Outfit',
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
        ),
       
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20.0),
          child: ListView(
            shrinkWrap: true,
            children: AddRow(),
          ),
        ));
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
                print('WORKED');

                if (waterList.length > something) {
                  something++;
                  return waterList[something - 1];
                } else {
                  return SizedBox(
                    width: 50,
                  );
                }
              }),
            ));
  }
}
