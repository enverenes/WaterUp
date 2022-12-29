
import '../components/slider_widget.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main_fixed/main_fixed_widget.dart';
import 'package:flutter/material.dart';


class DrinkselectCopyWidget extends StatefulWidget {
  const DrinkselectCopyWidget({Key? key}) : super(key: key);

  @override
  _DrinkselectCopyWidgetState createState() => _DrinkselectCopyWidgetState();
}

class _DrinkselectCopyWidgetState extends State<DrinkselectCopyWidget> {
  String? choiceChipsValue;

 

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
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(0, 0.05),
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FlutterFlowChoiceChips(
                          initiallySelected: ['Tall'],
                          options: [
                            ChipData('Tall'),
                            ChipData('Grande'),
                            ChipData('Venti'),
                            ChipData('Custom')
                          ],
                          onChanged: (val) async {
                            setState(() => choiceChipsValue = val?.first);
                            if (choiceChipsValue == 'Tall') {
                              setState(() => FFAppState().drinktype = 0.94);
                              setState(() => FFAppState().drinkname = 'Coffee');
                              setState(() => FFAppState().cup = 354);
                            }
                            if (choiceChipsValue == 'Grande') {
                              setState(() => FFAppState().drinktype = 0.94);
                              setState(() => FFAppState().drinkname = 'Coffee');
                              setState(() => FFAppState().cup = 473);
                            }
                            if (choiceChipsValue == 'Venti') {
                              setState(() => FFAppState().drinktype = 0.94);
                              setState(() => FFAppState().drinkname = 'Coffee');
                              setState(() => FFAppState().cup = 591);
                            }
                            if (choiceChipsValue == 'Custom') {
                              setState(() => FFAppState().drinktype = 0.94);
                              setState(() => FFAppState().drinkname = 'Coffee');
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: SliderWidget(),
                                  );
                                },
                              );
                            }
                          },
                          selectedChipStyle: ChipStyle(
                            backgroundColor:
                                FlutterFlowTheme.of(context).primaryText,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Outfit',
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                            iconColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            iconSize: 18,
                            elevation: 4,
                          ),
                          unselectedChipStyle: ChipStyle(
                            backgroundColor:
                                 FlutterFlowTheme.of(context).primaryBackgroundCoffee,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                    ),
                            iconColor:
                                FlutterFlowTheme.of(context).secondaryColor,
                            iconSize: 18,
                            elevation: 5,
                          ),
                          chipSpacing: 25,
                          multiselect: false,
                          initialized: choiceChipsValue != null,
                          alignment: WrapAlignment.center,
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
              alignment: AlignmentDirectional(0, 0),
              child: FFButtonWidget(
                onPressed: () async {
                await  MainFixedWidgetState()
                      .drinkWater(FFAppState().cup, context, true, 'C');
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 300),
                      reverseDuration: Duration(milliseconds: 300),
                      child: MainFixedWidget(),
                    ),
                  );
                  setState(() {
                    FFAppState().drinktype = 1.0;
                    FFAppState().drinkname = 'Water';
                  });
                },
                text: 'OK',
                options: FFButtonOptions(
                  width: 70,
                  height: 30,
                  color: FlutterFlowTheme.of(context).primaryText,
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
          ),
        ],
      ),
    );
  }
}
