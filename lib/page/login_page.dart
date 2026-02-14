import 'package:flutter/material.dart';
import 'package:productivity_tracker/user_data/user_data.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  void login() async {
    String name = nameController.text.trim();
    int age = int.tryParse(ageController.text.trim()) ?? 0;
    if (name.isEmpty || age <= 0) return;

    UserModel? user = UserService.loadUser(name);
    if (user == null) {
      user = UserModel(name: name, age: age);
      await UserService.saveUser(user);
    }
    UserService.currentUserName = user.name;
    // ignore: use_build_context_synchronously
    context.read<UserDataNotifier>().updateUser(user);

    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Age"),
              ),
              const SizedBox(height: 40),
              ElevatedButton(onPressed: login, child: const Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}