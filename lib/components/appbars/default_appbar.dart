import 'package:flutter/material.dart';
import 'package:tasker/components/textfield/default_search_bar.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget{
  const DefaultAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const DefaultSearchBar()
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
