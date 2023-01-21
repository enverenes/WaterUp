import 'dart:async';

import 'package:watetlo/main.dart';
import '../components/slider_widget.dart';
import '../components/drinkselect_copy_widget.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import '../main_fixed/main_fixed_widget.dart' as main;
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../main_fixed/main_fixed_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrinkselectWidget extends StatefulWidget {
  const DrinkselectWidget({Key? key}) : super(key: key);

  @override
  _DrinkselectWidgetState createState() => _DrinkselectWidgetState();
}

class _DrinkselectWidgetState extends State<DrinkselectWidget>
    with TickerProviderStateMixin {
  String? choiceChipsValue;
  var hasColumnTriggered1 = false;
  var hasColumnTriggered2 = false;
  var hasColumnTriggered3 = false;
  var hasColumnTriggered4 = false;

  @override
  void initState() {
    super.initState();
  }

  double _currentSliderValue = FFAppState().cup.toDouble();

  double tweenvar = 5.0;
  double tweenvar1 = 5.0;
  double tweenvar2 = 5.0;
  double tweenvar3 = 5.0;

  int send_coffeval = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: AlignmentDirectional(0, 0.1),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TweenAnimationBuilder(
                    duration: Duration(milliseconds: 100),
                    tween: Tween<double>(begin: 5, end: tweenvar),
                    onEnd: () async {
                      setState(() {
                        tweenvar = 5.0;
                      });
                    },
                    builder: (context, double value, child) => InkWell(
                      onTap: () {
                        tweenvar = 10;
                        setState(() => FFAppState().drinktype = 1.0);
                        setState(() => FFAppState().drinkname = 'Water');
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 300),
                            reverseDuration: Duration(milliseconds: 300),
                            child: main.MainFixedWidget(),
                          ),
                        );
                      },
                      child: IgnorePointer(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset(
                              'assets/images/bardak_light.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              AppLocalizations.of(context)!.drink_select_water,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TweenAnimationBuilder(
                        duration: Duration(milliseconds: 100),
                        tween: Tween<double>(begin: 5, end: tweenvar3),
                        onEnd: () async {
                          setState(() {
                            tweenvar3 = 5.0;
                          });
                        },
                        builder: (context, double value, child) => InkWell(
                          onTap: () async {
                            tweenvar3 = 10.0;
                            setState(() => FFAppState().drinkname = 'Coffee');

                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0.05),
                                              child: Container(
                                                width: double.infinity,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            FlutterFlowChoiceChips(
                                                          initiallySelected: [
                                                            'Nothing'
                                                          ],
                                                          options: [
                                                            ChipData('Tall'),
                                                            ChipData('Grande'),
                                                            ChipData('Venti'),
                                                            ChipData('Custom')
                                                          ],
                                                          onChanged:
                                                              (val) async {
                                                            setState(() =>
                                                                choiceChipsValue =
                                                                    val?.first);
                                                            if (choiceChipsValue ==
                                                                'Tall') {
                                                              send_coffeval =
                                                                  354;
                                                            }
                                                            if (choiceChipsValue ==
                                                                'Grande') {
                                                              send_coffeval =
                                                                  473;
                                                            }
                                                            if (choiceChipsValue ==
                                                                'Venti') {
                                                              send_coffeval =
                                                                  591;
                                                            }
                                                            if (choiceChipsValue ==
                                                                'Custom') {
                                                              setState(() =>
                                                                  FFAppState()
                                                                          .drinktype =
                                                                      0.94);
                                                              setState(() =>
                                                                  FFAppState()
                                                                          .drinkname =
                                                                      'Coffee');
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Padding(
                                                                    padding: MediaQuery.of(
                                                                            context)
                                                                        .viewInsets,
                                                                    child:
                                                                        Container(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      height: MediaQuery.of(context)
                                                                              .copyWith()
                                                                              .size
                                                                              .height *
                                                                          0.2,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.of(context).viewInsets,
                                                                        child:
                                                                            StatefulBuilder(
                                                                          builder:
                                                                              (BuildContext context, setState) {
                                                                            var sliderval =
                                                                                _currentSliderValue.toInt();
                                                                            return Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  AppLocalizations.of(context)!.drink_select_coffee + ' Size: ' + '$sliderval' + ' ml',
                                                                                  style: TextStyle(color: FlutterFlowTheme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                Slider(
                                                                                  activeColor: Color(0xFF003366),
                                                                                  value: _currentSliderValue,
                                                                                  max: 1500,
                                                                                  divisions: 150,
                                                                                  label: _currentSliderValue.round().toString(),
                                                                                  onChanged: (double value) {
                                                                                    state() {}
                                                                                    setState(() {
                                                                                      _currentSliderValue = value;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                TextButton(
                                                                                    onPressed: () async {
                                                                                      send_coffeval = _currentSliderValue.toInt();
                                                                                      await main.MainFixedWidgetState().drinkWaterFetch(send_coffeval, context, true, 'C');
                                                                                      setState(() {
                                                                                        FFAppState().drinktype = 1.0;
                                                                                        FFAppState().drinkname = 'Water';
                                                                                      });

                                                                                      Navigator.push(
                                                                                        context,
                                                                                        PageTransition(
                                                                                          type: PageTransitionType.fade,
                                                                                          duration: Duration(milliseconds: 300),
                                                                                          reverseDuration: Duration(milliseconds: 300),
                                                                                          child: MainFixedWidget(),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    style: TextButton.styleFrom(
                                                                                      backgroundColor: Color(0xFF003366),
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      textStyle: const TextStyle(fontSize: 14),
                                                                                    ),
                                                                                    child: Text(
                                                                                      AppLocalizations.of(context)!.drink_button,
                                                                                      style: TextStyle(
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                    ))
                                                                              ],
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            }
                                                          },
                                                          selectedChipStyle:
                                                              ChipStyle(
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Outfit',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                            iconColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            iconSize: 18,
                                                            elevation: 4,
                                                          ),
                                                          unselectedChipStyle:
                                                              ChipStyle(
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Outfit',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryColor,
                                                                    ),
                                                            iconColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryColor,
                                                            iconSize: 18,
                                                            elevation: 5,
                                                          ),
                                                          chipSpacing: 25,
                                                          multiselect: false,
                                                          initialized:
                                                              choiceChipsValue !=
                                                                  null,
                                                          alignment:
                                                              WrapAlignment
                                                                  .center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  await main
                                                          .MainFixedWidgetState()
                                                      .drinkWaterFetch(
                                                          send_coffeval,
                                                          context,
                                                          true,
                                                          'C');

                                                  setState(() {
                                                    FFAppState().drinktype =
                                                        1.0;
                                                    FFAppState().drinkname =
                                                        'Water';
                                                  });
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      reverseDuration: Duration(
                                                          milliseconds: 300),
                                                      child: MainFixedWidget(),
                                                    ),
                                                  );
                                                },
                                                text: 'OK',
                                                options: FFButtonOptions(
                                                  width: 70,
                                                  height: 30,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .subtitle2
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                      ),
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: IgnorePointer(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image.asset(
                                  'assets/images/coffeelogo_flutter.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .drink_select_coffee,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                          fontFamily: 'Outfit',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TweenAnimationBuilder(
                        duration: Duration(milliseconds: 100),
                        tween: Tween<double>(begin: 5, end: tweenvar1),
                        onEnd: () async {
                          setState(() {
                            tweenvar1 = 5.0;
                          });
                        },
                        builder: (context, double value, child) => InkWell(
                          onTap: () async {
                            tweenvar1 = 10;
                            setState(() => FFAppState().drinktype = 0.97);
                            setState(() => FFAppState().drinkname = 'Juice');

                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Container(
                                      height: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height *
                                          0.2,
                                      child: Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: StatefulBuilder(
                                          builder:
                                              (BuildContext context, setState) {
                                            var sliderval =
                                                _currentSliderValue.toInt();
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                          .cup_size +
                                                      ' ' +
                                                      '$sliderval' +
                                                      ' ml',
                                                  style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Slider(
                                                  activeColor:
                                                      Color(0xFF003366),
                                                  value: _currentSliderValue,
                                                  max: 1500,
                                                  divisions: 150,
                                                  label: _currentSliderValue
                                                      .round()
                                                      .toString(),
                                                  onChanged: (double value) {
                                                    state() {}
                                                    setState(() {
                                                      _currentSliderValue =
                                                          value;
                                                    });
                                                  },
                                                ),
                                                TextButton(
                                                    onPressed: () async {
                                                      await main
                                                              .MainFixedWidgetState()
                                                          .drinkWaterFetch(
                                                              _currentSliderValue
                                                                  .toInt(),
                                                              context,
                                                              true,
                                                              'J');

                                                      setState(() {
                                                        FFAppState().drinktype =
                                                            1.0;
                                                        FFAppState().drinkname =
                                                            'Water';
                                                      });

                                                      Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          reverseDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      300),
                                                          child: main
                                                              .MainFixedWidget(),
                                                        ),
                                                      );
                                                    },
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Color(0xFF003366),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 14),
                                                    ),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .drink_button,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ))
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: IgnorePointer(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image.asset(
                                  'assets/images/oj_flutter.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .drink_select_juice,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                          fontFamily: 'Outfit',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TweenAnimationBuilder(
                        duration: Duration(milliseconds: 100),
                        tween: Tween<double>(begin: 5, end: tweenvar2),
                        onEnd: () async {
                          setState(() {
                            tweenvar2 = 5.0;
                          });
                        },
                        builder: (context, double value, child) => InkWell(
                          onTap: () async {
                            tweenvar2 = 10;
                            setState(() => FFAppState().drinktype = 0.87);
                            setState(() => FFAppState().drinkname = 'Milk');

                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Container(
                                      height: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height *
                                          0.2,
                                      child: Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: StatefulBuilder(
                                          builder:
                                              (BuildContext context, setState) {
                                            var sliderval =
                                                _currentSliderValue.toInt();
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                          .cup_size +
                                                      ' ' +
                                                      '$sliderval' +
                                                      ' ml',
                                                  style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Slider(
                                                  activeColor:
                                                      Color(0xFF003366),
                                                  value: _currentSliderValue,
                                                  max: 1500,
                                                  divisions: 150,
                                                  label: _currentSliderValue
                                                      .round()
                                                      .toString(),
                                                  onChanged: (double value) {
                                                    state() {}
                                                    setState(() {
                                                      _currentSliderValue =
                                                          value;
                                                    });
                                                  },
                                                ),
                                                TextButton(
                                                    onPressed: () async {
                                                      await main
                                                              .MainFixedWidgetState()
                                                          .drinkWaterFetch(
                                                              _currentSliderValue
                                                                  .toInt(),
                                                              context,
                                                              true,
                                                              'M');

                                                      setState(() =>
                                                          FFAppState()
                                                              .drinktype = 1.0);
                                                      setState(() =>
                                                          FFAppState()
                                                                  .drinkname =
                                                              'Water');
                                                      Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          reverseDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      300),
                                                          child: main
                                                              .MainFixedWidget(),
                                                        ),
                                                      );
                                                    },
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Color(0xFF003366),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 14),
                                                    ),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .drink_button,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ))
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: IgnorePointer(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image.asset(
                                  'assets/images/glassmilk.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .drink_select_milk,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                          fontFamily: 'Outfit',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
