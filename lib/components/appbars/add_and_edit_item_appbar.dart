import 'package:flutter/material.dart';

class AddAndEditItemAppBar extends StatelessWidget with PreferredSizeWidget {
  const AddAndEditItemAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
