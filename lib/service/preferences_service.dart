import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _keyName = 'listOfFavorites';

  Future setMealId(List<String> mealIList) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(_keyName, mealIList);
  }

  Future<bool> isFavorite(String id) async {
    final preferences = await SharedPreferences.getInstance();
    final idList = preferences.getStringList(_keyName) ?? [];
    if (idList.contains(id)) {
      return true;
    }
    return false;
  }

  Future<void> deleteMealId(String id) async {
    final preferences = await SharedPreferences.getInstance();
    final idList = preferences.getStringList(_keyName) ?? [];
    if (idList.contains(id)) {
      idList.remove(id);
      preferences.setStringList(_keyName, idList);
    }
  }

  Future<void> toggleFavorite(String id) async {
    final isCurrentlyFavorite = await isFavorite(id);
    if (isCurrentlyFavorite) {
      await deleteMealId(id);
    } else {
      await addMealId(id);
    }
  }

  Future addMealId(String id) async {
    final preferences = await SharedPreferences.getInstance();
    final idList = preferences.getStringList(_keyName) ?? [];
    if (idList.contains(id)) {
      return;
    }
    idList.add(id);
    preferences.setStringList(_keyName, idList);
  }

  Future<List<String>?> getMealIds() async {
    final preferences = await SharedPreferences.getInstance();
    final idList = preferences.getStringList(_keyName);
    return idList;
  }

  void deleteAllMeal() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
