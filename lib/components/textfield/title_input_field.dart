import 'package:flutter/material.dart';

class TitleInputField extends StatelessWidget {
  final String? title;
  final Function(String) save;
  final TextEditingController titleController;

  const TitleInputField(this.titleController, this.save, {this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    titleController.text = title??"";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        onChanged: save,
        style: const TextStyle(
          fontSize: 21
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Title"
        ),
        controller: titleController,
      ),
    );
  }
}
