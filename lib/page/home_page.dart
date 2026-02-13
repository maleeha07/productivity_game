import 'package:flutter/material.dart';
import 'goals_page.dart';
import 'timer_page.dart';
import 'rewards_page.dart';
import 'feeling_down_page.dart';

class HomePage extends StatelessWidget {
  final String name;

  const HomePage({super.key, required this.name, required String age});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome $name 👋"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            buildMenuItem(context, Icons.flag, "Goals", const GoalsPage()),
            buildMenuItem(context, Icons.timer, "lock in", const TimerPage()),
            buildMenuItem(context, Icons.card_giftcard, "Rewards", const RewardsPage()),
            buildMenuItem(context, Icons.favorite, "Feeling Down?", const FeelingDownPage()),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}