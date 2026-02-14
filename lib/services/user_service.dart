import 'package:hive/hive.dart';
import '../models/user_model.dart';

class UserService {
  static final Box _userBox = Hive.box('users');
  static String? currentUserName;

  static Future<void> saveUser(UserModel user) async {
    await _userBox.put(user.name, user.toMap());
  }

  static UserModel? loadUser(String name) {
    final data = _userBox.get(name);
    if (data != null) {
      currentUserName = name;
      return UserModel.fromMap(Map<String, dynamic>.from(data));
    }
    return null;
  }

  static List<UserModel> getAllUsers() {
    return _userBox.values
        .map((e) => UserModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<void> deleteUser(String name) async {
    await _userBox.delete(name);
  }

  static UserModel? getCurrentUser() {
    if (currentUserName == null) return null;
    return loadUser(currentUserName!);
  }
}