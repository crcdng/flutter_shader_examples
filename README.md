# Flutter Shaders

a few examples for shaders in Flutter

- solid: solid color
- gradient: color gradient, FlutterFragCoord().xy
- laser: dynamic, converted from https://www.shadertoy.com/view/4f2GRR 
- water: https://www.shadertoy.com/view/Ms2SD1 (Performance problems)
- jam: https://www.shadertoy.com/view/ldfSW2 
- stars: mouse, https://www.shadertoy.com/view/XlfGRj (Performance problems, wrong direction)
- stars_flame: flame engine, mouse, https://www.shadertoy.com/view/XlfGRj (Performance problems)
- mario_flame: flame engine https://www.shadertoy.com/view/XtlSD7 
- snow: Timer, flutter_shaders, texture sampler, https://www.shadertoy.com/view/XlSBz1 (Performance problems)
- glitch: flutter_shaders, texture sampler (the whole Scaffold is glitched), https://github.com/wolfenrain/flutter_shaders_example/blob/main/shaders/glitch.glsl 
- pixelate: flutter_shaders, texture sampler from https://github.com/jonahwilliams/flutter_shaders/
- lava:_flame flame engine, KodeLife start example

## questions

* MediaQuery.of(context).devicePixelRatio outside of flutter_shaders / AnimatedSampler? There, image size needs to be divided by it
* snow does not need an Animated Sampler / a texture sampler 

## sources

https://blog.codemagic.io/shady-flutter/    
https://github.com/wolfenrain/flutter_shaders_example     

https://pub.dev/packages/flutter_shaders for helpers and texture samplers    

https://docs.flutter.dev/ui/design/graphics/fragment-shaders    
https://github.com/flutter/engine/blob/main/impeller/docs/shader_optimization.md     