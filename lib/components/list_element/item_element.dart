import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:tasker/models/item.dart';
import 'package:tasker/models/note.dart';

import 'package:tasker/models/task.dart';
import 'package:tasker/views/edit_item_view.dart';

import '../utils.dart';

class ItemElement extends StatelessWidget {
  final Item item;
  final bool selected;
  final bool selectionActive;
  final Function(Item selectedItem) onLongPress;

  const ItemElement(this.item, this.onLongPress, this.selectionActive, this.selected, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2)
            ),
          ],
        ),
        child: InkWell(
          onTap: (){
            selectionActive?
              Navigator.pushNamed(context, EditItemView.routeName, arguments: [item]):
              onLongPress(item);
          },
          onLongPress: () => onLongPress(item),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 4,
                    decoration: BoxDecoration(
                      color: item.highlightColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: item.title.isEmpty?
                              const SizedBox.shrink():
                              Text(
                                item.title,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          item is Task? Container(
                            decoration: BoxDecoration(
                              color: item.highlightColor?? Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 20,
                                  color: useWhiteForeground(item.highlightColor)?
                                    Colors.white:Colors.black
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    DateFormat('MMM dd, kk:mm').format((item as Task).dueDate),
                                    style: TextStyle(
                                      color: useWhiteForeground(item.highlightColor)?
                                        Colors.white:Colors.black
                                    ),
                                  )
                                )
                              ]
                            )
                          ):const SizedBox.shrink()
                        ]
                      ),
                      item is Task?
                        (item as Task).content.isEmpty?
                          const SizedBox.shrink():
                          Text(
                            (item as Task).content,
                            maxLines: 3,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.left,
                          ):
                      item is Note?
                        (item as Note).content.isEmpty?
                        const SizedBox.shrink():
                        Text(
                          (item as Note).content,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.left,
                        ):
                      const SizedBox.shrink()
                    ]
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}
