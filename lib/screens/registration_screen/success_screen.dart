import 'package:flutter/material.dart';
import 'package:lifequest/screens/home_main_screen.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  static const String route = 'SuccessScreen';

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _scaleAnimation;
  String? successMessage;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(_controller!);
    _controller!.forward();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeMainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    successMessage = ModalRoute.of(context)!.settings.arguments as String?;
    return AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) => Scaffold(
              body: Container(
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: _scaleAnimation!.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          size: 150, color: Colors.green),
                      const SizedBox(height: 5),
                      Text(successMessage!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'Raleway Bold',
                            color: Colors.green,
                          )),
                    ],
                  ),
                ),
              ),
            ));
  }
}
