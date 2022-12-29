import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:watetlo/firebase_options.dart';
import 'package:watetlo/main_fixed/main_fixed_widget.dart';
import 'auth/firebase_user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'index.dart';
import 'package:home_widget/home_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:watetlo/history.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'dart:io' show Platform;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  print('User granted permission: ${settings.authorizationStatus}');

  await FlutterFlowTheme.initialize();

  FFAppState(); // Initialize FFAppState
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late Stream<WatetloFirebaseUser> userStream;
  WatetloFirebaseUser? initialUser;
  bool displaySplashImage = true;

  var inipage;

  Future getInitialPage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      inipage = prefs.getInt('initialpage');
    });
  }

  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);

    PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration =
          PurchasesConfiguration("goog_lerxVMViMarxCepdPPuKGxuLRmH");
    } else {
      configuration = PurchasesConfiguration("public_ios_sdk_key");
    }
    await Purchases.configure(configuration);

   
       }

  @override
  void initState() {
    super.initState();

    getInitialPage();
    userStream = watetloFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
    Future.delayed(
      Duration(seconds: 1),
      () => setState(() => displaySplashImage = false),
    );

    initPlatformState();
  }

  void setLocale(String language) =>
      setState(() => _locale = createLocale(language));
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/history': (context) => const MyHomePage(),
        '/mainfixed': (context) => const MainFixedWidget(),
      },
      debugShowCheckedModeBanner: false,
      title: 'watetlo',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      home: initialUser == null || displaySplashImage
          ? Builder(
              builder: (context) => Container(
                color: Colors.transparent,
                child: Image.asset(
                  'assets/images/splashimg.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : inipage == 1
              ? MainFixedWidget()
              : SplashScreenWidget(),
    );
  }
}
