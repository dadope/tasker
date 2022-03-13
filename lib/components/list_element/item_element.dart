import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:tasker/bloc/item_manager/item_manager_bloc.dart';
import 'package:tasker/components/selectors/done_selector.dart';
import 'package:tasker/models/item.dart';
import 'package:tasker/models/note.dart';

import 'package:tasker/models/task.dart';
import 'package:tasker/views/edit_item_view.dart';

import '../utils.dart';

class ItemElement extends StatefulWidget {
  final Item item;
  final bool selected;
  final bool selectionActive;
  final Function(Item selectedItem) onLongPress;

  const ItemElement(this.item, this.onLongPress, this.selectionActive, this.selected, {Key? key}) : super(key: key);

  @override
  State<ItemElement> createState() => _ItemElementState();
}

class _ItemElementState extends State<ItemElement> {

  @override
  Widget build(BuildContext context) {
    Item item = widget.item;
    final ItemManagerBloc dataBloc = BlocProvider.of<ItemManagerBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0
      ),
      child: Container(
        padding:
          item is Task?
            const EdgeInsets.only(right: 8, top:8, bottom:8):
            const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 2,
            color: widget.selected? Colors.blue:Colors.white
          ),
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
            widget.selectionActive?
              Navigator.pushNamed(context, EditItemView.routeName, arguments: [item]):
              widget.onLongPress(item);
          },
          onLongPress: () => widget.onLongPress(item),
          child: IntrinsicHeight(
            child: Row(
              children: [
                item is Task?
                  DoneSelector(item.done, item.highlightColor, (bool? _){
                    setState(() {
                      item.done = _?? !item.done;
                    });
                    dataBloc.add(ItemManagerEditItem(item));
                  }):
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
                                    DateFormat('MMM dd, kk:mm').format(item.dueDate),
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
                        item.content.isEmpty?
                        const SizedBox.shrink():
                        Text(
                          item.content,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.left,
                        ):
                        item is Note?
                          item.content.isEmpty?
                          const SizedBox.shrink():
                          Text(
                            item.content,
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
