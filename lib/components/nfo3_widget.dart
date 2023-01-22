import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Nfo3Widget extends StatefulWidget {
  const Nfo3Widget({Key? key}) : super(key: key);

  @override
  _Nfo3WidgetState createState() => _Nfo3WidgetState();
}

class _Nfo3WidgetState extends State<Nfo3Widget> {
  TextEditingController? textController1;
  TextEditingController? textController2;

  @override
  void initState() {
    super.initState();
    getType();
    textController1 = TextEditingController(text: FFAppState().age.toString());
    textController2 =
        TextEditingController(text: FFAppState().weight.toString());
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
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

    if (isML ?? true) {
      textController2!.text = FFAppState().weight.toString();
    } else {
      textController2!.text = convertToLbs(FFAppState().weight).toString();
    }

    return isML;
  }

  int converToML(int oz) {
    return (oz * 29.57).round();
  }

  int convertToKg(int lbs) {
    return (lbs / (2.2)).round();
  }

  int convertToLbs(int kgs) {
    return (kgs * (2.2)).round();
  }

  setWaterToDrink(int waterleft) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('watertodrink', waterleft);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Align(
        alignment: AlignmentDirectional(0, 0),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0, 0.15),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              maxLength: 2,
                              controller: textController1,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                counterText: '',
                                labelText:
                                    AppLocalizations.of(context)!.age_inbox,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: textController1!.text.isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          textController1?.clear();
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 22,
                                        ),
                                      )
                                    : null,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
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
                  alignment: AlignmentDirectional(0, -2),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0, -0.15),
                              child: TextFormField(
                                maxLength: 3,
                                controller: textController2,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  counterText: '',
                                  labelText: (isML ?? true)
                                      ? AppLocalizations.of(context)!
                                              .weight_inbox +
                                          ' kgs'
                                      : AppLocalizations.of(context)!
                                              .weight_inbox +
                                          ' lbs',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                  hintStyle:
                                      FlutterFlowTheme.of(context).bodyText2,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  suffixIcon: textController2!.text.isNotEmpty
                                      ? InkWell(
                                          onTap: () async {
                                            textController2?.clear();
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.clear,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 22,
                                          ),
                                        )
                                      : null,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (isML ?? true) {
                      setState(() =>
                          FFAppState().age = int.parse(textController1!.text));
                      setState(() => FFAppState().weight =
                          int.parse(textController2!.text));
                      setState(() => FFAppState().totalwater =
                          functions.calculatewater(
                                  int.parse(textController2!.text),
                                  int.parse(textController1!.text)) -
                              FFAppState().dranksofar);
                      setState(() => FFAppState().initialtotalwater =
                          functions.calculatewater(
                              int.parse(textController2!.text),
                              int.parse(textController1!.text)));
                      setWaterToDrink(functions.calculatewater(
                          int.parse(textController2!.text),
                          (int.parse(textController1!.text))));
                    } else {
                      setState(() =>
                          FFAppState().age = int.parse(textController1!.text));
                      setState(() => FFAppState().weight =
                          convertToKg(int.parse(textController2!.text)));
                      setState(() => FFAppState().totalwater =
                          functions.calculatewater(
                                  convertToKg(int.parse(textController2!.text)),
                                  int.parse(textController1!.text)) -
                              FFAppState().dranksofar);

                      setState(() => FFAppState().initialtotalwater =
                          functions.calculatewater(
                              int.parse(textController2!.text),
                              convertToKg(int.parse(textController1!.text))));
                      setWaterToDrink(functions.calculatewater(
                          int.parse(textController2!.text),
                          convertToKg(int.parse(textController1!.text))));
                    }

                    if (FFAppState().totalwater < 0) {
                      setState(() {
                        FFAppState().totalwater = 0;
                      });
                    }
                    print(FFAppState().initialtotalwater);
                    print(FFAppState().dranksofar);

                    Navigator.pop(context);
                  },
                  text: 'Save',
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: Color(0xFF003366),
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
