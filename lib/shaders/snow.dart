import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class SnowShader extends StatefulWidget {
  const SnowShader({super.key, required this.assetKey});
  final String assetKey;

  @override
  State<SnowShader> createState() => _SnowShaderState();
}

class _SnowShaderState extends State<SnowShader> {
  double time = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        time += 0.016;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snow'),
      ),
      body: ShaderBuilder(
        assetKey: widget.assetKey,
        (context, shader, child) {
          return AnimatedSampler(
            (image, size, canvas) {
              final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
              shader
                ..setFloat(0, image.width.toDouble() / devicePixelRatio)
                ..setFloat(1, image.height.toDouble() / devicePixelRatio)
                ..setFloat(2, time)
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
        child: SizedBox.expand(
            child: Container(
          color: const Color.fromARGB(255, 2, 106, 40),
        )),
      ),
    );
  }
}
