import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuut_admin/utils/const/colors.dart';
import 'package:yuut_admin/utils/const/const_string.dart';
import 'package:yuut_admin/controller/controller.dart';
import 'package:yuut_admin/splash_screen.dart';
import 'package:yuut_admin/utils/const/const.dart';
import 'package:yuut_admin/logic/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Controller>(create: (_) => Controller())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ConstString.appName,
        theme: ThemeData(
          outlinedButtonTheme: const OutlinedButtonThemeData(
              style: ButtonStyle(
                  overlayColor: MaterialStatePropertyAll(ColorResourse.black))),

          appBarTheme: const AppBarTheme(backgroundColor: ColorResourse.black),
          scaffoldBackgroundColor: ColorResourse.black,
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SpalshScreen(),
      ),
    );
  }
}
