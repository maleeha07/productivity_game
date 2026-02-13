import 'package:flutter/material.dart';
import 'package:productivity_tracker/user_data/user_data.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    int unlockedGifts = UserData.coins ~/ 100;

    List<String> gifts = [
      "🎧 Headphones",
      "📚 New Book",
      "🍕 Free Treat",
      "🎮 Game Time",
      "☕ Coffee Break",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Rewards")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Total Coins: ${UserData.coins} 🪙",
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: gifts.length,
                itemBuilder: (context, index) {
                  bool unlocked = index < unlockedGifts;

                  return Card(
                    color: unlocked ? Colors.green[100] : Colors.grey[300],
                    child: ListTile(
                      leading: Icon(
                        unlocked ? Icons.card_giftcard : Icons.lock,
                      ),
                      title: Text(gifts[index]),
                      subtitle: Text(
                        unlocked
                            ? "Unlocked 🎉"
                            : "Locked (Earn ${100 * (index + 1)} coins)",
                      ),
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