import 'package:app_snowman/core/constants.dart';
import 'package:app_snowman/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomInputDecoration extends StatefulWidget {
  final TextEditingController itemController;
  final String itemLabel;
  final String textError;
  final int maxLines;
  final bool error;
  final Function(bool) onChanged;

  const CustomInputDecoration(
      {Key key,
      this.itemController,
      this.itemLabel,
      this.textError,
      this.maxLines,
      this.error = false,
      this.onChanged})
      : super(key: key);

  @override
  _CustomInputDecorationState createState() => _CustomInputDecorationState();
}

class _CustomInputDecorationState extends State<CustomInputDecoration> {
  @override
  Widget build(BuildContext context) {
    bool erro = widget.error;
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Container(
        child: TextField(
          controller: widget.itemController,
          maxLines: widget.maxLines,
          maxLengthEnforced: true,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            if (value.isNotEmpty)
              setState(() {
                widget.onChanged(false);
              });
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            labelText: widget.itemLabel,
            hintText: widget.itemLabel,
            errorText: erro ? widget.textError : null,
            hintStyle: TextStyle(color: Color(AppColors.colorInputDecoration)),
            labelStyle: TextStyle(color: Color(AppColors.colorInputDecoration)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kBorderRadiusDefault),
              borderSide: BorderSide(
                color: Color(AppColors.colorInputDecoration),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kBorderRadiusDefault),
              borderSide: BorderSide(
                color: Color(AppColors.colorInputDecoration),
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
      ),
    );
  }
}
