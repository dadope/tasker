import 'package:hive/hive.dart';

import 'package:tasker/models/note.dart';

part 'task.g.dart';

//TODO add support for multi-day tasks
class Task extends Note{
@HiveType(typeId: 0)

  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime creationDate;

  @HiveField(3)
  DateTime dueDate;

  @override
  String toString() {
    return "\n"
        "title: $title | content: $content\n"
        "creationDate: $creationDate | dueDate: $dueDate\n";
  }

  Task(this.title, {this.content = "", DateTime? creationDate, DateTime? dueDate}):
        creationDate = creationDate?? DateTime.now(),
        dueDate = dueDate?? DateTime.now(),
        super(title, content: content, creationDate: creationDate);
}
