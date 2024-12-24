import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class GlitchShader extends StatefulWidget {
  const GlitchShader({super.key, required this.assetKey});
  final String assetKey;

  @override
  State<GlitchShader> createState() => _GlitchShaderState();
}

class _GlitchShaderState extends State<GlitchShader> {
  int count = 0; // for the glitched counter
  double shadertime = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      setState(() {
        shadertime += 0.016;
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
    return ShaderBuilder(
      assetKey: widget.assetKey,
      (context, shader, child) {
        return AnimatedSampler(
          (image, size, canvas) {
            final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
            shader
              ..setFloat(0, image.width.toDouble() / devicePixelRatio)
              ..setFloat(1, image.height.toDouble() / devicePixelRatio)
              ..setFloat(2, shadertime)
              ..setImageSampler(0, image);

            canvas
              ..save()
              // ..translate(offset.dx, offset.dy)
              ..drawRect(
                Offset.zero & size,
                Paint()..shader = shader,
              )
              ..restore();
          },
          child: child!,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Glitch'),
        ),
        body: Center(
          child: Text(
            '$count',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: Object(),
              onPressed: () => setState(() {
                count++;
              }),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              heroTag: Object(),
              onPressed: () => setState(() {
                count--;
              }),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
