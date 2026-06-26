import 'package:freezed_annotation/freezed_annotation.dart';
import 'product.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState.loading() = _Loading;

  const factory GameState.error(String message) = _Error;

  const factory GameState.playing({
    required Product visibleProduct,
    required Product targetProduct,
    required int score,
    required List<Product> remainingProducts,
  }) = _Playing;

  const factory GameState.gameOver({
    required int finalScore,
  }) = _GameOver;
}