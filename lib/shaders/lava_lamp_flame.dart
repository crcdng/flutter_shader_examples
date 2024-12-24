import 'dart:async';
import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class LavaLampFlameShader extends StatefulWidget {
  const LavaLampFlameShader({super.key, required this.assetKey});
  final String assetKey;

  @override
  State<LavaLampFlameShader> createState() => _LavaLampFlameShaderState();
}

class _LavaLampFlameShaderState extends State<LavaLampFlameShader> {
  late final LavaGame game;

  @override
  void initState() {
    game = LavaGame(shaderAssetKey: widget.assetKey);
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
          title: const Text('Lava Lamp with Flame Engine'),
        ),
        body: GameWidget(game: game));
  }
}

class LavaGame extends Game with MouseMovementDetector {
  late final String shaderAssetKey;

  LavaGame({required this.shaderAssetKey}) : super();
  late final FragmentShader shader;
  double time = 0;

  @override
  FutureOr<void> onLoad() async {
    shader = await FragmentProgram.fromAsset(shaderAssetKey)
        .then((value) => value.fragmentShader());
  }

  @override
  void render(Canvas canvas) {
    shader
      ..setFloat(0, size.x)
      ..setFloat(1, size.y)
      ..setFloat(2, time);

    canvas.drawRect(
      Offset.zero & size.toSize(),
      Paint()..shader = shader,
    );
  }

  @override
  void update(double dt) {
    time += dt;
  }
}
