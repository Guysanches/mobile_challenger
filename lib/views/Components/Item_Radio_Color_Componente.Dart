import 'package:app_snowman/core/constants.dart';
import 'package:flutter/material.dart';

class ItemRadioColor extends StatefulWidget {
  final Function(bool, int) onTapCallback;
  final bool onClicked;
  final int item;
  final int color;

  ItemRadioColor(
      {Key key, this.onTapCallback, this.onClicked, this.item, this.color})
      : super(key: key);

  @override
  _ItemRadioColorState createState() => _ItemRadioColorState();
}

class _ItemRadioColorState extends State<ItemRadioColor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPaddingDefault),
      child: InkWell(
        borderRadius: BorderRadius.circular(kItemBorderRadiusDefault),
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(kItemBorderRadiusDefault),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                color: Color(widget.color),
                borderRadius: BorderRadius.circular(kItemBorderRadiusDefault),
              ),
              child: widget.onClicked
                  ? Icon(
                      Icons.check,
                      size: 15,
                      color: Colors.white,
                    )
                  : Text(''),
            ),
          ),
        ),
        onTap: () {
          widget.onTapCallback(
            !widget.onClicked,
            widget.item,
          );
        },
      ),
    );
  }
}
