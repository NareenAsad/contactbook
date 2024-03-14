import 'package:contact_book/controller/sharedpreference/preferencemanager.dart';
import 'package:flutter/material.dart';

class NumberProvider with ChangeNotifier {
  List<Map<String, String>> _numbers = [
    {'name': 'Mama', 'number': '123456789', 'org': ''},
    {'name': 'Papa', 'number': '987654321', 'org': ''},
    {'name': 'Adeena', 'number': '456123789', 'org': 'lcwu'},
    {'name': 'Aimen', 'number': '789456123', 'org': 'gulberg'},
    {'name': 'Nareen Asad', 'number': '135724689', 'org': ''},
  ];

  String _name = '';
  String _number = '';
  String _organization = '';

  List<Map<String, String>> get numbers => _numbers;
  List<Map<String, String>> _favorites = [];

  List<Map<String, String>> get favorites => _favorites;

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

  bool isFavorite(Map<String, String> contact) {
    return _favorites.contains(contact);
  }

  bool isSaved(Map<String, String> contact) {
    return _numbers.contains(contact);
  }

  Future<void> loadNumbers() async {
    final numbers = await NumberStorage.getNumbers();
    _numbers = numbers.map((num) => Map<String, String>.from(num)).toList();
    final favorites = await NumberStorage.getFavorites();
    _favorites = favorites.map((fav) => Map<String, String>.from(fav)).toList();
    notifyListeners();
  }

  Future<void> saveNumber(
      String name, String number, String organization) async {
    final newNumber = {
      'name': name,
      'number': number,
      'organization': organization
    };
    if (!isSaved(newNumber)) {
      _numbers.add(newNumber);
      await NumberStorage.saveNumber(newNumber);
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(Map<String, String> contact) async {
    if (isFavorite(contact)) {
      _favorites.remove(contact);
      await NumberStorage.removeFavorite(contact);
    } else {
      _favorites.add(contact);
      await NumberStorage.addFavorite(contact);
    }
    notifyListeners();
  }

  void addToFavorites(Map<String, String> contact) {
    if (!isFavorite(contact)) {
      _favorites.add(contact);
      NumberStorage.addFavorite(contact); // Add to storage as well
      notifyListeners();
    }
  }

  void removeFromFavorites(Map<String, String> contact) {
    _favorites.remove(contact);
    NumberStorage.removeFavorite(contact); // Remove from storage as well
    notifyListeners();
  }

  void removeNumber(Map<String, String> contact) {
    _numbers.remove(contact);
    NumberStorage.removeNumber(contact); // Remove from storage as well
    notifyListeners();
  }
}
