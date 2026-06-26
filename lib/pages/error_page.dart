import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorPage({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off,
              color: Colors.red,
              size: 80,
            ),

            const SizedBox(height: 20),

            Text(
              "Une erreur est survenue",
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 10),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text("Réessayer"),
            ),
          ],
        ),
      ),
    );
  }
}