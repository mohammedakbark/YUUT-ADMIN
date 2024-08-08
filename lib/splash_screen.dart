import 'package:flutter/material.dart';
import 'package:yuut_admin/View/navigation.dart';
import 'package:yuut_admin/utils/const/const.dart';
import 'package:yuut_admin/utils/const/media.dart';
import 'package:yuut_admin/View/home_tabs/mainpage.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _animation = Tween<double>(
      begin: .4,
      end: .5,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4)).then((value) {
      Navigator.of(context)
          .pushAndRemoveUntil(createRoute(NavigationPage()), (route) => false);
    });
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(logo),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        child: logoText,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
