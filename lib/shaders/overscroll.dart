import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:flutter/scheduler.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class OverscrollShader extends StatelessWidget {
  const OverscrollShader({super.key, required this.assetKey});
  final String assetKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Overscroll - drag down')),
      body: ApplyShader(
        assetKey: assetKey,
        child: Center(
          child: SizedBox(
            width: 900,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                // overscroll: false,
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: ListView.builder(
                physics: const ClampingScrollPhysics(
                  parent: RangeMaintainingScrollPhysics(),
                ),
                addRepaintBoundaries: false,
                itemCount: 10000,
                cacheExtent: 10000,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return const Title(
                      child: Text('Overscroll'),
                    );
                  }

                  return SomeOsloPhoto(
                    key: ValueKey(index),
                    index: index,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ApplyShader extends StatefulWidget {
  const ApplyShader({
    super.key,
    required this.assetKey,
    required this.child,
  });

  final String assetKey;
  final Widget child;

  @override
  State<ApplyShader> createState() => _ApplyShaderState();
}

class _ApplyShaderState extends State<ApplyShader>
    with SingleTickerProviderStateMixin {
  var delta = 0.0;
  var viewportDimension = 0.0;

  late Ticker _ticker;

  @override
  void initState() {
    super.initState();

    _ticker = createTicker((elapsed) {
      setState(() {});
    })
      ..start();
    activate();
  }

  @override
  void dispose() {
    deactivate(); // NOTE ERROR empty method does not dispose of the ticker
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        viewportDimension = notification.metrics.viewportDimension;
        if (notification is OverscrollNotification) {
          delta += notification.overscroll;
        } else if (notification is ScrollEndNotification ||
            notification is ScrollUpdateNotification) {
          delta = 0.0;
        }

        return false;
      },
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: delta),
        duration:
            delta == 0.0 ? const Duration(milliseconds: 300) : Duration.zero,
        builder: (context, delta, _) {
          return ShaderBuilder(
            assetKey: widget.assetKey,
            (BuildContext context, ui.FragmentShader shader, Widget? child) {
              final overscrollAmount = delta.abs() / viewportDimension;

              return AnimatedSampler(
                  enabled: overscrollAmount > 0.0,
                  child: child!, (ui.Image image, Size size, ui.Canvas canvas) {
                shader
                  ..setFloat(0, size.width)
                  ..setFloat(1, size.height)
                  ..setFloat(2, overscrollAmount.clamp(0.0, 0.95))
                  ..setImageSampler(0, image);

                canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
              });
            },
            child: widget.child,
          );
        },
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return DefaultTextStyle.merge(
      style: theme.displayLarge!.merge(
        const TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.w900,
          color: Color(0xFF000000),
          letterSpacing: 1,
          height: 0.9,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: child,
      ),
    );
  }
}

class SomeOsloPhoto extends StatelessWidget {
  const SomeOsloPhoto({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Image.asset(
        'assets/images/oslo${index % 8}.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
