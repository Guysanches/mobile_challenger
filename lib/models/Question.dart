import 'package:app_snowman/controllers/database.dart';

//Question structure class
class Question {
  int id;
  String title;
  String reply;
  String color;

  Question({
    this.id,
    this.title,
    this.reply,
    this.color,
  });

  Question.fromMap(Map map) {
    id = map[kId];
    title = map[kTitle];
    reply = map[kReply];
    color = map[kColor];
  }

  Map toMap() {
    Map<String, dynamic> map = {kTitle: title, kReply: reply, kColor: color};

    if (id != null) {
      map[kId] = id;
    }

    return map;
  }
}
