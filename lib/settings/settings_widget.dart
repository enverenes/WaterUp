import 'package:auto_size_text/auto_size_text.dart';
import 'package:watetlo/index.dart';

import '../components/nfo3_widget.dart';
import 'dart:io' show Platform;
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../tutorial/tutorial_widget.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:watetlo/premiumpage.dart' as premium;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:watetlo/notifications.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final BannerAd bannerAdSettings = BannerAd(
    adUnitId: (Platform.isAndroid)
        ? 'ca-app-pub-5585667908104814/4406711964'
        : 'ca-app-pub-5585667908104814/7288305414',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

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

  @override
  void initState() {
    // TODO: implement initState

    getType();
    adActionsGet();

    super.initState();

    bannerAdSettings.load();
  }

  bool adsonline = true;

  adActionsGet() async {
    final prefs = await SharedPreferences.getInstance();

    int? premiu = prefs.getInt('premium');

    if (premiu == 1) {
      setState(() {
        adsonline = false;
      });
    } else {}
  }

  Widget bottomAd() {
    if (adsonline) {
      return AdWidget(ad: bannerAdSettings);
    } else {
      return Container(
        height: 10,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
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
        ),
        title: Text(
          'Settings',
          style: FlutterFlowTheme.of(context).title1.override(
                fontFamily: 'Outfit',
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (Theme.of(context).brightness == Brightness.light)
                    InkWell(
                      onTap: () async {
                        setDarkModeSetting(context, ThemeMode.dark);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Switch to Dark Mode',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1F4F8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  alignment: AlignmentDirectional(0, 0),
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.95, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 8, 0),
                                        child: Icon(
                                          Icons.nights_stay,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(-0.85, 0),
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x430B0D0F),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          shape: BoxShape.rectangle,
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
                    ),
                  if (Theme.of(context).brightness == Brightness.dark)
                    InkWell(
                      onTap: () async {
                        setDarkModeSetting(context, ThemeMode.light);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Switch to Light Mode',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1F4F8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  alignment: AlignmentDirectional(0, 0),
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(-0.9, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 2, 0, 0),
                                        child: Icon(
                                          Icons.wb_sunny_rounded,
                                          color: Color(0xFF57636C),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.9, 0),
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x430B0D0F),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          shape: BoxShape.rectangle,
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
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (isML ?? true)
                    InkWell(
                      onTap: () async {
                        setTypes(false);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Switch to US units',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1F4F8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  alignment: AlignmentDirectional(0, 0),
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.95, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 8, 0),
                                        child: Icon(
                                          Icons.switch_right,
                                          color: Color(0xFF57636C),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(-0.85, 0),
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x430B0D0F),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          shape: BoxShape.rectangle,
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
                    ),
                  if (!(isML ?? true))
                    InkWell(
                      onTap: () async {
                        setTypes(true);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Switch EU units',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1F4F8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  alignment: AlignmentDirectional(0, 0),
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(-0.9, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 2, 0, 0),
                                        child: Icon(
                                          Icons.switch_left,
                                          color: Color(0xFF57636C),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.9, 0),
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x430B0D0F),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          shape: BoxShape.rectangle,
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
                    ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: InkWell(
                    onTap: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Nfo3Widget(),
                            ),
                          );
                        },
                      ).then((value) => setState(() {}));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Icon(
                                Icons.info_outlined,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: AutoSizeText(
                                  'Update Weight/Age',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                      child: InkWell(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          int? premium1 = prefs.getInt('premium');
                          if (premium1 == 1) {
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                duration: Duration(milliseconds: 300),
                                reverseDuration: Duration(milliseconds: 300),
                                child: Notifications(),
                              ),
                            );
                          } else {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Row(
                                        children: [
                                          const Text(
                                              'This is a premium feature '),
                                        ],
                                      ),
                                      content: const Text(
                                          'Buy Premium to unlock this feature'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return premium.premium();
                                              }),
                                          child: Center(
                                            child: const Text('Buy Premium Now',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Roboto',
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ),
                                      ],
                                    ));
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.57, 0),
                              child: Icon(
                                Icons.notifications_active,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Text(
                                  'Notification Settings',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 300),
                          reverseDuration: Duration(milliseconds: 300),
                          child: TutorialWidget(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0.35),
                              child: FaIcon(
                                FontAwesomeIcons.questionCircle,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: Text(
                                'How to use',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                  child: InkWell(
                    onTap: () async {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return premium.premium();
                          });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0.35),
                              child: FaIcon(
                                FontAwesomeIcons.gem,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: Text(
                                'Premium',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                  child: InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: Center(child: Text('Visit our website')),
                              actionsAlignment: MainAxisAlignment.start,
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        launchURL(
                                            'https://www.weinteractive.net/privacy-policy');
                                      },
                                      child: Text('Privacy Policy')),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        launchURL(
                                            'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/');
                                      },
                                      child: Text('Terms of Use')),
                                ],
                              ),
                            );
                          }));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0.35),
                              child: FaIcon(
                                FontAwesomeIcons.bookmark,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: Text(
                                'Privacy Policy & Terms of Use',
                                overflow: TextOverflow.ellipsis,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          alignment: AlignmentDirectional.bottomCenter,
          width: bannerAdSettings.size.width.toDouble(),
          height: bannerAdSettings.size.height.toDouble(),
          child: bottomAd(),
        ),
        elevation: 0,
      ),
    );
  }
}
