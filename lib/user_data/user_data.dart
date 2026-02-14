import 'package:flutter/material.dart';
import 'package:productivity_tracker/models/task_model.dart';
import 'package:productivity_tracker/models/user_model.dart';
import 'package:productivity_tracker/services/user_service.dart';

class UserDataNotifier extends ChangeNotifier {
  UserModel? user = UserService.getCurrentUser();

  void updateUser(UserModel updatedUser) {
    user = updatedUser;
    notifyListeners();
  }

  int get coins => user?.coins ?? 0;
  int get xp => user?.xp ?? 0;
  int get level => user?.level ?? 1;
  String get name => user?.name ?? "";
  int get age => user?.age ?? 0;
  List<Task> tasks() => user?.tasks ?? [];

  Future<void> addCoins(int amount) async {
    if (user == null) return;
    user!.coins += amount;
    await UserService.saveUser(user!);
    notifyListeners();
  }

  Future<void> addXP(int amount) async {
    if (user == null) return;
    user!.xp += amount;
    user!.level = (user!.xp ~/ 100) + 1;
    await UserService.saveUser(user!);
    notifyListeners();
  }

  Future<void> updateTasks(List<Task> updatedTasks) async {
    if (user == null) return;
    user!.tasks = updatedTasks;
    await UserService.saveUser(user!);
    notifyListeners();
  }
}