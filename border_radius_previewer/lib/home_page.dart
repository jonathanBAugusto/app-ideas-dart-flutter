import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final baseWidth = ValueNotifier(300.0);
  final baseHeight = ValueNotifier(300.0);

  final sliderTop = ValueNotifier(0.5);
  final sliderBottom = ValueNotifier(0.5);
  final sliderLeft = ValueNotifier(0.5);
  final sliderRight = ValueNotifier(0.5);

  double get biggerThanBaseWidth => baseWidth.value + 64;
  double get biggerThanBaseHeight => baseHeight.value + 64;
  double get bitBiggerThanBaseWidth => baseWidth.value + 16;
  double get bitBiggerThanBaseHeight => baseHeight.value + 16;

  double get circleWidth => baseWidth.value - 32;
  double get circleHeight => baseWidth.value - 24;

  double get topLeftX => sliderTop.value;
  double get topRightX => 1 - sliderTop.value;
  double get bottomLeftX => sliderBottom.value;
  double get bottomRightX => 1 - sliderBottom.value;
  double get topLeftY => sliderLeft.value;
  double get bottomLeftY => 1 - sliderLeft.value;
  double get topRightY => sliderRight.value;
  double get bottomRightY => 1 - sliderRight.value;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        baseWidth,
        baseHeight,
        sliderTop,
        sliderBottom,
        sliderLeft,
        sliderRight,
      ]),
      builder: (_, __) => Scaffold(
        backgroundColor: Colors.blueAccent.shade700,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: biggerThanBaseWidth,
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: biggerThanBaseWidth,
                height: biggerThanBaseHeight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: circleWidth,
                      height: circleHeight,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.purple,
                            Colors.pink,
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(
                            circleWidth * topLeftX,
                            circleHeight * topLeftY,
                          ),
                          topRight: Radius.elliptical(
                            circleWidth * topRightX,
                            circleHeight * topRightY,
                          ),
                          bottomLeft: Radius.elliptical(
                            circleWidth * bottomLeftX,
                            circleHeight * bottomLeftY,
                          ),
                          bottomRight: Radius.elliptical(
                            circleWidth * bottomRightX,
                            circleHeight * bottomRightY,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -16,
                      child: SizedBox(
                        height: 64,
                        width: bitBiggerThanBaseWidth,
                        child: Slider(
                          value: sliderTop.value,
                          onChanged: (value) => sliderTop.value = value,
                          min: 0.0,
                          max: 1.0,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -16,
                      child: SizedBox(
                        height: 64,
                        width: bitBiggerThanBaseWidth,
                        child: Slider(
                          value: sliderBottom.value,
                          onChanged: (value) => sliderBottom.value = value,
                          min: 0.0,
                          max: 1.0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -16,
                      child: SizedBox(
                        height: bitBiggerThanBaseHeight,
                        width: 64,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Slider(
                            value: sliderLeft.value,
                            onChanged: (value) => sliderLeft.value = value,
                            min: 0.0,
                            max: 1.0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -16,
                      child: SizedBox(
                        height: bitBiggerThanBaseHeight,
                        width: 64,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Slider(
                            value: sliderRight.value,
                            onChanged: (value) => sliderRight.value = value,
                            min: 0.0,
                            max: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: biggerThanBaseWidth,
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
