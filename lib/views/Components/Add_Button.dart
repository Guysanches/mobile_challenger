import 'package:flutter/material.dart';

import 'package:app_snowman/core/themes/app_colors.dart';

class AddButton extends StatelessWidget {
  final List<Widget> items;
  final Function onTap;
  final MainAxisAlignment onMainAxisAlignment;

  const AddButton({
    Key key,
    this.items,
    this.onTap,
    this.onMainAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color(AppColors.splashColor),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: onMainAxisAlignment != null
              ? onMainAxisAlignment
              : MainAxisAlignment.spaceBetween,
          children: items,
        ),
      ),
    );
  }
}
