import 'package:flutter/material.dart';
import 'package:todo_list/screens/home_page.dart';

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
      initialRoute: '/home_page',
      routes: {
        '/home_page':(context) => const HomePage(),
      },
    );
  }
}