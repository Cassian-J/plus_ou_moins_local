import 'package:shared_preferences/shared_preferences.dart';

class ScoreService {
  static const String _keyBestScore = "best_score";

  /// Charger le meilleur score
  Future<int> getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyBestScore) ?? 0;
  }

  /// Sauvegarder si record battu
  Future<void> saveBestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();

    final currentBest = prefs.getInt(_keyBestScore) ?? 0;

    if (score > currentBest) {
      await prefs.setInt(_keyBestScore, score);
    }
  }
}