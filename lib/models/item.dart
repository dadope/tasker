import 'dart:ui';

import 'package:hive/hive.dart';

part 'item.g.dart';

// empty class
@HiveType(typeId: 0)
class Item extends HiveObject{
  @HiveField(0)
  DateTime creationDate;

  @HiveField(1)
  String title;

  @HiveField(2)
  Color? highlightColor;

  @override
  String toString() {
    return "\n"
        "creationDate: $creationDate | title: $title\n";
  }

  Item({this.title = "", this.highlightColor, DateTime? creationDate}):
        creationDate = creationDate?? DateTime.now();
}