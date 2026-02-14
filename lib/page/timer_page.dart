import 'dart:async';
import 'package:flutter/material.dart';
import 'package:productivity_tracker/user_data/user_data.dart';
import 'package:provider/provider.dart';
  class TimerPage extends StatefulWidget {
    const TimerPage({Key? key}) : super(key: key);

    @override
    State<TimerPage> createState() => _TimerPageState();
  }
  @override
  State<TimerPage> createState() => _TimerPageState();

class _TimerPageState extends State<TimerPage> with WidgetsBindingObserver {
  Timer? _timer;
  int _secondsLeft = 25 * 60; // default 25 min
  bool isRunning = false;

  String timerType = "Work";
  
  // Use provider for UserDataNotifier
  UserDataNotifier get userData => context.read<UserDataNotifier>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Detect if app goes to background while timer running
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && isRunning) {
      stopTimer(distracted: true);
    }
  }

  void startTimer(int seconds, String type) {
    if (isRunning) return;

    setState(() {
      _secondsLeft = seconds;
      timerType = type;
      isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 0) {
        timer.cancel();
        setState(() => isRunning = false);
        sessionCompleted();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void stopTimer({bool distracted = false}) async {
    _timer?.cancel();
    setState(() => isRunning = false);

    if (distracted) {
      await userData.addCoins(-10); // Deduct 10 coins
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Distracted!"),
          content: const Text(
              "You left during your focus session. 10 coins deducted."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  void sessionCompleted() async {
    if (timerType == "Work") {
      await userData.addCoins(10);
      await userData.addXP(20);
    }

    String message = timerType == "Work"
        ? "Work session complete! +10 coins, +20 XP."
        : "$timerType completed! Take a break.";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Session Complete"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  String formatTime(int seconds) {
    final min = seconds ~/ 60;
    final sec = seconds % 60;
    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }

  Future<int?> showCustomTimerDialog() async {
    final controller = TextEditingController();
    return showDialog<int>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Custom Timer (minutes)"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Enter minutes"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              Navigator.pop(context, value);
            },
            child: const Text("Start"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Focus Timer")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "$timerType Timer",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Text(
              formatTime(_secondsLeft),
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => startTimer(25 * 60, "Work"),
                  child: const Text("Work 25 min"),
                ),
                ElevatedButton(
                  onPressed: () => startTimer(5 * 60, "Short Break"),
                  child: const Text("Short Break 5 min"),
                ),
                ElevatedButton(
                  onPressed: () => startTimer(15 * 60, "Long Break"),
                  child: const Text("Long Break 15 min"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    int? mins = await showCustomTimerDialog();
                    if (mins != null) startTimer(mins * 60, "Custom");
                  },
                  child: const Text("Custom Timer"),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: isRunning ? () => stopTimer() : null,
              child: const Text("Stop Timer"),
            ),
          ],
        ),
      ),
    );
  }
}