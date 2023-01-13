import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../tutorial/tutorial_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  SplashScreenWidgetState createState() => SplashScreenWidgetState();
}

class SplashScreenWidgetState extends State<SplashScreenWidget>
    with TickerProviderStateMixin {
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
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  final TextEditingController textController3 = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getType();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() => FFAppState().age = 0);
      setState(() => FFAppState().weight = 0);
      setState(() => FFAppState().cup = 0);
      setState(() => FFAppState().dranksofar = 0);
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
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    super.dispose();
  }

  static bool? isML;
  setTypes(bool mlbool) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isMl', mlbool);
    setState(() {
      isML = mlbool;
    });
  }

  getType() async {
    final prefs = await SharedPreferences.getInstance();

    isML = await prefs.getBool('isMl') ?? true;
    setState(() {});
    return isML;
  }

  int converToML(int oz) {
    return (oz * 29.57).round();
  }

  int convertToKg(int lbs) {
    return (lbs / (2.2)).round();
  }

  String _selectedLanguage = 'English';

  void _selectLanguage(String? language) {
    setState(() {
      _selectedLanguage = language ?? _selectedLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 0,
        centerTitle: false,
        actions: [
          /* Container(       //LANGUAGE SELECTION
              padding: EdgeInsets.only(
                right: 25,
              ),
              alignment: AlignmentDirectional(0, 0),
              color: FlutterFlowTheme.of(context).primaryBackground,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  elevation: 0,
                  value: _selectedLanguage,
                  onChanged: _selectLanguage,
                  items: <String>['English', 'Turkish', 'Spanish', 'French']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Image.asset(
                        value == 'English'
                            ? 'assets/images/united-kingdom.png'
                            : value == 'Spanish'
                                ? 'assets/images/spain.png'
                                : value == 'French'
                                    ? 'assets/images/france.png'
                                    : value == 'Turkish'
                                        ? 'assets/images/turkey.png'
                                        : 'assets/images/united-kingdom.png',
                        width: 34,
                      ),
                    );
                  }).toList(),
                ),
              )),   */
        ],
      ),
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
          ),
          child: ListView(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/logo_withwriting_last.png',
                      ).image,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -0.05),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0, 0.05),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    50, 0, 50, 5),
                                child: TextFormField(
                                  controller: textController1,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      labelText: 'Age',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF6770BB),
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      counterText: ''),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 18,
                                        lineHeight: 1,
                                      ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    50, 0, 50, 5),
                                child: TextFormField(
                                  controller: textController2,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      labelText: (isML ?? true)
                                          ? 'Weight (kgs)'
                                          : 'Weight (lbs)',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF6770BB),
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      counterText: ''),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 18,
                                        lineHeight: 1,
                                      ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    50, 0, 50, 60),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          padding: MaterialStatePropertyAll(
                                              EdgeInsets.all(0)),
                                          elevation:
                                              MaterialStatePropertyAll(0.0),
                                          shadowColor: null,
                                          fixedSize: MaterialStatePropertyAll(
                                              Size(150, 30)),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground),
                                        ),
                                        onPressed: () {
                                          if (isML ?? true) {
                                            setTypes(false);
                                          } else {
                                            setTypes(true);
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.autorenew,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                            Text(
                                              ' Switch Units',
                                              style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 2, 0, 20),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if ((textController1.text == '')) {
                                    if ((textController2.text == '')) {
                                      if ((textController3.text == '')) {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('Error'),
                                              content: Text(
                                                  'All the fields are required'),
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
                                      }
                                    }
                                  } else {
                                    if (!(isML ?? true)) {
                                      setState(() => FFAppState().age =
                                          int.parse(textController1.text));
                                      setState(() => FFAppState().weight =
                                          convertToKg(
                                              int.parse(textController2.text)));
                                      setState(() => FFAppState().cup = 200);
                                      setState(() => FFAppState().totalwater =
                                          functions.calculatewater(
                                              convertToKg(int.parse(
                                                  textController2.text)),
                                              int.parse(textController1.text)));
                                      functions.saveWaterToDrink(
                                          functions.calculatewater(
                                              convertToKg(double.parse(
                                                      textController2.text)
                                                  .round()),
                                              int.parse(textController1.text)));
                                      setState(() => FFAppState().progressbar =
                                          functions.progressbar1(
                                              FFAppState().totalwater,
                                              FFAppState().cup));
                                      setState(() =>
                                          FFAppState().initialtotalwater =
                                              FFAppState().totalwater);

                                      setState(() => FFAppState().time = null);
                                      setState(
                                          () => FFAppState().drinktype = 1.0);
                                      setState(() =>
                                          FFAppState().drinkname = 'Water');
                                      await Navigator.pushAndRemoveUntil(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          duration: Duration(milliseconds: 300),
                                          reverseDuration:
                                              Duration(milliseconds: 300),
                                          child: TutorialWidget(),
                                        ),
                                        (r) => false,
                                      );
                                    } else {
                                      setState(() => FFAppState().age =
                                          int.parse(textController1.text));
                                      setState(() => FFAppState().weight =
                                          int.parse(textController2.text));
                                      setState(() => FFAppState().cup = 200);
                                      setState(() => FFAppState().totalwater =
                                          functions.calculatewater(
                                              int.parse(textController2.text),
                                              int.parse(textController1.text)));
                                      functions.saveWaterToDrink(
                                          functions.calculatewater(
                                              int.parse(textController2.text),
                                              int.parse(textController1.text)));
                                      setState(() => FFAppState().progressbar =
                                          functions.progressbar1(
                                              FFAppState().totalwater,
                                              FFAppState().cup));
                                      setState(() =>
                                          FFAppState().initialtotalwater =
                                              FFAppState().totalwater);
                                      setState(() =>
                                          FFAppState().progressbarinc = 0.0);
                                      setState(() => FFAppState().time = null);
                                      setState(
                                          () => FFAppState().drinktype = 1.0);
                                      setState(() =>
                                          FFAppState().drinkname = 'Water');
                                      await Navigator.pushAndRemoveUntil(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          duration: Duration(milliseconds: 300),
                                          reverseDuration:
                                              Duration(milliseconds: 300),
                                          child: TutorialWidget(),
                                        ),
                                        (r) => false,
                                      );
                                    }
                                  }
                                },
                                text: 'Confirm',
                                options: FFButtonOptions(
                                  width: 200,
                                  height: 50,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  elevation: 3,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ).animateOnPageLoad(
                                  animationsMap['buttonOnPageLoadAnimation']!),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
