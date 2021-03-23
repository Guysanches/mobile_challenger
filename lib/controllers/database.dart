import 'package:app_snowman/core/constants.dart';
import 'package:app_snowman/models/Question.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Struc table
final String kTable = "QUESTION";
final String kId = "ID";
final String kTitle = "TITLE";
final String kReply = "REPLY";
final String kColor = "COLOR";

//Singleton class for handling the database
class QuestionHelper {
  static final QuestionHelper onInstace = QuestionHelper.internal();

  factory QuestionHelper() => onInstace;

  QuestionHelper.internal();

  Database kDados;

  Future<Database> get onDados async {
    if (kDados != null) {
      return kDados;
    } else {
      kDados = await onInitDados();
      return kDados;
    }
  }

  Future<Database> onInitDados() async {
    final pathDatabase = await getDatabasesPath();
    final path = join(pathDatabase, 'data_question.db');

    String sqlCreate =
        'CREATE TABLE $kTable($kId INTEGER PRIMARY KEY, $kTitle TEXT, $kReply TEXT, $kColor TEXT)';

    return await openDatabase(path, version: 1,
        onCreate: (Database dados, int newerVersion) async {
      await dados.execute(sqlCreate);

      for (Question question in kList) {
        await dados.insert(kTable, question.toMap());
      }
    });
  }

  Future<Question> insertQuestion(Question question) async {
    Database dados = await onDados;
    question.id = await dados.insert(kTable, question.toMap());
    return question;
  }

  Future<List> getQuestion(String search) async {
    Database dados = await onDados;
    List<Map<String, dynamic>> maps = await dados.query(kTable,
        columns: [kId, kTitle, kReply, kColor],
        where: "$kTitle like ? or $kReply like ?",
        whereArgs: [search, search],
        orderBy: kId);

    List<Question> kListQuestions = List();
    for (Map kQUestion in maps) {
      kListQuestions.add(Question.fromMap(kQUestion));
    }

    return kListQuestions;
  }

  Future<List> getAllQuestion() async {
    Database dados = await onDados;
    List<Map<String, dynamic>> maps =
        await dados.rawQuery('SELECT * FROM $kTable');

    List<Question> kListQuestions = List();
    for (Map kQUestion in maps) {
      kListQuestions.add(Question.fromMap(kQUestion));
    }

    return kListQuestions;
  }

  Future<int> deleteQuestion(int id) async {
    Database dados = await onDados;
    return await dados.delete(kTable, where: '$kId = ?', whereArgs: [id]);
  }

  Future<int> updateQuestion(Question question) async {
    Database dados = await onDados;
    return await dados.update(kTable, question.toMap(),
        where: '$kId = ?', whereArgs: [question.id]);
  }

  Future<int> getId() async {
    Database dados = await onDados;
    return Sqflite.firstIntValue(
        await dados.rawQuery('SELECT COUNT(*) FROM $kTable'));
  }

  Future close() async {
    Database dados = await onDados;
    dados.close();
  }

  Future onInsertDefaultQuestion() async {
    Database dados = await onDados;
    for (Question question in kList) {
      await dados.insert(kTable, question.toMap());
    }
  }
}
