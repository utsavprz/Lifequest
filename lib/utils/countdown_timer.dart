import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime endTime;

  const CountdownTimer({Key? key, required this.endTime}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime requestedDate = widget.endTime;
    Duration difference = requestedDate.difference(now);
    print(difference);

    return SlideCountdown(
      duration: difference,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 214, 1, 51),
          borderRadius: BorderRadius.circular(10)),
      separatorType: SeparatorType.title,
      slideDirection: SlideDirection.up,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 35,
        fontFamily: 'Raleway Bold',
        // fontWeight: FontWeight.bold,
      ),
      separatorStyle: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 16,
        fontFamily: 'Raleway SemiBold',
        // fontWeight: FontWeight.bold,
      ),
    );
  }
}
