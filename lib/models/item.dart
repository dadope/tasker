import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:tasker/models/tag.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject{
  @HiveField(0)
  DateTime creationDate;

  @HiveField(1)
  String title;

  @HiveField(2)
  Color? highlightColor;

  @HiveField(3)
  List<Tag> tags;

  @override
  String toString() {
    return "\n"
        "creationDate: $creationDate | title: $title\n";
  }

  Item({this.title = "", this.highlightColor, List<Tag>? tags, DateTime? creationDate}):
        tags = tags?? List.empty(growable: true),
        creationDate = creationDate?? DateTime.now();
}