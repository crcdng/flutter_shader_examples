import 'dart:ui';

import 'package:flutter/material.dart';

class SolidShader extends StatefulWidget {
  const SolidShader({super.key, required this.assetKey});
  final String assetKey;

  @override
  State<SolidShader> createState() => _SolidShaderState();
}

class _SolidShaderState extends State<SolidShader> {
  late FragmentShader _shader;

  Future<FragmentShader> _load() async {
    FragmentProgram program = await FragmentProgram.fromAsset(widget.assetKey);
    _shader = program.fragmentShader();
    return _shader;
  }

  @override
  void dispose() {
    _shader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solid Color Shader'),
      ),
      body: FutureBuilder(
          future: _load(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final shader = snapshot.data!;
              return CustomPaint(
                size: MediaQuery.sizeOf(context),
                painter: SolidShaderPainter(shader: shader),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

class SolidShaderPainter extends CustomPainter {
  SolidShaderPainter({required this.shader}); // 6
  final FragmentShader shader;

  @override
  void paint(Canvas canvas, Size size) {
    // All uniforms defined in a fragment shader that are not samplers must be set through this method. This includes floats and vec2, vec3, and vec4. The correct index for each uniform is determined by the order of the uniforms as defined in the fragment program, ignoring any samplers. For data types that are composed of multiple floats such as a vec4, more than one call to [setFloat] is required.

    Color color = Colors.lime;

    // color values are normalized from 0.0 to 1.0 and have premultiplied alpha
    shader.setFloat(0, color.r * color.a); // uColor r
    shader.setFloat(1, color.g * color.a); // uColor g
    shader.setFloat(2, color.b * color.a); // uColor b
    shader.setFloat(3, color.a);

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
