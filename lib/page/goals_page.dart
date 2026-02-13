import 'package:flutter/material.dart';
import 'dart:math';
import '../user_data.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final TextEditingController goalController = TextEditingController();

  List<Map<String, dynamic>> goals = [];

  final List<String> rewardMessages = [
    "You did an amazing job today! You truly deserve a relaxing break. 🌿",
    "All tasks completed! Enjoy your favorite snacks guilt-free. 🍫",
    "Everything is done! Time for Netflix and chill. 🎬",
    "Great discipline today! Go out and spend time with your friends. 🎉",
    "Outstanding focus! Treat yourself to your favorite meal. 🍕",
    "Hard work pays off. Take a peaceful one-hour break. ☕",
    "You showed real commitment today. Be proud of yourself! 🏆",
  ];

  void addGoal() {
    if (goalController.text.trim().isNotEmpty) {
      setState(() {
        goals.add({
          "title": goalController.text.trim(),
          "completed": false,
        });
        goalController.clear();
      });
    }
  }

  void toggleGoal(int index, bool? value) {
    setState(() {
      if (value == true && goals[index]["completed"] == false) {
        UserData.coins += 10; // Global coins update
      }
      goals[index]["completed"] = value;
    });

    checkAllCompleted();
  }

  void checkAllCompleted() {
    if (goals.isNotEmpty &&
        goals.every((goal) => goal["completed"] == true)) {
      final random = Random();
      String message =
          rewardMessages[random.nextInt(rewardMessages.length)];

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: const Text(
            "🎉 All Tasks Completed!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Thank you 💙"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Your Goals"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // Coins Display
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.amber[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.monetization_on,
                      color: Colors.orange),
                  const SizedBox(width: 10),
                  Text(
                    "Coins: ${UserData.coins} 🪙",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Goal Input
            TextField(
              controller: goalController,
              decoration: InputDecoration(
                labelText: "Enter a goal",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: addGoal,
              child: const Text("Add Goal"),
            ),

            const SizedBox(height: 20),

            // Goals List
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15)),
                    elevation: 3,
                    child: CheckboxListTile(
                      title: Text(
                        goals[index]["title"],
                        style: TextStyle(
                          decoration:
                              goals[index]["completed"]
                                  ? TextDecoration.lineThrough
                                  : null,
                        ),
                      ),
                      value: goals[index]["completed"],
                      onChanged: (value) {
                        toggleGoal(index, value);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}