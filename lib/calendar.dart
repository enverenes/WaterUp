import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watetlo/dayhistory.dart';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import 'package:watetlo/history.dart';

class Calendar extends StatefulWidget {
  Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}
DateTime? selectedDay1;

var focusedDay1;

class _CalendarState extends State<Calendar> {
  Future ShowHistory(String Date) async {
    final prefs = await SharedPreferences.getInstance();
    var listfrom_repo_w = await prefs.getString(Date);

    if (listfrom_repo_w == null) {
      print('nodata');
      return 'no data';
    } else {
      return jsonDecode(listfrom_repo_w);
    }
  }

  void SetSpecificDay(String day) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('specday', day);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        backgroundColor: Color(0xFF003366),
      ),
      body: Column(
        children: [
          TableCalendar(
            sixWeekMonthsEnforced: true,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay1, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                SetSpecificDay(selectedDay.toString());

                selectedDay1 = selectedDay;
              
                focusedDay1 = focusedDay; // update `_focusedDay` here as well
              });
            },
          ),
          FloatingActionButton(
            backgroundColor: Color(0xFF003366),
            onPressed: () {
             Navigator.of(context)
    .pushNamedAndRemoveUntil('/history', (Route<dynamic> route) => false);
              

            },
            child: Text('Go',
            style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}
