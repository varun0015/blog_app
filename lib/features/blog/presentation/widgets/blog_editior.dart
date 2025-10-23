import 'package:flutter/material.dart';

class BlogEditior extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;

  const BlogEditior({
    super.key,
    required this.textEditingController,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(hintText: hintText),
      maxLines: null,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '$hintText is missing';
        }
        return null;
      },
    );
  }
}
