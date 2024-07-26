import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yuut_admin/utils/const/media.dart';

class LoadingAnimatedLogo extends StatefulWidget {
  const LoadingAnimatedLogo({super.key});

  @override
  State<LoadingAnimatedLogo> createState() => _LoadingAnimatedLogoState();
}

class _LoadingAnimatedLogoState extends State<LoadingAnimatedLogo>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      animationBehavior: AnimationBehavior.normal,
      duration: const Duration(milliseconds: 1450),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: .0, end: .4).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        content: Stack(
          alignment: Alignment.center,
          children: [
            Lottie.asset(
              height: 70,
              width: 70,
              "assets/loading.json",
            ),
            Image.asset(
              logo,
              scale: 50,
              opacity: _animation,
            )
          ],
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

showLoadingIndiactor(context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const LoadingAnimatedLogo());
}


