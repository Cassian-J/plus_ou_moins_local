import 'package:flutter/material.dart';

import '../controllers/game_controller.dart';
import '../models/game_state.dart';
import 'error_page.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GameController controller = GameController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await controller.startGame();
      setState(() {});
    });
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = controller.state;

    return Scaffold(
      appBar: AppBar(title: const Text("Plus ou Moins")),

      body: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (message) => ErrorPage(
          message: message,
          onRetry: () async {
            await controller.startGame();
            setState(() {});
          },
        ),

        playing: (visibleProduct, targetProduct, score, remainingProducts) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Score : $score",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Image.network(
                          visibleProduct.images.first,
                          height: 120,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          visibleProduct.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${visibleProduct.price} €",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Plus ou moins cher ?",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                Card(
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Image.network(
                          targetProduct.images.first,
                          height: 120,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          targetProduct.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        const Text("❓ Prix caché"),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.guessHigher();
                        setState(() {});
                      },
                      child: const Text("PLUS CHER"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.guessLower();
                        setState(() {});
                      },
                      child: const Text("MOINS CHER"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },

        gameOver: (finalScore) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Game Over",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text("Score final : $finalScore"),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  controller.restart();
                  await controller.startGame();
                  setState(() {});
                },
                child: const Text("Rejouer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}