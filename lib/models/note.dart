import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:tasker/models/item.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends Item{
  @HiveField(3)
  String content;

  @override
  String toString() {
    return "\n"
        "title: $title | content: $content\n"
        "creationDate: $creationDate\n";
  }

  Note({DateTime? creationDate, String title = "", Color? highlightColor, this.content = ""}):
        super(creationDate: creationDate, title: title, highlightColor: highlightColor);
}
