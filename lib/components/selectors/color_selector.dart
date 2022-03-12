

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorSelector extends StatelessWidget {
  const ColorSelector(this.highlight, this.saveItem, {Key? key}) : super(key: key);

  final Color? highlight;
  final Function(Color) saveItem;


  @override
  Widget build(BuildContext context) =>
      ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: highlight?? Colors.grey.shade500,
                            onColorChanged: saveItem,
                          )
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                            child: const Text('Finish'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }
                        )
                      ]
                  );
                });
          },
          child: Icon(
              Icons.format_paint,
              size: 20,
              color: useWhiteForeground(highlight?? Colors.grey.shade500)?
              Colors.white:Colors.black
          ),
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              primary: highlight?? Colors.grey.shade500,
              onPrimary: Colors.red
          )
      );
}