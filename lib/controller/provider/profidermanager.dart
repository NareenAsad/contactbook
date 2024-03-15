import 'package:flutter/material.dart';

class NumberProvider with ChangeNotifier {
  List<Map<String, String>> _numbers = [];
  List<Map<String, String>> _favorites = [];
  List<Map<String, String>> _initialContacts = [
    {'name': 'Mama', 'number': '123456789', 'organization': 'H'},
    {'name': 'Papa', 'number': '987654321', 'organization': 'H'},
    {'name': 'Adeena', 'number': '456123789', 'organization': 'Lcwu'},
    {'name': 'Aimen', 'number': '789456123', 'organization': 'Gulberg'},
    {'name': 'Nareen Asad', 'number': '135724689', 'organization': 'H'},
    {'name': 'Aimen Bashir', 'number': '246813579', 'organization': 'Lcwu'},
    {'name': 'Aisha Rani', 'number': '568912347', 'organization': 'Kips'},
  ];

  String _name = '';
  String _number = '';
  String _organization = '';

  List<Map<String, String>> get numbers => _numbers;
  List<Map<String, String>> get favorites => _favorites;
  List<Map<String, String>> get initialContacts => _initialContacts;

  List<Map<String, String>> get allContacts =>
      [..._initialContacts, ..._numbers];

  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get number => _number;
  set number(String value) {
    _number = value;
    notifyListeners();
  }

  String get organization => _organization;
  set organization(String value) {
    _organization = value;
    notifyListeners();
  }

  void loadNumbers(BuildContext context) {
    _numbers = _initialContacts.toList();
    notifyListeners();
  }

  void saveNumber(String name, String number, String organization) {
    final newNumber = {
      'name': name,
      'number': number,
      'organization': organization,
    };
    _numbers.add(newNumber); // Adding the new contact to _numbers
    notifyListeners();
  }

  bool isFavorite(Map<String, String> contact) {
    return _favorites.contains(contact);
  }

  bool isSaved(Map<String, String> contact) {
    return _numbers.contains(contact) || _initialContacts.contains(contact);
  }

  void toggleFavorite(Map<String, String> contact) {
    if (isFavorite(contact)) {
      removeFromFavorites(contact);
    } else {
      addToFavorites(contact);
    }
  }

  void addToFavorites(Map<String, String> contact) {
    if (!isFavorite(contact)) {
      _favorites.add(contact);
      notifyListeners();
    }
  }

  void removeFromFavorites(Map<String, String> contact) {
    _favorites.remove(contact);
    notifyListeners();
  }

  void removeNumber(Map<String, String> contact) {
    _numbers.remove(contact);
    _favorites.remove(contact);
    notifyListeners();
  }
}
