import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class PixelateShader extends StatefulWidget {
  const PixelateShader({super.key, required this.assetKey});
  final String assetKey;

  @override
  State<PixelateShader> createState() => _PixelateShaderState();
}

class _PixelateShaderState extends State<PixelateShader> {
  int pixelsX = 50;
  int pixelsY = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixelate'),
      ),
      body: ShaderBuilder(
        assetKey: widget.assetKey,
        (context, shader, child) {
          return AnimatedSampler(
            (image, size, canvas) {
              final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
              shader
                ..setFloat(0, pixelsX.toDouble())
                ..setFloat(1, pixelsY.toDouble())
                ..setFloat(2, image.width.toDouble() / devicePixelRatio)
                ..setFloat(3, image.height.toDouble() / devicePixelRatio)
                ..setImageSampler(0, image);

              canvas
                ..save()
                ..drawRect(
                  Offset.zero & size,
                  // Rect.fromLTWH(0, 0, size.width, size.height),
                  Paint()..shader = shader,
                )
                ..restore();
            },
            child: child!,
          );
        },
        child: const Image(image: AssetImage('assets/images/bbtor.jpg')),
      ),
    );
  }
}
