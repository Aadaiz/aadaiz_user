import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {

  final bool isPast;
  final Widget child;

  const EventCard({super.key, required this.isPast, required this.child});

  @override
  Widget build(BuildContext context) {

    return Container(
        margin: const EdgeInsets.all(25),
        child: child
    );

  }

}