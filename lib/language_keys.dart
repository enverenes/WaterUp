import 'package:flutter/material.dart';

class LanguageKey {
  final String key;
  final String value;

  const LanguageKey({
    required this.key,
    required this.value,
  });
}

class LanguageKeys with ChangeNotifier {
  final List<LanguageKey> _items = [];

  List<LanguageKey> get items {
    return  [LanguageKey(key: 'hello', value: 'Hello'), LanguageKey(key: 'goodbye', value: 'Goodbye')];
  }

  void add(LanguageKey item) {
    _items.add(item);
    notifyListeners();
  }
}
