import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasker/bloc/item_manager/item_manager_bloc.dart';
import 'package:tasker/components/elements/date_element.dart';
import 'package:tasker/components/list_views/tag_list_view.dart';
import 'package:tasker/components/selectors/done_selector.dart';
import 'package:tasker/models/item.dart';
import 'package:tasker/models/note.dart';
import 'package:tasker/models/tag.dart';

import 'package:tasker/models/task.dart';
import 'package:tasker/views/edit_item_view.dart';


class ItemElement extends StatefulWidget {
  final Item item;
  final bool selected;
  final bool selectionActive;
  final Function(Item selectedItem) onLongPress;
  final Function(Tag)? searchTag;

  const ItemElement(this.item, this.onLongPress, this.selectionActive, this.selected, {this.searchTag, Key? key}) : super(key: key);

  @override
  State<ItemElement> createState() => _ItemElementState();
}

class _ItemElementState extends State<ItemElement> {

  @override
  Widget build(BuildContext context) {
    Item item = widget.item;
    double opacity = item is Task && item.done? 0.3:1;
    final ItemManagerBloc dataBloc = BlocProvider.of<ItemManagerBloc>(context);

    return Opacity(
      opacity: opacity,
      child: Padding(
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
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              item.tags.isEmpty ?
                                const SizedBox.shrink():
                                Expanded(
                                  child: SizedBox(
                                    height: 28,
                                    child: Transform(
                                      transform: Matrix4.identity()..scale(0.9),
                                      child: TagListView(
                                        item.tags,
                                        highlight: item.highlightColor,
                                        searchTag: widget.searchTag,
                                      )
                                    )
                                  ),
                                ),
                                item is Task?
                                  DateElement(item) :
                                  const SizedBox.shrink()
                            ],
                          ),
                        ),
                        item.tags.isEmpty?
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
                          const SizedBox.shrink():
                        const SizedBox.shrink()
                      ]
                    )
                  )
                ]
              )
            )
          )
        )
      ),
    );
  }
}
