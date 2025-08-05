import 'dart:ui';

import 'package:flutter/material.dart';

class LaserShader extends StatefulWidget {
  const LaserShader({super.key, required this.assetKey});
  final String assetKey;

  @override
  State<LaserShader> createState() => _LaserShaderState();
}

class _LaserShaderState extends State<LaserShader>
    with TickerProviderStateMixin {
  late FragmentShader _shader;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat();

  Future<FragmentShader> _load() async {
    FragmentProgram program = await FragmentProgram.fromAsset(widget.assetKey);
    _shader = program.fragmentShader();
    return _shader;
  }

  int _startTime = 0;
  double get _elapsedTimeInSeconds =>
      (_startTime - DateTime.now().millisecondsSinceEpoch) / 1000;

  @override
  void dispose() {
    _shader.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _startTime = DateTime.now().millisecondsSinceEpoch;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Laser'),
        ),
        body: FutureBuilder(
            future: _load(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                final FragmentShader shader = snapshot.data! as FragmentShader;
                shader
                  ..setFloat(0, MediaQuery.of(context).size.width)
                  ..setFloat(1, MediaQuery.of(context).size.height);
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, _) {
                    shader.setFloat(2, _elapsedTimeInSeconds);
                    return CustomPaint(
                      size: MediaQuery.sizeOf(context),
                      painter: LaserShaderPainter(shader: shader),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}

class LaserShaderPainter extends CustomPainter {
  LaserShaderPainter({required this.shader}); // 6
  final FragmentShader shader;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..shader = shader;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) =>
      oldDelegate != this;
}
