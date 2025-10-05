import 'package:flutter/material.dart';

Widget cardWidget(List<Widget> children) {
  return Card(
    margin: const EdgeInsets.all(16),
    color: Colors.white,
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    ),
  );
}
