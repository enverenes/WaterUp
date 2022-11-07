import '../components/drinkselect_copy_widget.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import '../main_fixed/main_fixed_widget.dart';

class DrinkselectWidget extends StatefulWidget {
  const DrinkselectWidget({Key? key}) : super(key: key);

  @override
  _DrinkselectWidgetState createState() => _DrinkselectWidgetState();
}

class _DrinkselectWidgetState extends State<DrinkselectWidget>
    with TickerProviderStateMixin {
  var hasColumnTriggered1 = false;
  var hasColumnTriggered2 = false;
  var hasColumnTriggered3 = false;
  var hasColumnTriggered4 = false;

  @override
  void initState() {
    super.initState();
  }

  double tweenvar = 5.0;
  double tweenvar1 = 5.0;
  double tweenvar2 = 5.0;
  double tweenvar3 = 5.0;
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
              alignment: AlignmentDirectional(0, 0.1),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
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
                      Container(
                        width: 30,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            TweenAnimationBuilder(
                              duration: Duration(milliseconds: 100),
                              tween: Tween<double>(begin: 5, end: tweenvar),
                              onEnd: () async {
                                setState(() {
                                  tweenvar = 5.0;
                                });
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 300),
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    child: MainFixedWidget(),
                                  ),
                                );
                              },
                              builder: (context, double value, child) =>
                                  Positioned(
                                bottom: value,
                                child: InkWell(
                                  onTap: () async {
                                    tweenvar = 10;
                                    setState(
                                        () => FFAppState().drinktype = 1.0);
                                    setState(
                                        () => FFAppState().drinkname = 'Water');
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
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
                      ),
                      Container(
                        width: 30,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            TweenAnimationBuilder(
                              duration: Duration(milliseconds: 100),
                              tween: Tween<double>(begin: 5, end: tweenvar3),
                              onEnd: () async{
                                setState(() {
                                  tweenvar3 = 5.0;
                                });
                               await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            child: DrinkselectCopyWidget(),
                                          ),
                                        );
                                      },
                                    );
                              },
                              builder: (context, double value, child) =>
                                  Positioned(
                                bottom: value,
                                child: InkWell(
                                  onTap: () async {
                                    tweenvar3 = 10.0;
                                    setState(() =>
                                        FFAppState().drinkname = 'Coffee');

                                    
                                  },
                                  child: IgnorePointer(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image.asset(
                                          'assets/images/coffeelogo_flutter.png',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(
                                          'Coffee',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Outfit',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
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
                      ),
                      Container(
                        width: 30,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            TweenAnimationBuilder(
                              duration: Duration(milliseconds: 100),
                              tween: Tween<double>(begin: 5, end: tweenvar1),
                              onEnd: () async {
                                setState(() {
                                  tweenvar1 = 5.0;
                                });

                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 300),
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    child: MainFixedWidget(),
                                  ),
                                );
                              },
                              builder: (context, double value, child) =>
                                  Positioned(
                                bottom: value,
                                child: InkWell(
                                  onTap: () async {
                                    tweenvar1 = 10;
                                    setState(
                                        () => FFAppState().drinktype = 0.97);
                                    setState(
                                        () => FFAppState().drinkname = 'Juice');
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
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
                      ),
                      Container(
                        width: 30,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            TweenAnimationBuilder(
                              duration: Duration(milliseconds: 100),
                              tween: Tween<double>(begin: 5, end: tweenvar2),
                              onEnd: () async {
                                setState(() {
                                  tweenvar2 = 5.0;
                                });

                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 300),
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    child: MainFixedWidget(),
                                  ),
                                );
                              },
                              builder: (context, double value, child) =>
                                  Positioned(
                                bottom: value,
                                child: InkWell(
                                  onTap: () async {
                                    tweenvar2 = 10;
                                    setState(
                                        () => FFAppState().drinktype = 0.87);
                                    setState(
                                        () => FFAppState().drinkname = 'Milk');
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
