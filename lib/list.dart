import 'package:flutter/material.dart';

import 'shaders/animated_gradient.dart';
import 'shaders/barrel_blur.dart';
import 'shaders/glitch.dart';
import 'shaders/gradient.dart';
import 'shaders/jam.dart';
import 'shaders/laser.dart';
import 'shaders/lava_lamp_flame.dart';
import 'shaders/mario_flame.dart';
import 'shaders/overscroll.dart';
import 'shaders/pixelate.dart';
import 'shaders/snow.dart';
import 'shaders/solid.dart';
import 'shaders/stars.dart';
import 'shaders/stars_flame.dart';
import 'shaders/water.dart';

class ShaderList extends StatelessWidget {
  const ShaderList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Solid Color'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<SolidShader>(
                  builder: (_) => const SolidShader(
                    assetKey: 'assets/shaders/solid.frag',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Gradient'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<GradientShader>(
                  builder: (_) => const GradientShader(
                    assetKey: 'assets/shaders/gradient.frag',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.animation),
            title: const Text('Animated Gradient / ShaderMask'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<AnimatedGradientShader>(
                  builder: (_) => const AnimatedGradientShader(),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.animation),
            title: const Text('Laser'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<LaserShader>(
                  builder: (_) => const LaserShader(
                    assetKey: 'assets/shaders/laser.frag',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.animation),
            title: const Text('Water'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<WaterShader>(
                  builder: (_) => const WaterShader(
                    assetKey: 'assets/shaders/water.frag',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.animation),
            title: const Text('Jam'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<JamShader>(
                  builder: (_) => const JamShader(
                    assetKey: 'assets/shaders/jam.glsl',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.animation),
            title: const Text('Stars'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<StarsShader>(
                  builder: (_) => const StarsShader(
                    assetKey: 'assets/shaders/stars.glsl',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.fireplace),
            title: const Text('Stars with Flame'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<StarsFlameShader>(
                  builder: (_) => const StarsFlameShader(
                    assetKey: 'assets/shaders/stars.glsl',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.fireplace),
            title: const Text('Mario with Flame'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<MarioFlameShader>(
                  builder: (_) => const MarioFlameShader(
                    assetKey: 'assets/shaders/mario.glsl',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.filter_frames),
            title: const Text('Snow'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<SnowShader>(
                  builder: (_) => const SnowShader(
                    assetKey: 'assets/shaders/snow.glsl',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.filter_frames),
            title: const Text('Glitch'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<GlitchShader>(
                  builder: (_) => const GlitchShader(
                    assetKey: 'assets/shaders/glitch.glsl',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.filter_frames),
            title: const Text('Pixelate'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<PixelateShader>(
                  builder: (_) => const PixelateShader(
                    assetKey: 'assets/shaders/pixelation.frag',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.fireplace),
            title: const Text('Lava Lamp with Flame'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<LavaLampFlameShader>(
                  builder: (_) => const LavaLampFlameShader(
                    assetKey: 'assets/shaders/lava.frag',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.filter_frames),
            title: const Text('Barrel Blur'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<BarrelBlurShader>(
                  builder: (_) => const BarrelBlurShader(
                    assetKey: 'assets/shaders/barrel_blur.glsl',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.filter_frames),
            title: const Text('Overscroll'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<OverscrollShader>(
                  builder: (_) => const OverscrollShader(
                    assetKey: 'assets/shaders/stretch.glsl',
                  ),
                ),
              );
            }),
      ],
    );
  }
}
