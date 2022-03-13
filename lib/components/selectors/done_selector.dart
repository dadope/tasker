import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class DoneSelector extends StatelessWidget {
  const DoneSelector(this.done, this.highlightColor, this.saveItem, {Key? key}) : super(key: key);

  final bool done;
  final Color? highlightColor;
  final Function(bool?) saveItem;

  @override
  Widget build(BuildContext context) {
    Color foreground = useWhiteForeground(highlightColor)?
      Colors.white:Colors.black;

    return Checkbox(
      value: done,
      onChanged: saveItem,
      activeColor: highlightColor??Colors.grey,
      checkColor: foreground,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: MaterialStateBorderSide.resolveWith(
            (states) => BorderSide(
              width: 1.0,
              color: highlightColor?? foreground
            ),
      ),
      shape: const CircleBorder(),
    );
  }
}
