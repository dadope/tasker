import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'tag.g.dart';

// empty class
@HiveType(typeId: 4)
class Tag extends HiveObject with EquatableMixin{
  @HiveField(0)
  DateTime creationDate;

  @HiveField(1)
  String title;

  @HiveField(2)
  Color? highlightColor;

  @HiveField(3)
  Icon? icon;

  @override
  String toString() {
    return "\n"
        "Tag: creationDate: $creationDate | title: $title\n";
  }

  Tag(this.title, {this.highlightColor, DateTime? creationDate, this.icon}):
        creationDate = creationDate?? DateTime.now();

  @override
  List<String> get props => [title];
}