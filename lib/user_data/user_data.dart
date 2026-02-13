// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static String name = "";
  static int age = 0;
  static int coins = 0;
  static int xp = 0;
  static int level = 1;

  // ------------------------
  // Load saved data from shared_preferences
  // ------------------------
  static Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? "";
    age = prefs.getInt('age') ?? 0;
    coins = prefs.getInt('coins') ?? 0;
    xp = prefs.getInt('xp') ?? 0;
    level = prefs.getInt('level') ?? 1;
  }

  // ------------------------
  // Save all current data to shared_preferences
  // ------------------------
  static Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setInt('age', age);
    await prefs.setInt('coins', coins);
    await prefs.setInt('xp', xp);
    await prefs.setInt('level', level);
  }

  // ------------------------
  // Set user name and age
  // ------------------------
  static Future<void> setUser(String userName, int userAge) async {
    name = userName;
    age = userAge;
    await saveData();
  }

  // ------------------------
  // Add coins
  // ------------------------
  static Future<void> addCoins(int amount) async {
    coins += amount;
    await saveData();
  }

  // ------------------------
  // Remove coins
  // ------------------------
  static Future<void> removeCoins(int amount) async {
    coins -= amount;
    if (coins < 0) coins = 0;
    await saveData();
  }

  // ------------------------
  // Add XP
  // ------------------------
  static Future<void> addXP(int amount) async {
    xp += amount;
    level = (xp ~/ 100) + 1; // 100 XP per level
    await saveData();
  }
}