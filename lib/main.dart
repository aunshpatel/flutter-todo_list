import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/repositories/auth_repository.dart';
import 'package:todo_list/screens/about_page.dart';
import 'package:todo_list/screens/home_page.dart';
import 'package:todo_list/screens/registration_screen.dart';
import 'package:todo_list/screens/widgets/consts.dart';

import 'blocs/registration/registration_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  /*Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Todo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(0, 227, 231, 239)),
        useMaterial3: false,
      ),
      initialRoute: '/home_page',
      routes: {
        '/home_page':(context) => const HomePage(),
        '/about_us':(context) => const AboutPage(),
        '/registration_page':(context) => RegistrationScreen(),
      },
    );
  }*/

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Todo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(0, 227, 231, 239)),
        useMaterial3: false,
      ),
      initialRoute: '/home_page',
      routes: {
        '/home_page': (context) => const HomePage(),
        '/about_us': (context) => const AboutPage(),
        '/registration_page': (context) => BlocProvider(
          create: (_) => RegistrationBloc(authRepository: AuthRepository()),
          child: RegistrationScreen(),
        ),
      },
    );
  }
}