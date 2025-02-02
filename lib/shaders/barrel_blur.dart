import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:photo_view/photo_view.dart';

class BarrelBlurShader extends StatefulWidget {
  const BarrelBlurShader({super.key, required this.assetKey});
  final String assetKey;

  @override
  State<BarrelBlurShader> createState() => _BarrelBlurShaderState();
}

class _BarrelBlurShaderState extends State<BarrelBlurShader> {
  Image content = Image.asset('assets/images/oslo6.jpg');
  var sliderValue = 0.0;

  final min = 0.0;
  final max = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Barrel Blur')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          PhotoView.customChild(
            child: ShaderBuilder(
              assetKey: widget.assetKey,
              (BuildContext context, ui.FragmentShader shader, Widget? child) {
                return AnimatedSampler(
                  (image, size, canvas) {
                    shader
                      ..setFloat(0, size.width)
                      ..setFloat(1, size.height)
                      ..setFloat(2, sliderValue)
                      ..setImageSampler(0, image);
                    canvas.drawRect(
                        Offset.zero & size, Paint()..shader = shader);
                  },
                  child: content,
                );
              },
            ),
          ),
          Positioned(
            bottom: 10,
            left: 50,
            right: 50,
            child: Slider(
              value: sliderValue,
              min: min,
              max: max,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
