import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main_fixed/main_fixed_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watetlo/notifications.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'dart:io' show Platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorialWidget extends StatefulWidget {
  const TutorialWidget({Key? key}) : super(key: key);

  @override
  _TutorialWidgetState createState() => _TutorialWidgetState();
}

class _TutorialWidgetState extends State<TutorialWidget> {
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);

    PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration =
          PurchasesConfiguration("goog_lerxVMViMarxCepdPPuKGxuLRmH");
    } else {
      configuration =
          PurchasesConfiguration("appl_lpfudKmsGMForwQndSQZrMijbcC");
    }
    await Purchases.configure(configuration);
  }

  Future<void> setPremium() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      CustomerInfo purchaserInfo = await Purchases.getCustomerInfo();
      bool premactive =
          purchaserInfo.entitlements.all["premium"]?.isActive ?? false;

      if (premactive) {
        await prefs.setInt('premium', 1);
      } else {
        await prefs.setInt('premium', 0);
      }
    } catch (e) {
      await prefs.setInt('premium', 0);
    }
  }

  void initialDay() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'resetday',
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .toString());
  }

  @override
  void initState() {
    initPlatformState();
    super.initState();
    initialDay();
    setPremium();
  }

  void setInitialPage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('initialpage', 1);
  }

  void setStartDate() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'reset',
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20, 150, 20, 150),
                            child: PageView(
                              controller: pageViewController ??=
                                  PageController(initialPage: 0),
                              scrollDirection: Axis.horizontal,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Image.asset(
                                    'assets/images/mcatd_1.png',
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/9hsjc_2.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                                Image.asset(
                                  'assets/images/albfo_3.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                                Image.asset(
                                  'assets/images/ml88i_4.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                                Image.asset(
                                  'assets/images/x5rbw_5.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 1),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                              child: smooth_page_indicator.SmoothPageIndicator(
                                controller: pageViewController ??=
                                    PageController(initialPage: 0),
                                count: 5,
                                axisDirection: Axis.horizontal,
                                onDotClicked: (i) {
                                  pageViewController!.animateToPage(
                                    i,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                effect:
                                    smooth_page_indicator.ExpandingDotsEffect(
                                  expansionFactor: 2,
                                  spacing: 8,
                                  radius: 16,
                                  dotWidth: 16,
                                  dotHeight: 16,
                                  dotColor: Color(0xFF9E9E9E),
                                  activeDotColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  paintStyle: PaintingStyle.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.8, 0.93),
                      child: FFButtonWidget(
                        onPressed: () async {
                          setInitialPage();

                          setStartDate();
                          await Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 300),
                              reverseDuration: Duration(milliseconds: 300),
                              child: MainFixedWidget(),
                            ),
                            (r) => false,
                          );
                        },
                        text: AppLocalizations.of(context)!.tutorial_button,
                        options: FFButtonOptions(
                          width: 70,
                          height: 40,
                          color: FlutterFlowTheme.of(context).primaryText,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Outfit',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, -0.8),
                      child: Text(
                        AppLocalizations.of(context)!.tutorial_title,
                        style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
