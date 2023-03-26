// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BloodGroupSelector extends StatefulWidget {
  Function(String) getBloodType;

  BloodGroupSelector({
    Key? key,
    required this.getBloodType,
  }) : super(key: key);

  @override
  State<BloodGroupSelector> createState() => _BloodGroupSelectorState();
}

class _BloodGroupSelectorState extends State<BloodGroupSelector> {
  String? selectedBloodGroup;
  final List _bloodGroup = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _bloodGroup.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedBloodGroup = '${_bloodGroup[index]}';
                  widget.getBloodType(selectedBloodGroup!);
                  debugPrint(selectedBloodGroup);
                });
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 15),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: selectedBloodGroup == _bloodGroup[index]
                        ? const Color.fromARGB(255, 161, 0, 0)
                        : Colors.white,
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(100))),
                child: Text(
                  '${_bloodGroup[index]}',
                  style: TextStyle(
                      fontFamily: 'Raleway SemiBold',
                      color: selectedBloodGroup == _bloodGroup[index]
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            );
          }),
        ));
  }
}
