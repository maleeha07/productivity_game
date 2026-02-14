import 'package:flutter/material.dart';
import 'package:productivity_tracker/user_data/user_data.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserDataNotifier>();
    final tasks = userProvider.tasks();

    int completedTasks =
        tasks.where((t) => t.completed == true).length;
    int totalTasks = tasks.length;
    double progress = totalTasks == 0 ? 0 : completedTasks / totalTasks;

    // Gifts
    List<String> gifts = [
      "🎁 Coffee Break",
      "🎉 Snack Time",
      "🍫 Chocolate",
      "📺 Netflix Hour",
      "🏞️ Go for a Walk",
      "🍔 Favorite Meal",
    ];
    int giftsUnlocked = userProvider.coins ~/ 100;
    List<String> unlockedGifts =
        gifts.sublist(0, giftsUnlocked.clamp(0, gifts.length));

    return Scaffold(
      appBar: AppBar(
        title: Text("${userProvider.name}'s Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statCard("Coins", "${userProvider.coins}", Colors.amber),
                _statCard("XP", "${userProvider.xp}", Colors.green),
                _statCard("Level", "${userProvider.level}", Colors.blue),
              ],
            ),
            const SizedBox(height: 30),
            // Tasks Progress
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Task Progress",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 20,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.blue.shade400,
                ),
                const SizedBox(height: 8),
                Text("$completedTasks / $totalTasks completed"),
              ],
            ),
            const SizedBox(height: 30),
            // Gifts
            const Text("Unlocked Gifts",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            unlockedGifts.isEmpty
                ? const Text("No gifts unlocked yet 😢")
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                      itemCount: unlockedGifts.length,
                      itemBuilder: (_, index) {
                        return Card(
                          color: Colors.purple.shade100,
                          child: Center(
                              child: Text(
                            unlockedGifts[index],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: 90,
        height: 90,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text(title, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

