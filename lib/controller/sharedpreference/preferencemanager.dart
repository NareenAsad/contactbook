import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NumberStorage {
  static const _keyNumbers = 'numbers';
  static const _keyFavorites = 'favorites';

  static Future<void> saveNumber(Map<String, String> number) async {
    final prefs = await SharedPreferences.getInstance();
    final numbersJson = prefs.getStringList(_keyNumbers) ?? [];
    numbersJson.add(jsonEncode(number));
    await prefs.setStringList(_keyNumbers, numbersJson);
  }

  static Future<void> addFavorite(Map<String, String> favorite) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_keyFavorites) ?? [];
    favoritesJson.add(jsonEncode(favorite));
    await prefs.setStringList(_keyFavorites, favoritesJson);
  }

  static Future<List<Map<String, String>>> getNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    final numbersJson = prefs.getStringList(_keyNumbers) ?? [];
    return numbersJson
        .map((json) => jsonDecode(json) as Map<String, String>)
        .toList();
  }

  static Future<List<Map<String, String>>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_keyFavorites) ?? [];
    return favoritesJson
        .map((json) => jsonDecode(json) as Map<String, String>)
        .toList();
  }

  static Future<void> removeFavorite(Map<String, String> favorite) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_keyFavorites) ?? [];
    favoritesJson.removeWhere((json) => json == jsonEncode(favorite));
    await prefs.setStringList(_keyFavorites, favoritesJson);
  }

  static void removeNumber(Map<String, String> contact) {}
}
