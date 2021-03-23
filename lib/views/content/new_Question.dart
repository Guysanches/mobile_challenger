import 'dart:async';
import 'package:app_snowman/controllers/database.dart';
import 'package:app_snowman/views/Components/Custom_Input.dart';
import 'package:flutter/material.dart';
import 'package:app_snowman/core/constants.dart';
import 'package:app_snowman/core/themes/app_colors.dart';
import 'package:app_snowman/models/Question.dart';
import 'package:app_snowman/views/Components/Item_Radio_Color_Componente.Dart';

class NewQuestion extends StatefulWidget {
  final Question question;

  const NewQuestion({
    Key key,
    this.question,
  }) : super(key: key);

  @override
  _NewQuestionState createState() => _NewQuestionState();
}

class _NewQuestionState extends State<NewQuestion> {
  bool onPress;
  bool onCheckItem1;
  bool onCheckItem2;
  bool onCheckItem3;
  bool onCheckItem4;
  Question kQuestion;
  String kAction;

  QuestionHelper kDados = QuestionHelper();

  final titleController = TextEditingController();
  final replyController = TextEditingController();

  bool titleErrorText;
  bool replyErrorText;
  bool colorsUnchecked;

  @override
  void initState() {
    super.initState();
    onPress = false;
    onCheckItem1 = false;
    onCheckItem2 = false;
    onCheckItem3 = false;
    onCheckItem4 = false;
    titleErrorText = false;
    replyErrorText = false;
    colorsUnchecked = false;

    if (widget.question != null) {
      kQuestion = Question.fromMap(widget.question.toMap());
      kAction = 'Editar ';
    } else {
      kQuestion = Question();
      kAction = 'Adicionar ';
    }

    titleController.text = kQuestion.title;
    replyController.text = kQuestion.reply;
    onCheckItem(true, onColorSelect(kQuestion.color));
  }

  @override
  void dispose() {
    titleController.dispose();
    replyController.dispose();
    super.dispose();
  }

  void onCheckItem(bool value, int item) {
    switch (item) {
      case 1:
        {
          setState(() {
            onCheckItem1 = value;
            onCheckItem2 = false;
            onCheckItem3 = false;
            onCheckItem4 = false;
          });
          break;
        }
      case 2:
        {
          setState(() {
            onCheckItem1 = false;
            onCheckItem2 = value;
            onCheckItem3 = false;
            onCheckItem4 = false;
          });
          break;
        }
      case 3:
        {
          setState(() {
            onCheckItem1 = false;
            onCheckItem2 = false;
            onCheckItem3 = value;
            onCheckItem4 = false;
          });
          break;
        }
      case 4:
        {
          setState(() {
            onCheckItem1 = false;
            onCheckItem2 = false;
            onCheckItem3 = false;
            onCheckItem4 = value;
          });
          break;
        }
    }

    if ((onCheckItem1) || (onCheckItem2) || (onCheckItem3) || (onCheckItem4)) {
      setState(() {
        colorsUnchecked = false;
      });
    }
  }

  int onColorSelect(String color) {
    if (color == AppColors.itemColors1.toString()) {
      return 1;
    } else if (color == AppColors.itemColors2.toString()) {
      return 2;
    } else if (color == AppColors.itemColors3.toString()) {
      return 3;
    } else
      return AppColors.itemColors4;
  }

  int onReturnColorSelect() {
    if (onCheckItem1) {
      return AppColors.itemColors1;
    } else if (onCheckItem2) {
      return AppColors.itemColors2;
    } else if (onCheckItem3) {
      return AppColors.itemColors3;
    } else
      return AppColors.itemColors4;
  }

  void onAdicionar() async {
    setState(() {
      onPress = true;
    });

    Timer(Duration(seconds: 1), () async {
      if (titleController.text.isEmpty) {
        setState(() {
          titleErrorText = true;
        });
      }

      if (replyController.text.isEmpty) {
        setState(() {
          replyErrorText = true;
        });
      }

      if ((!onCheckItem1) &&
          (!onCheckItem2) &&
          (!onCheckItem3) &&
          (!onCheckItem4)) {
        setState(() {
          colorsUnchecked = true;
        });
      }

      if ((!colorsUnchecked) && (!replyErrorText) && (!colorsUnchecked)) {
        Question xQuestion = new Question(
          id: kQuestion.id,
          title: titleController.text,
          reply: replyController.text,
          color: onReturnColorSelect().toString(),
        );

        if (widget.question != null) {
          await kDados.updateQuestion(xQuestion);
        } else
          await kDados.insertQuestion(xQuestion);

        Navigator.of(context).pop(xQuestion);
      } else
        setState(() {
          onPress = false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(kBorderRadiusDefault),
            bottomLeft: Radius.circular(kBorderRadiusDefault),
          ),
        ),
        title: Text(
          '$kAction Pergunta',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadiusDefault),
            ),
            margin: const EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
              bottom: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomInputDecoration(
                  itemController: titleController,
                  itemLabel: 'Título da Pergunta',
                  maxLines: 1,
                  textError: kTitleNullError,
                  error: titleErrorText,
                  onChanged: (value) {
                    setState(() {
                      titleErrorText = value;
                    });
                  },
                ),
                CustomInputDecoration(
                  itemController: replyController,
                  itemLabel: 'Resposta da Pergunta',
                  maxLines: 5,
                  textError: kReplyNullError,
                  error: replyErrorText,
                  onChanged: (value) {
                    setState(() {
                      replyErrorText = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(kPaddingDefault),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Cor',
                        style: TextStyle(
                          color: Color(AppColors.colorInputDecoration),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ItemRadioColor(
                            item: 1,
                            color: AppColors.itemColors1,
                            onClicked: onCheckItem1,
                            onTapCallback: onCheckItem,
                          ),
                          ItemRadioColor(
                            item: 2,
                            color: AppColors.itemColors2,
                            onClicked: onCheckItem2,
                            onTapCallback: onCheckItem,
                          ),
                          ItemRadioColor(
                            item: 3,
                            color: AppColors.itemColors3,
                            onClicked: onCheckItem3,
                            onTapCallback: onCheckItem,
                          ),
                          ItemRadioColor(
                            item: 4,
                            color: AppColors.itemColors4,
                            onClicked: onCheckItem4,
                            onTapCallback: onCheckItem,
                          ),
                        ],
                      ),
                      colorsUnchecked
                          ? Text('É necessário selecionar uma cor.',
                              style:
                                  TextStyle(color: AppColors.colorErrorSelect))
                          : SizedBox(),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(kBorderRadiusDefault),
                          bottomLeft: Radius.circular(kBorderRadiusDefault),
                        ),
                        color: Color(AppColors.splashColor)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(AppColors.splashColor),
                        ),
                      ),
                      onPressed: () => onAdicionar(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: onPress
                                ? SizedBox(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(AppColors.colorMain)),
                                    ),
                                    height: 30.0,
                                    width: 30.0,
                                  )
                                : Text(
                                    kAction,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(AppColors.colorMain),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
