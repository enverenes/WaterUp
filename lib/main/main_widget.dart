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

import 'package:percent_indicator/percent_indicator.dart';
import 'package:watetlo/history.dart' as hist;
import 'package:shared_preferences/shared_preferences.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final hist.MyHomePageState myHomePageState = hist.MyHomePageState();

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
          begin: Offset(0, -17),
          end: Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 20.ms,
          duration: 810.ms,
         
        ),
      ],
    ),
  };

  void SetSpecificDay(String day) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('specday', day);
  }

  @override
  void initState() {
    SetSpecificDay(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
                .toString() +
            'Z');

    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Stack(
            children: [
              Stack(
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0.16),
                        child: Container(
                          width: 300,
                          height: 600,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Stack(
                            children: [
                              LinearPercentIndicator(
                                percent: FFAppState().progressbarinc,
                                width: 300,
                                lineHeight: 600,
                                animation: false,
                                progressColor: Color(0xFF95D1EA),
                                backgroundColor: Color(0xFFF1F4F8),
                                center: Text(
                                  FFAppState().totalwater.toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'roboto condensed',
                                        color: Color(0xFF1A1F24),
                                        fontSize: 70,
                                        useGoogleFonts: false,
                                      ),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Image.asset(
                                  'assets/images/adamuzun.png',
                                  width: 300,
                                  height: 600,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0.15),
                                child: Text(
                                  'ml left',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF1A1F24),
                                        fontSize: 20,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 1.01),
                        child: Container(
                          width: 2000,
                          height: 93,
                          decoration: BoxDecoration(
                            color: Color(0xFF003366),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: InkWell(
                                    onDoubleTap: () async {
                                      if (FFAppState().dranksofar <=
                                          FFAppState().initialtotalwater) {
                                        setState(() => FFAppState().totalwater =
                                            functions.waterundo(
                                                FFAppState().totalwater,
                                                FFAppState().cup,
                                                FFAppState().initialtotalwater,
                                                FFAppState().drinktype));
                                        setState(() => FFAppState().dranksofar =
                                            functions.dranksofarundo(
                                                FFAppState().cup,
                                                FFAppState().dranksofar,
                                                FFAppState().drinktype));
                                        setState(() => FFAppState()
                                            .progressbarinc = FFAppState()
                                                .progressbarinc +
                                            functions.progressdec(
                                                FFAppState().progressbar,
                                                FFAppState().progressbarinc)!);
                                      } else {
                                        setState(() => FFAppState().dranksofar =
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
                                  alignment: AlignmentDirectional(0, 0.55),
                                  child: InkWell(
                                    onLongPress: () async {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: SliderWidget(),
                                          );
                                        },
                                      ).then((value) => setState(() {}));
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          FFAppState().cup.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Outfit',
                                                color: Colors.white,
                                              ),
                                        ),
                                        Text(
                                          'ml',
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
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, -0.8),
                        child: Text(
                          FFAppState().dranksofar.toString(),
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF1A1F24),
                                fontSize: 25,
                              ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, -0.9),
                        child: Text(
                          'Today\'s total',
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF1A1F24),
                                fontSize: 30,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0.9),
                    child: InkWell(
                      
                      onTap: () async {
                      

                        if (animationsMap[
                                'containerOnActionTriggerAnimation'] !=
                            null) {
                          setState(() => hasContainerTriggered = true);
                          SchedulerBinding.instance.addPostFrameCallback(
                              (_) async => await animationsMap[
                                      'containerOnActionTriggerAnimation']!
                                  .controller
                                  .forward(from: 0.0));
                        }

                          setState(() {
                        
                       
                        });
                        setState(() => FFAppState().totalwater =
                            functions.waterleft(
                                FFAppState().cup,
                                FFAppState().totalwater,
                                FFAppState().drinktype));

                        setState(() => FFAppState().progressbarinc =
                            FFAppState().progressbarinc +
                                functions.progressinc(FFAppState().progressbar,
                                    FFAppState().progressbarinc));
                        setState(() => FFAppState().dranksofar =
                            FFAppState().dranksofar +
                                functions.drinktypecupsize(
                                    FFAppState().cup, FFAppState().drinktype));
                        HapticFeedback.lightImpact();
                        if (functions.everydayreset(FFAppState().time) == 1) {
                          if (FFAppState().totalwater <= 0) {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                duration: Duration(milliseconds: 300),
                                reverseDuration: Duration(milliseconds: 300),
                                child: SardiWidget(),
                              ),
                            );
                            setState(
                                () => FFAppState().time = getCurrentTimestamp);
                            setState(() => FFAppState().totalwater = 0);
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
                              alignment: AlignmentDirectional(0, 0.9),
                              child: Image.asset(
                                'assets/images/button_bardak.png',
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0.2),
                              child: Text(
                                FFAppState().drinkname,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animateOnActionTrigger(
                        animationsMap['containerOnActionTriggerAnimation']!,
                        hasBeenTriggered: hasContainerTriggered),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
