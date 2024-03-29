import 'dart:async';
import '../flutter_flow/flutter_flow_choice_chips.dart';
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
import 'package:home_widget/home_widget.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:watetlo/premiumpage.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'dart:io' show Platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainFixedWidget extends StatefulWidget {
  const MainFixedWidget({Key? key}) : super(key: key);

  @override
  MainFixedWidgetState createState() => MainFixedWidgetState();
}

class MainFixedWidgetState extends State<MainFixedWidget>
    with TickerProviderStateMixin {
  Future<void> backgroundCallback(Uri uri) async {
    if (uri.host == 'updatecounter') {
      print('water drink');
      await HomeWidget.updateWidget(
          name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
    }
  }

  String? choiceChipsValue;

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

  bool? isML;
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

  int converToOz(int ml) {
    return (ml * 0.0338).round();
  }

  int converToML(int oz) {
    return (oz * 29.57).toInt();
  }

  int convertToKg(int lbs) {
    return (lbs * (2.2)).toInt();
  }

  Widget returnCup() {
    return Image.asset(
      'assets/images/button_bardak.png',
      width: 80,
      fit: BoxFit.cover,
    );
  }

  Widget Adam() {
    if (Theme.of(context).brightness == Brightness.light) {
      return Image.asset(
        'assets/images/adamuzun.png',
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(
        'assets/images/adamuzun_gece.png',
        fit: BoxFit.fill,
      );
    }
  }

  Widget backgroundAdam() {
    if (Theme.of(context).brightness == Brightness.light) {
      return Container(
        color: Color.fromARGB(255, 227, 227, 227),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.height * 0.35 - (4),
        height:
            MediaQuery.of(context).size.height * (0.35 * 2.043478260869565) -
                (4),
        color: Colors.white,
      );
    }
  }

  void resetDay() async {
    final prefs = await SharedPreferences.getInstance();
    String today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .toString();
    String day = prefs.getString('resetday') ?? '';
    if (day == today) {
      return;
    } else {
      await prefs.setDouble(day + 'percentage',
          (FFAppState().dranksofar / FFAppState().initialtotalwater));
      setState(() {
        FFAppState().dranksofar = 0;
        FFAppState().totalwater = FFAppState().initialtotalwater;
        prefs.setString('resetday', today);
        initialPos();
      });
    }
  }

  BannerAd? bannerAdTest;

  @override
  void initState() {
    //INITSTATE
    super.initState();

    getType();
    WidgetsFlutterBinding.ensureInitialized();
    setToWater();
    //Notification settings
    resetDay();
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

    adActionsGet();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setToWater() {
    setState(() => FFAppState().drinktype = 1.0);
    setState(() => FFAppState().drinkname = 'Water');
  }

  double pos = 0.0;
  bool completed = false;
  void initialPos() async {
    final prefs = await SharedPreferences.getInstance();
    int totalwater = FFAppState().initialtotalwater;
    double percentage_filled = (FFAppState().dranksofar / totalwater);

    if (percentage_filled > 1) {
      percentage_filled = 1.0;
    }
    var inc = percentage_filled *
        (MediaQuery.of(context).size.height * (0.35 * 2.043478260869565));

    if (percentage_filled == 1.0) {
      pos = 0;
    } else {
      pos = (1 - percentage_filled) *
          (MediaQuery.of(context).size.height * (0.35 * 2.043478260869565));
    }
  }

  void changePos(double cupsize, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    int totalwater = FFAppState().initialtotalwater;

    var inc = (cupsize / totalwater) *
        MediaQuery.of(context).size.height *
        (0.35 * 2.043478260869565);

    if (pos - inc > 0) {
      pos -= inc;
    } else {
      pos = 0;
    }
  }

  void changePosUndo(double cupsize) async {
    final prefs = await SharedPreferences.getInstance();

    int totalwater = FFAppState().initialtotalwater;

    setState(() {
      var inc = (cupsize / totalwater) *
          ((MediaQuery.of(context).size.height * (0.35 * 2.043478260869565)));

      if (pos + inc <=
          (MediaQuery.of(context).size.height * (0.35 * 2.043478260869565))) {
        pos += inc;
      } else {
        pos = (MediaQuery.of(context).size.height * (0.35 * 2.043478260869565));
      }
    });
  }

  double _currentSliderValue = FFAppState().cup.toDouble();

  String currentdrinktype = FFAppState().drinkname[0];

  double tweenvar = 32.0;

  drinkWater(int cup, BuildContext context, bool onetime, String type) {
    if (!onetime) {
      myHomePageState.addWaterToHist(cup, currentdrinktype);
    } else {
      myHomePageState.addWaterToHist(cup, type);
    }

    changePos(cup.toDouble(), context);

    setState(() => FFAppState().totalwater = functions.waterleft(
        cup, FFAppState().totalwater, FFAppState().drinktype));

    setState(() => FFAppState().dranksofar = FFAppState().dranksofar +
        functions.drinktypecupsize(cup, FFAppState().drinktype));
    HapticFeedback.lightImpact();
    if (functions.everydayreset(FFAppState().time) == 1) {
      if (FFAppState().totalwater <= 0) {
        setState(() {});
        completed = true;
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            child: SardiWidget(),
          ),
        );
        setState(() => FFAppState().time = getCurrentTimestamp);
        setState(() => FFAppState().totalwater = 0);
      } else {
        return;
      }
    } else {
      return;
    }
  }

  drinkWaterFetch(int cup, BuildContext context, bool onetime, String type) {
    if (!onetime) {
      myHomePageState.addWaterToHist(cup, currentdrinktype);
    } else {
      myHomePageState.addWaterToHist(cup, type);

      changePos(cup.toDouble(), context);
      FFAppState().totalwater = functions.waterleft(
          cup, FFAppState().totalwater, FFAppState().drinktype);
      FFAppState().dranksofar = FFAppState().dranksofar +
          functions.drinktypecupsize(cup, FFAppState().drinktype);
      HapticFeedback.lightImpact();
      if (functions.everydayreset(FFAppState().time) == 1) {
        if (FFAppState().totalwater <= 0) {
          completed = true;
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 300),
              reverseDuration: Duration(milliseconds: 300),
              child: SardiWidget(),
            ),
          );
          FFAppState().time = getCurrentTimestamp;
          FFAppState().totalwater = 0;
        } else {
          return;
        }
      } else {
        return;
      }
    }
  }

  bool adsOnline = true;
  int adCounter = 0;
  InterstitialAd? interstitialAdTest;

  adActionsSet(int action) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('adactioncount', action);
  }

  adActionsGet() async {
    final prefs = await SharedPreferences.getInstance();
    adCounter = prefs.getInt('adactioncount') ?? 0;

    int? premiumi = prefs.getInt('premium');

    if (premiumi == 1) {
      setState(() {
        adsOnline = false;
      });
    }

    try {
      CustomerInfo purchaserInfo = await Purchases.getCustomerInfo();
      //await prefs.setInt('premium', 1); //ERASE TEST!
      if ((purchaserInfo.entitlements.all['premium']?.isActive != null)
          ? purchaserInfo.entitlements.all['premium']!.isActive
          : false) {
        await prefs.setInt('premium', 1);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    resetDay();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
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
                            AppLocalizations.of(context)!.main_top_title,
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'Outfit',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontSize: 30,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, -0.8),
                        child: (isML ?? true)
                            ? Text(
                                FFAppState().dranksofar.toString() + ' ml',
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontSize: 25,
                                    ),
                              )
                            : Text(
                                converToOz(FFAppState().dranksofar).toString() +
                                    ' oz',
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
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
                        width: MediaQuery.of(context).size.height * 0.35,
                        height: MediaQuery.of(context).size.height *
                            (0.35 * 2.043478260869565),
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.antiAlias,
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              child: backgroundAdam(),
                            ),
                            TweenAnimationBuilder(
                              tween: Tween<double>(
                                  begin: (MediaQuery.of(context).size.height *
                                      (0.35 * 2.043478260869565)),
                                  end: pos),
                              duration: const Duration(milliseconds: 1000),
                              onEnd: () {
                                print(pos);
                              },
                              builder: (context, double value, child) {
                                return Positioned(
                                  top: value,
                                  right: 0.0,
                                  left: 0.0,
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    width: MediaQuery.of(context).size.height *
                                            0.35 -
                                        (4),
                                    height: MediaQuery.of(context).size.height *
                                            (0.35 * 2.043478260869565) +
                                        50,
                                    child: RiveAnimation.asset(
                                      'assets/rive_animations/wave.riv',
                                      fit: BoxFit.fill,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Align(child: Adam()),
                            Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (isML ?? true)
                                        ? FFAppState().totalwater.toString()
                                        : converToOz(FFAppState().totalwater)
                                            .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Colors.black54,
                                          fontSize: 45,
                                        ),
                                  ),
                                  Text(
                                    (isML ?? true)
                                        ? 'ml ' +
                                            AppLocalizations.of(context)!
                                                .main_middle_ind
                                        : 'oz ' +
                                            AppLocalizations.of(context)!
                                                .main_middle_ind,
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Colors.black54,
                                          fontSize: 25,
                                        ),
                                  ),
                                ],
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
                      height: MediaQuery.of(context).size.height * 0.1,
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
                                  tween:
                                      Tween<double>(begin: 32, end: tweenvar),
                                  onEnd: () {
                                    setState(() {
                                      tweenvar = 32.0;
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
                                                onLongPress: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    context: context,
                                                    builder: (context) {
                                                      return Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .copyWith()
                                                                .size
                                                                .height *
                                                            0.2,
                                                        child: Padding(
                                                          padding:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .viewInsets,
                                                          child:
                                                              StatefulBuilder(
                                                            builder:
                                                                (BuildContext
                                                                        context,
                                                                    setState) {
                                                              var sliderval =
                                                                  _currentSliderValue
                                                                      .toInt();
                                                              return Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    (isML ??
                                                                            true)
                                                                        ? '$sliderval' +
                                                                            ' ml'
                                                                        : converToOz(sliderval).toString() +
                                                                            ' oz',
                                                                    style: TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryColor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Slider(
                                                                    activeColor:
                                                                        Color(
                                                                            0xFF003366),
                                                                    value:
                                                                        _currentSliderValue,
                                                                    max: 1500,
                                                                    divisions:
                                                                        150,
                                                                    label: (isML ??
                                                                            true)
                                                                        ? _currentSliderValue
                                                                            .round()
                                                                            .toString()
                                                                        : converToOz(_currentSliderValue.round())
                                                                            .toString(),
                                                                    onChanged:
                                                                        (double
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        _currentSliderValue =
                                                                            value;
                                                                      });
                                                                    },
                                                                  ),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        FFAppState().cup =
                                                                            _currentSliderValue.toInt();
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            Color(0xFF003366),
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        textStyle:
                                                                            const TextStyle(fontSize: 14),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .drink_slider_button,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ))
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      setState(() {}));
                                                },
                                                onTap: () async {
                                                  tweenvar = 42.0;
                                                  adCounter++;
                                                  adActionsSet(adCounter);
                                                  if ((adCounter % 7 == 0) &
                                                      adsOnline) {
                                                    InterstitialAd.load(
                                                        adUnitId: (Platform
                                                                .isAndroid)
                                                            ? 'ca-app-pub-5585667908104814/8599455459'
                                                            : 'ca-app-pub-5585667908104814/2011890012',
                                                        request:
                                                            const AdRequest(),
                                                        adLoadCallback:
                                                            InterstitialAdLoadCallback(
                                                                onAdLoaded:
                                                                    (ad) {
                                                          interstitialAdTest =
                                                              ad;
                                                          interstitialAdTest!
                                                              .show();

                                                          interstitialAdTest!
                                                                  .fullScreenContentCallback =
                                                              FullScreenContentCallback(
                                                            onAdFailedToShowFullScreenContent:
                                                                (ad, error) {
                                                              debugPrint(error
                                                                  .message);
                                                              ad.dispose();
                                                              interstitialAdTest!
                                                                  .dispose();
                                                            },
                                                            onAdDismissedFullScreenContent:
                                                                (ad) {
                                                              ad.dispose();
                                                              interstitialAdTest!
                                                                  .dispose();
                                                            },
                                                          );
                                                        }, onAdFailedToLoad:
                                                                    (err) {
                                                          debugPrint(
                                                              err.message);
                                                        }));
                                                  }

                                                  drinkWater(FFAppState().cup,
                                                      context, false, 'W');
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
                                                          child: returnCup()),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                ),
                                Positioned(
                                  bottom: 15,
                                  child: Container(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 6, end: 6),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                                padding: EdgeInsets.all(0),
                                                child: StatefulBuilder(
                                                  builder:
                                                      (BuildContext context,
                                                          setState) {
                                                    var sliderval =
                                                        _currentSliderValue
                                                            .toInt();
                                                    return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '$sliderval' + ' ml',
                                                          style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Slider(
                                                          activeColor:
                                                              Color(0xFF003366),
                                                          value:
                                                              _currentSliderValue,
                                                          max: 1500,
                                                          divisions: 150,
                                                          label:
                                                              _currentSliderValue
                                                                  .round()
                                                                  .toString(),
                                                          onChanged:
                                                              (double value) {
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
                                                                  Color(
                                                                      0xFF003366),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              textStyle:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          14),
                                                            ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .drink_slider_button,
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryColor,
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
                                            (isML ?? true)
                                                ? FFAppState().cup.toString() +
                                                    ' ml'
                                                : converToOz(FFAppState().cup)
                                                        .toString() +
                                                    ' oz',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                    fontFamily: 'Outfit',
                                                    color:
                                                        const Color(0xFF57636C),
                                                    fontWeight:
                                                        FontWeight.w300),
                                          ),
                                        ],
                                      ),
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
                                          adCounter++;
                                          adActionsSet(adCounter);

                                          if ((adCounter % 7 == 0) &
                                              adsOnline) {
                                            InterstitialAd.load(
                                                adUnitId:
                                                    'ca-app-pub-5585667908104814/8599455459',
                                                request: const AdRequest(),
                                                adLoadCallback:
                                                    InterstitialAdLoadCallback(
                                                        onAdLoaded: (ad) {
                                                  interstitialAdTest = ad;
                                                  interstitialAdTest!.show();

                                                  interstitialAdTest!
                                                          .fullScreenContentCallback =
                                                      FullScreenContentCallback(
                                                    onAdFailedToShowFullScreenContent:
                                                        (ad, error) {
                                                      debugPrint(error.message);
                                                      ad.dispose();
                                                      interstitialAdTest!
                                                          .dispose();
                                                    },
                                                    onAdDismissedFullScreenContent:
                                                        (ad) {
                                                      ad.dispose();
                                                      interstitialAdTest!
                                                          .dispose();
                                                    },
                                                  );
                                                }, onAdFailedToLoad: (err) {
                                                  debugPrint(err.message);
                                                }));
                                          }

                                          if (FFAppState().dranksofar <=
                                              FFAppState().initialtotalwater) {
                                            List lastBev = await myHomePageState
                                                .removeLastBeverage();
                                            print(lastBev);

                                            changePosUndo(
                                                (lastBev[0] ?? 0).toDouble());

                                            setState(() {
                                              FFAppState().dranksofar =
                                                  functions.dranksofarundo(
                                                      lastBev[0],
                                                      FFAppState().dranksofar,
                                                      lastBev[1]);
                                              FFAppState().totalwater =
                                                  functions.waterundo(
                                                      FFAppState().dranksofar,
                                                      FFAppState().totalwater,
                                                      lastBev[0],
                                                      FFAppState()
                                                          .initialtotalwater,
                                                      lastBev[1]);
                                            });
                                          } else {
                                            List lastBev = await myHomePageState
                                                .removeLastBeverage();
                                            setState(() {
                                              FFAppState().dranksofar =
                                                  functions.dranksofarundo(
                                                      lastBev[0] ?? 0,
                                                      FFAppState().dranksofar,
                                                      lastBev[1]);

                                              if (FFAppState()
                                                          .initialtotalwater -
                                                      FFAppState().dranksofar >
                                                  0) {
                                                FFAppState().totalwater =
                                                    FFAppState()
                                                            .initialtotalwater -
                                                        FFAppState().dranksofar;
                                                changePosUndo(FFAppState()
                                                    .totalwater
                                                    .toDouble());
                                              }
                                            });
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
                                                  content: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .doubletap_error,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Icon(Icons
                                                          .ads_click_rounded),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .ok_button,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
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
      ),
    );
  }

  Widget DrinkSelectWidget() {
    int send_coffeval = 0;

    double _currentSliderValue = FFAppState().cup.toDouble();

    double tweenvar = 5.0;
    double tweenvar1 = 5.0;
    double tweenvar2 = 5.0;
    double tweenvar3 = 5.0;
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
                            child: MainFixedWidget(),
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
                              'Water',
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
                                                            ChipData(AppLocalizations
                                                                    .of(context)!
                                                                .coffee_custom)
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
                                                                                  'Cup Size: ' + '$sliderval' + ' ml',
                                                                                  style: TextStyle(color: FlutterFlowTheme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                Slider(
                                                                                  activeColor: Color(0xFF003366),
                                                                                  value: _currentSliderValue,
                                                                                  max: 1500,
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
                                                                                      await drinkWater(send_coffeval, context, true, 'C');

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
                                                                                      'Drink',
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
                                                  await drinkWater(
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
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .ok_button,
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
                                  'Coffee',
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
                                                  'Cup Size: ' +
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
                                                      await drinkWater(
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
                                                          child:
                                                              MainFixedWidget(),
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
                                                      'Drink',
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
                                  'Juice',
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
                                                  'Cup Size: ' +
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
                                                      await drinkWater(
                                                          _currentSliderValue
                                                              .toInt(),
                                                          context,
                                                          true,
                                                          'M');

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
                                                          child:
                                                              MainFixedWidget(),
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
                                                      'Drink',
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
                                  'Milk',
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
