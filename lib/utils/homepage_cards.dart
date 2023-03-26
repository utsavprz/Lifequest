import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  final title;
  final subtitle;
  final icon;

  const HomePageCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 60,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                offset: Offset(4, 4),
                blurRadius: 10,
                color: Color.fromARGB(255, 198, 198, 198)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$title',
                  style: const TextStyle(
                      fontFamily: 'Raleway SemiBold', fontSize: 14),
                ),
                Text('$subtitle', style: const TextStyle(fontSize: 11))
              ],
            ),
            Icon(
              icon,
              color: Colors.red,
              size: 32,
            )
          ],
        ));
  }
}
