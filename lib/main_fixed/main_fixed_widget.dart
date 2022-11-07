import 'dart:async';

import '../components/moreoptions_widget.dart';
import '../components/slider_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../sardi/sardi_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watetlo/history.dart' as hist;
import 'package:rive/rive.dart';
import 'package:watetlo/notifications.dart';
import 'package:cron/cron.dart';
import 'package:home_widget/home_widget.dart';

class MainFixedWidget extends StatefulWidget {
  const MainFixedWidget({Key? key}) : super(key: key);

  @override
  _MainFixedWidgetState createState() => _MainFixedWidgetState();
}

class _MainFixedWidgetState extends State<MainFixedWidget>
    with TickerProviderStateMixin {




 Future<void> backgroundCallback(Uri uri) async {
    if (uri.host == 'updatecounter') {
      print('water drink');
      await HomeWidget.updateWidget(name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
    }
  }











  final hist.MyHomePageState myHomePageState = hist.MyHomePageState();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasContainerTriggered = false;
  final animationsMap = {
    'containerOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        MoveEffect(
          curve: Curves.elasticOut,
          delay: 20.ms,
          duration: 810.ms,
          begin: Offset(0, 0),
          end: Offset(0, 17.0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 20.ms,
          duration: 810.ms,
        ),
      ],
    ),
  };

  final cron = Cron();

  Future<void> showNotification(int hours, bool notificationsOn) async {
    if (notificationsOn) {
      NotificationsState().intialize();

      await NotificationsState().showScheduledNotification(
          id: 0,
          title: "Don't forget to drink your water",
          body: 'Tap to see your progress',
          hours: hours,
          payload: 'payload navigation');
    }
  }

  Widget Adam(){

if (Theme.of(context).brightness == Brightness.light){
 return Image.asset(
                              'assets/images/adamuzun.png',
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.74,
                              fit: BoxFit.fill,
                            );
}else{
  return Image.asset(
                              'assets/images/adamuzun_gece.png',
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.74,
                              fit: BoxFit.fill,
                            );

}

   
  }

  
  
  

  @override
  void initState() {
    super.initState();

 WidgetsFlutterBinding.ensureInitialized();

    showNotification(5, true); //Notification settings

    completed = false;
    initialPos();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() => FFAppState().increaseheight =
          functions.try1(FFAppState().totalwater, FFAppState().cup));
    });

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  double pos = 0.0;
  bool completed = false;
  void initialPos() async {
    final prefs = await SharedPreferences.getInstance();
    int totalwater = prefs.getInt('watertodrink') ?? 0;
    var inc = (FFAppState().dranksofar / totalwater) * 510;

    if ((-inc) < -510) {
      pos = -510;
    } else {
      pos = -(inc);
    }
  }

  void changePos(double cupsize) async {
    final prefs = await SharedPreferences.getInstance();

    int totalwater = prefs.getInt('watertodrink') ?? 0;
    setState(() {
      var inc = (cupsize / totalwater) * 510;

      if (pos - inc >= -510) {
        pos -= inc;
      } else if (pos - inc < -510) {
        pos = -510;
      }
    });
  }

  void changePosUndo(double cupsize) async {
    final prefs = await SharedPreferences.getInstance();

    int totalwater = prefs.getInt('watertodrink') ?? 0;
    setState(() {
      var inc = (cupsize / totalwater) * 510;

      if (pos < 0) {
        pos += inc;
      } else {
        pos = 0;
      }
    });
  }

  double _currentSliderValue = FFAppState().cup.toDouble();

  String currentdrinktype = FFAppState().drinkname[0];

  double tweenvar = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.antiAlias,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, -0.25),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: Text(
                          'Today\'s total',
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Outfit',
                                color: FlutterFlowTheme.of(context).primaryColor,
                                fontSize: 30,
                              ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, -0.8),
                      child: Text(
                        FFAppState().dranksofar.toString(),
                        style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context).primaryColor,
                              fontSize: 25,
                            ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0, 1),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.74,
                      decoration: BoxDecoration(),
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.antiAlias,
                        children: [
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: pos, end: pos - 40),
                            duration: const Duration(milliseconds: 1500),
                            builder: (context, double value, child) {
                              return Positioned(
                                top: value,
                                right: 0.0,
                                left: 0.0,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 510,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      height: 550,
                                      child: RiveAnimation.asset(
                                          'assets/rive_animations/wave.riv'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Adam()
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0.15),
                            child: Text(
                              FFAppState().totalwater.toString() + ' ml left',
                              style:
                                  FlutterFlowTheme.of(context).title1.override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        fontSize: 20,
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 1),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 93,
                    decoration: BoxDecoration(
                      color: Color(0xFF003366),
                    ),
                    child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              TweenAnimationBuilder(
                                duration: Duration(milliseconds: 100),
                                tween: Tween<double>(begin: 30, end: tweenvar),
                                onEnd: () {
                                  setState(() {
                                    tweenvar = 30.0;
                                  });
                                },
                                builder: (context, double value, child) =>
                                    Positioned(
                                        //GLASS HERE
                                        bottom: value,
                                        right: 0,
                                        left: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                tweenvar = 40.0;
                                                myHomePageState.addWaterToHist(
                                                    FFAppState().cup,
                                                    currentdrinktype);

                                                changePos(FFAppState()
                                                    .cup
                                                    .toDouble());

                                                setState(() => FFAppState()
                                                        .totalwater =
                                                    functions.waterleft(
                                                        FFAppState().cup,
                                                        FFAppState().totalwater,
                                                        FFAppState()
                                                            .drinktype));
                                                setState(() => FFAppState()
                                                    .progressbarinc = FFAppState()
                                                        .progressbarinc +
                                                    functions.progressinc(
                                                        FFAppState()
                                                            .progressbar,
                                                        FFAppState()
                                                            .progressbarinc));
                                                setState(() => FFAppState()
                                                    .dranksofar = FFAppState()
                                                        .dranksofar +
                                                    functions.drinktypecupsize(
                                                        FFAppState().cup,
                                                        FFAppState()
                                                            .drinktype));
                                                HapticFeedback.lightImpact();
                                                if (functions.everydayreset(
                                                        FFAppState().time) ==
                                                    1) {
                                                  if (FFAppState().totalwater <=
                                                      0) {
                                                    setState(() {
                                                      pos = -510;
                                                    });
                                                    completed = true;
                                                    await Navigator.push(
                                                      context,
                                                      PageTransition(
                                                        type: PageTransitionType
                                                            .fade,
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        reverseDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    300),
                                                        child: SardiWidget(),
                                                      ),
                                                    );
                                                    setState(() => FFAppState()
                                                            .time =
                                                        getCurrentTimestamp);
                                                    setState(() => FFAppState()
                                                        .totalwater = 0);
                                                  } else {
                                                    return;
                                                  }
                                                } else {
                                                  return;
                                                }
                                              },
                                              child: Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(),
                                                child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0.9),
                                                      child: Image.asset(
                                                        'assets/images/button_bardak.png',
                                                        width: 80,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0.2),
                                                      child: Text(
                                                        FFAppState().drinkname,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'Outfit',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                              ),
                              Positioned(
                                bottom: 10,
                                child: InkWell(
                                  //SLIDER OPENS
                                  onLongPress: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .copyWith()
                                                  .size
                                                  .height *
                                              0.2,
                                          child: Padding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: StatefulBuilder(
                                              builder: (BuildContext context,
                                                  setState) {
                                                var sliderval =
                                                    _currentSliderValue.toInt();
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '$sliderval',
                                                      style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryColor),
                                                    ),
                                                    Slider(
                                                      value:
                                                          _currentSliderValue,
                                                      max: 1500,
                                                      divisions: 150,
                                                      label: _currentSliderValue
                                                          .round()
                                                          .toString(),
                                                      onChanged:
                                                          (double value) {
                                                        state() {}
                                                        setState(() {
                                                          _currentSliderValue =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          FFAppState().cup =
                                                              _currentSliderValue
                                                                  .toInt();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.blue,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 14),
                                                        ),
                                                        child: Text(
                                                          'Save',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
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
                                  child: Row(
                                    children: [
                                      Text(
                                        FFAppState().cup.toString() + ' ml',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: InkWell(
                                      onDoubleTap: () async {
                                        if (FFAppState().dranksofar <=
                                            FFAppState().initialtotalwater) {

                                           
                                                 List lastBev = await myHomePageState
                                              .removeLastBeverage();
                                          print(lastBev);
                                        
                                         
                                          changePosUndo(
                                              lastBev[0].toDouble());
                                          setState(() =>
                                              FFAppState().totalwater =
                                                  functions.waterundo(
                                                      FFAppState().totalwater,
                                                      lastBev[0],
                                                      FFAppState()
                                                          .initialtotalwater,
                                                      FFAppState().drinktype));
                                          setState(() =>
                                              FFAppState().dranksofar =
                                                  functions.dranksofarundo(
                                                      lastBev[0],
                                                      FFAppState().dranksofar,
                                                      FFAppState().drinktype));
                                          setState(() => FFAppState()
                                                  .progressbarinc =
                                              FFAppState().progressbarinc +
                                                  functions.progressdec(
                                                      FFAppState().progressbar,
                                                      FFAppState()
                                                          .progressbarinc)!);
                                        } else {
                                          setState(() =>
                                              FFAppState().dranksofar =
                                                  functions.dranksofarundo(
                                                      FFAppState().cup,
                                                      FFAppState().dranksofar,
                                                      FFAppState().drinktype));
                                        }

                                        HapticFeedback.mediumImpact();
                                      },
                                      child: FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30,
                                        borderWidth: 1,
                                        buttonSize: 60,
                                        icon: FaIcon(
                                          FontAwesomeIcons.redo,
                                          color: Color(0xFFC47171),
                                          size: 30,
                                        ),
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                content:
                                                    Text('Double tap to undo'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Align(
                                    child: SizedBox(),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 60,
                                      icon: FaIcon(
                                        FontAwesomeIcons.bars,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      onPressed: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding: MediaQuery.of(context)
                                                  .viewInsets,
                                              child: MoreoptionsWidget(),
                                            );
                                          },
                                        ).then((value) => setState(() {}));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ])),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
