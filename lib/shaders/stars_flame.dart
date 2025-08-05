import 'dart:async';
import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class StarsFlameShader extends StatefulWidget {
  const StarsFlameShader({super.key, required this.assetKey});
  final String assetKey;

  @override
  State<StarsFlameShader> createState() => _StarsFlameShaderState();
}

class _StarsFlameShaderState extends State<StarsFlameShader> {
  late final StarsGame game;

  @override
  void initState() {
    game = StarsGame(shaderAssetKey: widget.assetKey);
    super.initState();
  }

  @override
  void dispose() {
    game.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stars with Flame Engine'),
        ),
        body: GameWidget(game: game));
  }
}

class StarsGame extends Game with MouseMovementDetector {
  late final String shaderAssetKey;

  StarsGame({required this.shaderAssetKey}) : super();
  late final FragmentShader shader;
  double time = 0;
  Vector2 mousePosition = Vector2.zero();

  @override
  FutureOr<void> onLoad() async {
    shader = await FragmentProgram.fromAsset(shaderAssetKey)
        .then((value) => value.fragmentShader());
  }

  @override
  onRemove() {
    shader.dispose();
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    mousePosition.setFrom(info.eventPosition.widget);
    super.onMouseMove(info);
  }

  @override
  void render(Canvas canvas) {
    shader
      ..setFloat(0, size.x)
      ..setFloat(1, size.y)
      ..setFloat(2, time)
      ..setFloat(3, mousePosition.x)
      ..setFloat(3, mousePosition.y);
    canvas
      ..translate(size.x, size.y)
      ..rotate(180 * degrees2Radians)
      ..translate(size.x, 0)
      ..scale(-1, 1)
      ..drawRect(
        Offset.zero & size.toSize(),
        Paint()..shader = shader,
      );
  }

  @override
  void update(double dt) {
    time += dt;
  }
}
