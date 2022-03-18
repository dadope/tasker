import 'package:flutter/material.dart';

import '../utils.dart';
import 'package:tasker/models/tag.dart';

class TagElement extends StatelessWidget {
  const TagElement(this.tag, this.highlight, {this.saveItem, Key? key}) : super(key: key);

  final Tag? tag;
  final Color? highlight;
  final Function(Tag)? saveItem;

  @override
  Widget build(BuildContext context) {
    final TextEditingController tagTextController = TextEditingController();

    return tag != null?
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)),
            primary: highlight?? Colors.grey.shade500,
          ),
          onPressed: () {  },
          child: Center(
            child: Text(
              tag!.title,
              style: TextStyle(
                color: useWhiteForeground(highlight)?
                  Colors.white:Colors.black)
            ),
          )
        ),
    ):
      ElevatedButton.icon(
        label: Text(
          "Tag",
          style: TextStyle(
            color:useWhiteForeground(highlight)?
              Colors.white:Colors.black)
        ),
        icon: Icon(
          Icons.add,
          color: useWhiteForeground(highlight?? Colors.grey.shade500)?
          Colors.white:Colors.black
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)),
            primary: highlight?? Colors.grey.shade500,
            onPrimary: Colors.red
        ),
        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Select tag title'),
                content: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 1,
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.only(left: 5, bottom: 2),
                  child: TextField(
                    controller: tagTextController,
                    decoration: const InputDecoration(
                        border: InputBorder.none
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel')
                  ),
                  TextButton(
                    onPressed: () {
                      saveItem!(Tag(tagTextController.text));
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save')
                  )
                ],
              ));
        }
      );
  }
}
