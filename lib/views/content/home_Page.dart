import 'dart:async';
import 'package:app_snowman/controllers/database.dart';
import 'package:app_snowman/core/constants.dart';
import 'package:app_snowman/core/themes/app_colors.dart';
import 'package:app_snowman/models/Question.dart';
import 'package:app_snowman/views/Components/Add_Button.dart';
import 'package:app_snowman/views/Components/Item_Question_Component.dart';
import 'package:app_snowman/views/content/new_Question.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Question> kQuestionList = List<Question>();
  List<Question> kQuestionResultSearch = List<Question>();
  QuestionHelper kDados = QuestionHelper();

  final kKeyGlobal = GlobalKey<ScaffoldState>();

  TextEditingController kSearchController = new TextEditingController();

  @override
  void initState() {
    getAllQuestions();
    super.initState();
  }

  void getAllQuestions() {
    kDados.getAllQuestion().then((value) {
      setState(() {
        kQuestionList = value;
      });
    });
  }

  void onDelete(int value) async {
    await kDados.deleteQuestion(value);
  }

  Future<bool> editQuestion(BuildContext context,
      {Question oldQuestion}) async {
    final kQuestion = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            NewQuestion(question: oldQuestion),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );

    if (kQuestion != null) {
      kKeyGlobal.currentState.showSnackBar(SnackBar(
        elevation: 6,
        backgroundColor: Color(AppColors.itemColors1),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text('Pergunta editada com Sucesso')
          ],
        ),
      ));
    }

    getAllQuestions();

    return false;
  }

  void onEdit(int value) {
    newQuestioPage(
      context,
      oldQuestion: kQuestionList[value],
    );

    getAllQuestions();
  }

  Future<bool> onConfirmDismiss(
      DismissDirection direction, Question item) async {
    if (direction == DismissDirection.endToStart) {
      return await editQuestion(context, oldQuestion: item);
    } else if (direction == DismissDirection.startToEnd)
      return true;
    else
      return false;
  }

  void onDismissed(DismissDirection direction, List<Question> list, int index) {
    if (direction == DismissDirection.startToEnd) {
      onDelete(list[index].id);

      setState(() {
        list.removeAt(index);
      });
    }
  }

  void onSearchCancel() {
    if (!this.kSearch) {
      setState(() {
        kSearchController.clear();
        kQuestionResultSearch.clear();
      });
    }
    this.kSearch = !this.kSearch;
  }

  bool kSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: kKeyGlobal,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(kBorderRadiusDefault),
          bottomLeft: Radius.circular(kBorderRadiusDefault),
        )),
        title: kSearch
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kBorderRadiusDefault),
                  color: Color(AppColors.colorSearch),
                ),
                height: 40,
                child: TextField(
                  cursorColor: Colors.white,
                  controller: kSearchController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        kQuestionResultSearch = kQuestionList
                            .where((element) =>
                                element.title
                                    .toUpperCase()
                                    .contains(value.toUpperCase()) ||
                                element.reply.toUpperCase().contains(value))
                            .toList();
                      });
                    } else {
                      kQuestionResultSearch.clear();
                      getAllQuestions();
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Row(
                        children: [
                          Text('|'),
                          Text(
                            ' x ',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      onPressed: () => onSearchCancel(),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    fillColor: Colors.white,
                    hintText: 'Procurar perguntas',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : Text(
                'Perguntas Frequentes',
                style: TextStyle(fontSize: 16),
              ),
        centerTitle: true,
        actions: [
          if (!this.kSearch)
            IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () => onSearchCancel()),
        ],
      ),
      body: kQuestionResultSearch.isNotEmpty
          ? onBuildList(kQuestionResultSearch)
          : kQuestionList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : onBuildList(kQuestionList),
      bottomNavigationBar: AddButton(
        items: [
          SizedBox(
            width: 1,
          ),
          Text(
            'Adicionar Pergunta',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(AppColors.colorMain),
            ),
          ),
          Icon(
            Icons.add,
            color: Color(AppColors.colorMain),
          )
        ],
        onTap: () {
          newQuestioPage(context);
        },
      ),
    );
  }

  ListView onBuildList(List<Question> kList) {
    return ListView.builder(
      itemCount: kList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(kList[index].id.toString()),
          background: Container(
            color: Colors.red,
            child: Align(
              alignment: Alignment(-0.9, 0.0),
              child: Icon(Icons.delete),
            ),
          ),
          secondaryBackground: Container(
            color: Colors.yellow.shade800,
            child: Align(
              alignment: Alignment(0.9, 0.0),
              child: Icon(Icons.edit),
            ),
          ),
          confirmDismiss: (direction) =>
              onConfirmDismiss(direction, kList[index]),
          onDismissed: (direction) => onDismissed(direction, kList, index),
          child: ItemQuestion(
            item: kList[index],
            index: index,
          ),
        );
      },
    );
  }

  void newQuestioPage(BuildContext context, {Question oldQuestion}) async {
    final kQuestion = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            NewQuestion(question: oldQuestion),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );

    if (kQuestion != null) {
      kKeyGlobal.currentState.showSnackBar(SnackBar(
        elevation: 6,
        backgroundColor: Color(AppColors.itemColors1),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text('Pergunta adicionada com Sucesso')
          ],
        ),
      ));
    }

    getAllQuestions();
  }
}
