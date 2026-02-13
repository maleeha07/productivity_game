import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>
    with WidgetsBindingObserver {

  int seconds = 1500; // 25 minutes
  int coins = 100; // starting coins
  Timer? timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    super.dispose();
  }

  // Detect app state changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && isRunning) {
      // User left app while timer running
      timer?.cancel();
      setState(() {
        isRunning = false;
        coins -= 10; // minus coins
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Are you distracted? 👀"),
          content: const Text(
              "You left the app during focus time.\n10 coins deducted."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("I’ll focus now"),
            ),
          ],
        ),
      );
    }
  }

  void startTimer() {
    if (isRunning) return;

    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          isRunning = false;
          coins += 20; // reward coins
        });
      }
    });
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      seconds = 1500;
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    return Scaffold(
      appBar: AppBar(title: const Text("Focus Timer")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "$minutes:${remainingSeconds.toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 48),
            ),
          ),
          const SizedBox(height: 20),
          Text("Coins: $coins", style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: startTimer,
            child: const Text("Start"),
          ),
          ElevatedButton(
            onPressed: resetTimer,
            child: const Text("Reset"),
          ),
        ],
      ),
    );
  }
}