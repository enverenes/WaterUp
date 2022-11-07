import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _totalwater = prefs.getInt('ff_totalwater') ?? _totalwater;
    _age = prefs.getInt('ff_age') ?? _age;
    _weight = prefs.getInt('ff_weight') ?? _weight;
    _cup = prefs.getInt('ff_cup') ?? _cup;
    _increaseheight = prefs.getInt('ff_increaseheight') ?? _increaseheight;
    _progressbar = prefs.getDouble('ff_progressbar') ?? _progressbar;
    _progressbarinc = prefs.getDouble('ff_progressbarinc') ?? _progressbarinc;
    _initialtotalwater =
        prefs.getInt('ff_initialtotalwater') ?? _initialtotalwater;
    _unit = prefs.getString('ff_unit') ?? _unit;
    _dranksofar = prefs.getInt('ff_dranksofar') ?? _dranksofar;
    _time = prefs.containsKey('ff_time')
        ? DateTime.fromMillisecondsSinceEpoch(prefs.getInt('ff_time')!)
        : null;
    _drinktype = prefs.getDouble('ff_drinktype') ?? _drinktype;
    _drinkname = prefs.getString('ff_drinkname') ?? _drinkname;
  }

  late SharedPreferences prefs;

  int _totalwater = 0;
  int get totalwater => _totalwater;
  set totalwater(int _value) {
    _totalwater = _value;
    prefs.setInt('ff_totalwater', _value);
  }

  int _age = 0;
  int get age => _age;
  set age(int _value) {
    _age = _value;
    prefs.setInt('ff_age', _value);
  }

  int _weight = 0;
  int get weight => _weight;
  set weight(int _value) {
    _weight = _value;
    prefs.setInt('ff_weight', _value);
  }

  int _cup = 0;
  int get cup => _cup;
  set cup(int _value) {
    _cup = _value;
    prefs.setInt('ff_cup', _value);
  }

  int _increaseheight = 0;
  int get increaseheight => _increaseheight;
  set increaseheight(int _value) {
    _increaseheight = _value;
    prefs.setInt('ff_increaseheight', _value);
  }

  double _progressbar = 0.0;
  double get progressbar => _progressbar;
  set progressbar(double _value) {
    _progressbar = _value;
    prefs.setDouble('ff_progressbar', _value);
  }

  double _progressbarinc = 0;
  double get progressbarinc => _progressbarinc;
  set progressbarinc(double _value) {
    _progressbarinc = _value;
    prefs.setDouble('ff_progressbarinc', _value);
  }

  int _initialtotalwater = 0;
  int get initialtotalwater => _initialtotalwater;
  set initialtotalwater(int _value) {
    _initialtotalwater = _value;
    prefs.setInt('ff_initialtotalwater', _value);
  }

  String _unit = '';
  String get unit => _unit;
  set unit(String _value) {
    _unit = _value;
    prefs.setString('ff_unit', _value);
  }

  int _dranksofar = 0;
  int get dranksofar => _dranksofar;
  set dranksofar(int _value) {
    _dranksofar = _value;
    prefs.setInt('ff_dranksofar', _value);
  }

  DateTime? _time;
  DateTime? get time => _time;
  set time(DateTime? _value) {
    if (_value == null) {
      return;
    }
    _time = _value;
    prefs.setInt('ff_time', _value.millisecondsSinceEpoch);
  }

  double _drinktype = 0.0;
  double get drinktype => _drinktype;
  set drinktype(double _value) {
    _drinktype = _value;
    prefs.setDouble('ff_drinktype', _value);
  }

  String _drinkname = '';
  String get drinkname => _drinkname;
  set drinkname(String _value) {
    _drinkname = _value;
    prefs.setString('ff_drinkname', _value);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
