import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:watetlo/settings/settings_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watetlo/splash_screen/splash_screen_widget.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  setLanguage(String language_string) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('language', language_string);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.language,
          style: FlutterFlowTheme.of(context).title1.override(
                fontFamily: 'Outfit',
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextButton(
              onPressed: () {
                setAppLanguage(context, 'en');
                setLanguage('en');

                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/united-kingdom.png',
                        width: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'English',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x430B0D0F),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextButton(
              onPressed: () {
                setAppLanguage(context, 'fr');
                setLanguage('fr');

                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/france.png',
                        width: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Français',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x430B0D0F),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextButton(
              onPressed: () {
                setAppLanguage(context, 'tr');
                setLanguage('tr');
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/turkey.png',
                        width: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Türkçe',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x430B0D0F),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextButton(
              onPressed: () {
                setAppLanguage(context, 'es');
                setLanguage('es');
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/spain.png',
                        width: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Español',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x430B0D0F),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextButton(
              onPressed: () {
                setAppLanguage(context, 'de');
                setLanguage('de');
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/germany.png',
                        width: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Deutsche',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x430B0D0F),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextButton(
              onPressed: () {
                setAppLanguage(context, 'pt');
                setLanguage('pt');
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/portugal.png',
                        width: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Português',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x430B0D0F),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextButton(
              onPressed: () {
                setAppLanguage(context, 'ko');
                setLanguage('ko');
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/south-korea.png',
                        width: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          '한국인',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x430B0D0F),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextButton(
              onPressed: () {
                setAppLanguage(context, 'ja');
                setLanguage('ja');
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/japan.png',
                        width: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          '日本',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x430B0D0F),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextButton(
              onPressed: () {
                setAppLanguage(context, 'sv');
                setLanguage('sv');
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/sweden.png',
                        width: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Svenska',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x430B0D0F),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextButton(
              onPressed: () {
                setAppLanguage(context, 'ar');
                setLanguage('ar');
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/saudi-arabia.png',
                        width: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'عربى',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x430B0D0F),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
