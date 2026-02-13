import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class FeelingDownPage extends StatefulWidget {
  const FeelingDownPage({super.key});

  @override
  State<FeelingDownPage> createState() => _FeelingDownPageState();
}

class _FeelingDownPageState extends State<FeelingDownPage> {
  final List<Map<String, String>> quotes = [
    {
      "quote":
          "If you want something you’ve never had, you must be willing to do something you’ve never done.",
      "author": "Thomas Jefferson"
    },
    {
      "quote": "Now or never. Because later becomes never.",
      "author": "Unknown"
    },
    {
      "quote": "Regret doesn’t taste good. Discipline does.",
      "author": "Focus Mindset"
    },
    {
      "quote": "Be thirsty for success. Stay hungry for growth.",
      "author": "Unknown"
    },
    {
      "quote":
          "How do you want your family to be in 10 years? Start building that future today.",
      "author": "Life Reminder"
    },
    {
      "quote": "You are not tired. You are distracted.",
      "author": "Focus Reminder"
    },
  ];

  final List<Color> backgrounds = [
    Colors.blue.shade200,
    Colors.purple.shade200,
    Colors.orange.shade200,
    Colors.green.shade200,
    Colors.pink.shade200,
    Colors.teal.shade200,
  ];

  int quoteOfDayIndex = 0;
  int currentBackgroundIndex = 0;

  Set<int> favoriteQuotes = {};

  @override
  void initState() {
    super.initState();
    generateQuoteOfDay();
    startBackgroundTimer();
  }

  void generateQuoteOfDay() {
    final random = Random();
    quoteOfDayIndex = random.nextInt(quotes.length);
  }

  void startBackgroundTimer() {
    Timer.periodic(const Duration(minutes: 12), (timer) {
      setState(() {
        currentBackgroundIndex =
            (currentBackgroundIndex + 1) % backgrounds.length;
      });
    });
  }

  void toggleFavorite(int index) {
    setState(() {
      if (favoriteQuotes.contains(index)) {
        favoriteQuotes.remove(index);
      } else {
        favoriteQuotes.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgrounds[currentBackgroundIndex],
      appBar: AppBar(
        title: const Text("Feeling Down?"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🌟 Quote of the Day
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "🌟 Quote of the Day",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "\"${quotes[quoteOfDayIndex]["quote"]}\"",
                      style: const TextStyle(
                          fontSize: 16, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "- ${quotes[quoteOfDayIndex]["author"]}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "All Quotes",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 4,
                    margin:
                        const EdgeInsets.only(bottom: 15),
                    child: ListTile(
                      title: Text(
                        "\"${quotes[index]["quote"]}\"",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic),
                      ),
                      subtitle: Text(
                          "- ${quotes[index]["author"]}"),
                      trailing: IconButton(
                        icon: Icon(
                          favoriteQuotes.contains(index)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favoriteQuotes.contains(index)
                              ? Colors.red
                              : null,
                        ),
                        onPressed: () =>
                            toggleFavorite(index),
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