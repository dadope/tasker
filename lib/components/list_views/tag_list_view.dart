import 'package:flutter/cupertino.dart';
import 'package:tasker/components/elements/tag_element.dart';
import 'package:tasker/models/tag.dart';

class TagListView extends StatelessWidget {
  const TagListView(this.tags, {this.highlight, this.addElement,this.searchTag, this.saveItem, Key? key}) : super(key: key);

  final List<Tag> tags;
  final bool? addElement;
  final Color? highlight;
  final Function(Tag)? searchTag;
  final Function(Tag)? saveItem;

  @override
  Widget build(BuildContext context) => Row(

    children: [
      ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (BuildContext context, int index) =>
          TagElement(
            tags.elementAt(index),
            highlight??tags.elementAt(index).highlightColor,
            searchTag: searchTag,
          )),
      if (addElement != null)
        TagElement(null, highlight, saveItem: saveItem)
    ],
  );
}
