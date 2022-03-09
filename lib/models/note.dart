import 'package:hive/hive.dart';
import 'package:tasker/models/item.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends Item{
  @HiveField(0)
  DateTime creationDate;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @override
  String toString() {
    return "\n"
        "title: $title | content: $content\n"
        "creationDate: $creationDate\n";
  }

  Note({this.title = "", this.content = "", DateTime? creationDate}):
        creationDate = creationDate?? DateTime.now();
}
