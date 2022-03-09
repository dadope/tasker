import 'package:hive/hive.dart';

import 'item.dart';

part 'task.g.dart';

//TODO add support for multi-day tasks
@HiveType(typeId: 2)
class Task extends Item{

  @HiveField(0)
  DateTime creationDate;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  bool done;

  @HiveField(4)
  DateTime dueDate;

  @override
  String toString() {
    return "\n"
        "done: $done | title: $title | content: $content\n"
        "creationDate: $creationDate | dueDate: $dueDate\n";
  }

  Task({this.title = "", this.content = "", this.done = false, DateTime? creationDate, DateTime? dueDate}):
        creationDate = creationDate?? DateTime.now(),
        dueDate = dueDate?? DateTime.now(),
        super(title: title, creationDate: creationDate);
}
