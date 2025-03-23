import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/screens/about_page.dart';
import 'package:todo_list/screens/home_page.dart';
import 'package:todo_list/screens/widgets/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Todo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(0, 227, 231, 239)),
        useMaterial3: false,
      ),
      initialRoute: '/splash_screen',
      routes: {
        '/splash_screen': (context) => AnimatedSplashScreen(
          duration: 3000,
          centered: true,
          splashIconSize: 230,
          splash: 'assets/images/todo-list-white-transparent-bg.png',
          nextScreen: const HomePage(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: kThemeBlueColor,
        ),
        '/home_page':(context) => const HomePage(),
        '/about_us':(context) => const AboutPage(),
      },
    );
  }
}