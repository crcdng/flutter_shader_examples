import 'dart:ui';

import 'package:flutter/material.dart';

class GradientShader extends StatelessWidget {
  const GradientShader({super.key, required this.assetKey});
  final String assetKey;

  Future<FragmentShader> _load() async {
    FragmentProgram program = await FragmentProgram.fromAsset(assetKey);
    return program.fragmentShader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradient Shader'),
      ),
      body: FutureBuilder(
          future: _load(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final shader = snapshot.data!;
              return CustomPaint(
                size: MediaQuery.sizeOf(context),
                painter: ExampleShaderPainter(shader: shader),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

class ExampleShaderPainter extends CustomPainter {
  ExampleShaderPainter({required this.shader}); // 6
  final FragmentShader shader;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

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
      false;
}
