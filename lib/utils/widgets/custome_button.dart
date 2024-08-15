import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yuut_admin/utils/const/colors.dart';
import 'package:yuut_admin/utils/const/const.dart';

class CustomeButton extends StatelessWidget {
  final String title;
  void Function()? onPressed;
  double width;
  Color bgColor;
  Color? textColor;

  CustomeButton(
      {super.key,
      required this.width,
      required this.bgColor,
      required this.onPressed,
      this.textColor,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: bgColor,
              shape: const BeveledRectangleBorder(),
              side: const BorderSide(
                width: .5,
                color: ColorResourse.white,
              )),
          onPressed: onPressed,
          child: Text(
            title,
            style: appTextstyle(size: 17, color: textColor),
          )),
    );
  }
}
