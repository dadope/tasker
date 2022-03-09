import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentInputField extends StatelessWidget {
  final String? content;
  final Function(String) saveNote;
  final TextEditingController contentController;

  const ContentInputField(this.contentController, this.saveNote, {this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    contentController.text = content??"";

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          expands: true,
          maxLines: null,
          onChanged: saveNote,
          controller: contentController,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Description",
          ),
        ),
      ),
    );
  }
}
