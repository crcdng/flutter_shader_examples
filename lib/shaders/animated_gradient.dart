import 'package:flutter/material.dart';

class AnimatedGradientShader extends StatefulWidget {
  const AnimatedGradientShader({super.key});

  @override
  State<AnimatedGradientShader> createState() => _AnimatedGradientShaderState();
}

class _AnimatedGradientShaderState extends State<AnimatedGradientShader>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.repeat();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Gradient / ShaderMask'),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Center(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
                  tileMode: TileMode.mirror,
                  transform: SlideGradient(
                      controller.value, MediaQuery.sizeOf(context).width),
                ).createShader(bounds);
              },
              child: const Text(
                "Burning the\nmidnight oil",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 100,
                    fontWeight: FontWeight.w900),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SlideGradient implements GradientTransform {
  final double value;
  final double offset;
  const SlideGradient(this.value, this.offset);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final dist = value * (bounds.width + offset);
    return Matrix4.identity()..translate(-dist);
  }
}
