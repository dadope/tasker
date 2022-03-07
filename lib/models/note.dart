import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime creationDate;

  @override
  String toString() {
    return "\n"
        "title: $title | content: $content\n"
        "creationDate: $creationDate\n";
  }

  Note(this.title, {this.content = "", DateTime? creationDate}):
        creationDate = creationDate?? DateTime.now();
}
