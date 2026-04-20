import 'package:flutter/material.dart';

class ActivityTooltip extends StatelessWidget {
  final DateTime date;
  final int count;

  const ActivityTooltip({
    Key? key,
    required this.date,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "${date.toString().split(' ')[0]}\n$count activities",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
