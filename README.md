# Flutter Shaders

I collected a few examples for shaders in Flutter. Most code is written by others and rewritten / updated by me. Original sources are referenced below. Some examples below show the same shader on [Flutter](https://flutter.dev/) and on the [Flame engine](https://flame-engine.org/).

![examples](assets/github/collage.png)

- solid: solid color
- gradient: color gradient, FlutterFragCoord().xy
- laser: dynamic, converted from https://www.shadertoy.com/view/4f2GRR 
- water: https://www.shadertoy.com/view/Ms2SD1, adapted from https://github.com/wolfenrain/flutter_shaders_example/ (Performance problems)
- jam: https://www.shadertoy.com/view/ldfSW2, adapted from https://github.com/wolfenrain/flutter_shaders_example/ 
- stars: mouse, https://www.shadertoy.com/view/XlfGRj, adapted from https://github.com/wolfenrain/flutter_shaders_example/ (Performance problems, wrong direction)
- stars_flame: flame engine, mouse, https://www.shadertoy.com/view/XlfGRj (Performance problems)
- mario_flame: flame engine https://www.shadertoy.com/view/XtlSD7 
- snow: Timer, flutter_shaders, texture sampler, https://www.shadertoy.com/view/XlSBz1, adapted from https://github.com/wolfenrain/flutter_shaders_example/ (Performance problems)
- glitch: flutter_shaders, texture sampler (the whole interactive app window is glitched), adapted from https://github.com/wolfenrain/flutter_shaders_example/
- pixelate: flutter_shaders, texture sampler from https://github.com/jonahwilliams/flutter_shaders/
- lava:_flame flame engine, [Hexler KodeLife](https://hexler.net/kodelife) start example

To run the repo, first add a platform, e.g. `flutter create --platforms=macos .` , then `flutter run`

## open issues

* Rewrite snow, which does not need an Animated Sampler 
* tested on macOs only, needs tests on windows / mobile / web

## resources

https://blog.codemagic.io/shady-flutter/    
https://github.com/wolfenrain/flutter_shaders_example     

https://pub.dev/packages/flutter_shaders for helpers and texture samplers    

https://docs.flutter.dev/ui/design/graphics/fragment-shaders    
https://github.com/flutter/engine/blob/main/impeller/docs/shader_optimization.md     