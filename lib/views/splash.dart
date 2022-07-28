import 'dart:async';
import 'dart:math';

import 'package:covid_tracker_app/views/world_stats.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        (() => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WorldStats()))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: ((context, Widget? child) {
                return Transform.rotate(
                    angle: animationController.value * 2 * pi, child: child);
              }),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 2,
                child: const Center(
                    child: Image(image: AssetImage('images/virus.png'))),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .001,
            ),
            const Align(
                alignment: Alignment.center,
                child: Text(
                  'Covid-19 \nTracker App',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
          ],
        ),
      ),
    );
  }
}
