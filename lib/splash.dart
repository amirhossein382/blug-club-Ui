import 'package:bulg_club/gen/assets.gen.dart';
import 'package:bulg_club/onboarding.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => const Onboarding()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: Assets.img.background.splash.image(fit: BoxFit.cover),
        ),
        Center(
          child: Assets.img.icons.logo.svg(width: 120),
        )
      ]),
    );
  }
}
