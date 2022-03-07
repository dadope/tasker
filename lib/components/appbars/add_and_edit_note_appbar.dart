import 'package:flutter/material.dart';

class AddAndEditNoteAppBar extends StatelessWidget {
  const AddAndEditNoteAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(149, 149, 149, 1.0)
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
