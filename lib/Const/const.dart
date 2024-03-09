import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuut_admin/Const/colors.dart';

var logoText = Text(
  "YUUT EBROK",
  style: GoogleFonts.nanumMyeongjo(
      color: white, fontWeight: FontWeight.w800, letterSpacing: 1),
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
    {double? size, FontWeight? fontWeight, double? letterSpacing,Color ?color}) {
  return GoogleFonts.anekBangla(
      color:color?? white,
      fontWeight: fontWeight,
      fontSize: size,
      letterSpacing: letterSpacing);
}
//anekDevanagari