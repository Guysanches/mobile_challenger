import 'dart:ui';
import 'package:app_snowman/core/constants.dart';
import 'package:app_snowman/models/Question.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ItemQuestion extends StatelessWidget {
  final Question item;
  final int index;

  const ItemQuestion({
    Key key,
    this.item,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadiusDefault),
        color: Color(int.parse(item.color)),
      ),
      child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusDefault),
        ),
        child: ExpandablePanel(
          theme: ExpandableThemeData(
            tapHeaderToExpand: true,
          ),
          controller: ExpandableController(
            initialExpanded: false,
          ),
          header: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              item.title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          expanded: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Expandable(
                expanded: Text(
                  item.reply,
                  softWrap: true,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
