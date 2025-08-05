import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class StarsShader extends StatefulWidget {
  const StarsShader({super.key, required this.assetKey});
  final String assetKey;

  @override
  State<StarsShader> createState() => _StarsShaderState();
}

class _StarsShaderState extends State<StarsShader>
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
    var mouseX = 0.0;
    var mouseY = 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stars'),
      ),
      body: FutureBuilder(
          future: _load(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              final FragmentShader shader = snapshot.data! as FragmentShader;
              shader
                ..setFloat(0, MediaQuery.of(context).size.width)
                ..setFloat(1, MediaQuery.of(context).size.height);
              return MouseRegion(
                cursor: SystemMouseCursors.basic,
                onHover: (event) {
                  mouseX = event.position.dx;
                  mouseY = event.position.dy;
                },
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, _) {
                    shader
                      ..setFloat(2, _elapsedTimeInSeconds)
                      ..setFloat(3, mouseX)
                      ..setFloat(4, mouseY);
                    return CustomPaint(
                      size: MediaQuery.sizeOf(context),
                      painter: StarsShaderPainter(shader: shader),
                    );
                  },
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

class StarsShaderPainter extends CustomPainter {
  StarsShaderPainter({required this.shader}); // 6
  final FragmentShader shader;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..shader = shader;
    canvas
      ..translate(size.width, 0)
      ..scale(-1, 1)
      ..drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        paint,
      );
  }

  @override
  bool shouldRepaint(
    StarsShaderPainter oldDelegate,
  ) =>
      oldDelegate != this;
}
