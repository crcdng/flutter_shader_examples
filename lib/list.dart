import 'package:flutter/material.dart';
import 'shaders/shaders.dart';

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
                MaterialPageRoute(
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
                MaterialPageRoute(
                  builder: (_) => const GradientShader(
                    assetKey: 'assets/shaders/gradient.frag',
                  ),
                ),
              );
            }),
        ListTile(
            leading: const Icon(Icons.animation),
            title: const Text('Laser'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
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
                MaterialPageRoute(
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
                MaterialPageRoute(
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
                MaterialPageRoute(
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
                MaterialPageRoute(
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
                MaterialPageRoute(
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
                MaterialPageRoute(
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
                MaterialPageRoute(
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
                MaterialPageRoute(
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
                MaterialPageRoute(
                  builder: (_) => const LavaLampFlameShader(
                    assetKey: 'assets/shaders/lava.frag',
                  ),
                ),
              );
            })
      ],
    );
  }
}
