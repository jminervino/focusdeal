import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CalendarHorizontal extends StatefulWidget {
  const CalendarHorizontal({super.key});

  @override
  State<CalendarHorizontal> createState() => _CalendarHorizontalState();
}

class _CalendarHorizontalState extends State<CalendarHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          
        },
      ),
    );
  }
}
