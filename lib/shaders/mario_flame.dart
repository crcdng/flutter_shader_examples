import 'dart:async';
import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MarioFlameShader extends StatefulWidget {
  const MarioFlameShader({super.key, required this.assetKey});
  final String assetKey;

  @override
  State<MarioFlameShader> createState() => _MarioFlameShaderState();
}

class _MarioFlameShaderState extends State<MarioFlameShader> {
  late final MarioGame game;

  @override
  void initState() {
    game = MarioGame(shaderAssetKey: widget.assetKey);
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
          title: const Text('Mario with Flame Engine'),
        ),
        body: GameWidget(game: game));
  }
}

class MarioGame extends Game with MouseMovementDetector {
  late final String shaderAssetKey;

  MarioGame({required this.shaderAssetKey}) : super();
  late final FragmentShader shader;
  double time = 0;

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
  void render(Canvas canvas) {
    shader
      ..setFloat(0, size.x)
      ..setFloat(1, size.y)
      ..setFloat(2, time);

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
