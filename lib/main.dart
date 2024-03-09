import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuut_admin/Const/colors.dart';
import 'package:yuut_admin/View%20Model/controller.dart';
import 'package:yuut_admin/View/splash_screen.dart';
import 'package:yuut_admin/Const/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Controller>(
            create: (_) => Controller())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'YUUT BROKE',
        theme: ThemeData(
          outlinedButtonTheme: OutlinedButtonThemeData(
              style:
                  ButtonStyle(overlayColor: MaterialStatePropertyAll(black))),

          appBarTheme: AppBarTheme(backgroundColor: black),
          scaffoldBackgroundColor: black,
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SpalshScreen(),
      ),
    );
  }
}
