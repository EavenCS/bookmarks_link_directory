import 'package:flutter/material.dart';

Widget addBookmarkTextField(String title, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: const TextStyle(fontFamily: "SpaceGrotesk", fontSize: 16),
          filled: true,
          fillColor: Colors.white54,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 1),
          ),
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}
