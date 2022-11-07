import '../components/drinkselect_widget.dart';
import '../components/slider_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../settings/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watetlo/history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watetlo/premiumpage.dart';

class MoreoptionsWidget extends StatefulWidget {
  const MoreoptionsWidget({Key? key}) : super(key: key);

  @override
  _MoreoptionsWidgetState createState() => _MoreoptionsWidgetState();
}

class _MoreoptionsWidgetState extends State<MoreoptionsWidget> {
  double _currentSliderValue = FFAppState().cup.toDouble();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFF003366),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(0, -0.65),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: FaIcon(
                  FontAwesomeIcons.rulerVertical,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  await showModalBottomSheet(
                    backgroundColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                    context: context,
                    builder: (context) {
                      return Container(
                        height:
                            MediaQuery.of(context).copyWith().size.height * 0.2,
                        child: Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: StatefulBuilder(
                            builder: (BuildContext context, setState) {
                              var sliderval = _currentSliderValue.toInt();
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('$sliderval ml',
                                      style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor)),
                                  Slider(
                                    value: _currentSliderValue,
                                    max: 1500,
                                    divisions: 150,
                                    label:
                                        _currentSliderValue.round().toString(),
                                    onChanged: (double value) {
                                      state() {}
                                      setState(() {
                                        _currentSliderValue = value;
                                      });
                                    },
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        FFAppState().cup =
                                            _currentSliderValue.toInt();
                                        Navigator.pop(context);
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        padding: const EdgeInsets.all(8.0),
                                        textStyle:
                                            const TextStyle(fontSize: 14),
                                      ),
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                            color: Colors.black),
                                      ))
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ).then((value) => setState(() {}));
                },
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(0, -0.65),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: FaIcon(
                  FontAwesomeIcons.coffee,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  int? premium1 = prefs.getInt('premium');
                  if (premium1 == 1) {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: DrinkselectWidget(),
                          ),
                        );
                      },
                    ).then((value) => setState(() {}));
                  } else {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('This is a premium feature'),
                              content: const Text('Buy Premium To Unlock This Feature'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>  Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 300),
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
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(0, -0.65),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: FaIcon(
                  FontAwesomeIcons.history,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(title: 'History')),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(0, -0.65),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsWidget(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
