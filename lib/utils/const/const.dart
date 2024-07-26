import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuut_admin/utils/const/colors.dart';
import 'package:yuut_admin/utils/const/const_string.dart';

var logoText = Text(
  ConstString.appName,
  style: GoogleFonts.nanumMyeongjo(
      color:ColorResourse. white, fontWeight: FontWeight.w800, letterSpacing: 1),
);

Route createRoute(page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(microseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

TextStyle appTextstyle(
    {double? size, FontWeight? fontWeight, double? letterSpacing,Color ?color,TextBaseline? textBaseline}) {
  return GoogleFonts.anekBangla(
    textBaseline:textBaseline,
      color:color??ColorResourse. white,
      fontWeight: fontWeight,
      fontSize: size,
      letterSpacing: letterSpacing);
}
//anekDevanagari