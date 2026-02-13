import 'package:flutter/material.dart';
import 'package:productivity_tracker/user_data/user_data.dart';
import 'goals_page.dart';
import 'timer_page.dart';
import 'rewards_page.dart';
import 'feeling_down_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required String age, required String name});

  Widget buildButton(BuildContext context,
      IconData icon, String label, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            const SizedBox(height: 10),
            Text(label),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 160, 190, 255),
      appBar: AppBar(
        title: Text("Welcome ${UserData.name} 👋"),
      ),
      body: Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            buildButton(context, Icons.flag,
                "Goals", const GoalsPage()),
            buildButton(context, Icons.timer,
                "Timer", const TimerPage()),
            buildButton(context, Icons.card_giftcard,
                "Rewards", const RewardsPage()),
            buildButton(context, Icons.favorite,
                "Feeling Down", const FeelingDownPage()),
          ],
        ),
      ),
    );
  }
}