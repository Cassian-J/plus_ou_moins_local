import 'dart:math';

import '../models/game_state.dart';
import '../models/product.dart';
import '../services/sources/api_product_source.dart';
import '../services/sources/local_product_source.dart';
import '../services/sources/product_source.dart';

class GameController {
  final ProductSource api = ApiProductSource();
  final ProductSource local = LocalProductSource();

  List<Product> _products = [];
  int _index = 0;
  int _score = 0;

  GameState state = const GameState.loading();

  Future<void> startGame() async {
    state = const GameState.loading();

    try {
      _products = await api.loadProducts();
    } catch (e) {
      _products = await local.loadProducts();
    }

    _products.shuffle(Random());

    _index = 0;
    _score = 0;

    state = GameState.playing(
      visibleProduct: _products[_index],
      targetProduct: _products[_index + 1],
      score: _score,
      remainingProducts: _products,
    );
  }

  void guessHigher() => _check(true);
  void guessLower() => _check(false);

  void _check(bool guessHigher) {
    final current = _products[_index];
    final next = _products[_index + 1];

    final isCorrect = guessHigher
        ? next.price > current.price
        : next.price < current.price;

    if (isCorrect) {
      _score++;
      _index++;

      if (_index + 1 >= _products.length) {
        state = GameState.gameOver(finalScore: _score);
        return;
      }

      state = GameState.playing(
        visibleProduct: _products[_index],
        targetProduct: _products[_index + 1],
        score: _score,
        remainingProducts: _products.sublist(_index),
      );
    } else {
      state = GameState.gameOver(finalScore: _score);
    }
  }

  void restart() {
    startGame();
  }
}