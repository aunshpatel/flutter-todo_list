/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/repositories/auth_repository.dart';
import 'package:todo_list/repositories/user_repositories.dart';
import 'package:todo_list/screens/about_page.dart';
import 'package:todo_list/screens/home_page.dart';
import 'package:todo_list/screens/login_page.dart';
import 'package:todo_list/screens/profile_page.dart';
import 'package:todo_list/screens/registration_screen.dart';
import 'package:todo_list/screens/widgets/consts.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/profile/profile_bloc.dart';
import 'blocs/registration/registration_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileBloc(userRepository: UserRepository()),
        ),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String loginEmailID = '', loginPassword = '';

  @override
  void initState() {
    super.initState();
    loginFunction();
  }
  
  loginFunction() async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      loginEmailID = prefs.getString('email') ?? '';
      loginPassword = prefs.getString('password') ?? '';
      currentUserID = prefs!.getString('currentUserID') ?? '';
    });

    if(isLoggedIn == true){
      print('User $currentUserID has logged in with email ID:$loginEmailID & pwd:$loginPassword');
    }
    else{
      print('User has not logged in');
    }
  }

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
        '/home_page': (context) => const HomePage(),
        '/about_us': (context) => const AboutPage(),
        '/registration_page': (context) => BlocProvider(
          create: (_) => RegistrationBloc(authRepository: AuthRepository()),
          child: RegistrationScreen(),
        ),
        '/login_page': (context) => BlocProvider(
          create: (_) => LoginBloc(authRepository: AuthRepository()),
          child: LoginPage(),
        ),
        '/profile_page': (context) => BlocProvider(
          create: (_) => ProfileBloc(userRepository: UserRepository()),  // Provide the necessary BLoC for ProfilePage
          child: ProfilePage(),
        ),
      },
    );
  }
}
*//*


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/repositories/auth_repository.dart';
import 'package:todo_list/repositories/todo_repositories.dart';
import 'package:todo_list/repositories/user_repositories.dart';
import 'package:todo_list/screens/about_page.dart';
import 'package:todo_list/screens/all_todos_page.dart';
import 'package:todo_list/screens/home_page.dart';
import 'package:todo_list/screens/login_page.dart';
import 'package:todo_list/screens/profile_page.dart';
import 'package:todo_list/screens/registration_screen.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/profile/profile_bloc.dart';
import 'blocs/registration/registration_bloc.dart';
import 'blocs/todo/todo_bloc.dart'; // Add TodoBloc import

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileBloc(userRepository: UserRepository()),
        ),
        BlocProvider(
          create: (context) => TodoBloc(todoRepository: TodoRepository()), // Add TodoBloc provider
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String loginEmailID = '', loginPassword = '';
  bool isLoggedIn = false;
  String currentUserID = '';

  @override
  void initState() {
    super.initState();
    loginFunction();
  }

  loginFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      loginEmailID = prefs.getString('email') ?? '';
      loginPassword = prefs.getString('password') ?? '';
      currentUserID = prefs!.getString('currentUserID') ?? '';
    });

    if (isLoggedIn == true) {
      print('User $currentUserID has logged in with email ID:$loginEmailID & pwd:$loginPassword');
    } else {
      print('User has not logged in');
    }
  }

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
        '/home_page': (context) => const HomePage(),
        '/about_us': (context) => const AboutPage(),
        '/registration_page': (context) => BlocProvider(
          create: (_) => RegistrationBloc(authRepository: AuthRepository()),
          child: RegistrationScreen(),
        ),
        '/login_page': (context) => BlocProvider(
          create: (_) => LoginBloc(authRepository: AuthRepository()),
          child: LoginPage(),
        ),
        '/profile_page': (context) => BlocProvider(
          create: (_) => ProfileBloc(userRepository: UserRepository()),
          child: ProfilePage(),
        ),
        '/view_all_todos': (context) => BlocProvider(
          create: (_) => TodoBloc(todoRepository: TodoRepository()),
          child: AllTodosPage(),
        ),
      },
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/repositories/auth_repository.dart';
import 'package:todo_list/repositories/todo_repositories.dart';
import 'package:todo_list/repositories/user_repositories.dart';
import 'package:todo_list/screens/about_page.dart';
import 'package:todo_list/screens/all_todos_page.dart';
import 'package:todo_list/screens/home_page.dart';
import 'package:todo_list/screens/login_page.dart';
import 'package:todo_list/screens/profile_page.dart';
import 'package:todo_list/screens/registration_screen.dart';
import 'package:todo_list/screens/widgets/consts.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/profile/profile_bloc.dart';
import 'blocs/registration/registration_bloc.dart';
import 'blocs/todo/todo_bloc.dart'; // Import TodoBloc

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileBloc(userRepository: UserRepository()),
        ),
        BlocProvider(
          create: (context) => TodoBloc(todoRepository: TodoRepository()), // TodoBloc Provider
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String loginEmailID = '', loginPassword = '';
  // bool isLoggedIn = false;
  // String currentUserID = '';

  @override
  void initState() {
    super.initState();
    loginFunction();
  }

  loginFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      loginEmailID = prefs.getString('email') ?? '';
      loginPassword = prefs.getString('password') ?? '';
      currentUserID = prefs!.getString('currentUserID') ?? '';
    });

    if (isLoggedIn == true) {
      print('User $currentUserID has logged in with email ID:$loginEmailID & pwd:$loginPassword');
    } else {
      print('User has not logged in');
    }
  }

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
        '/home_page': (context) => const HomePage(),
        '/about_us': (context) => const AboutPage(),
        '/registration_page': (context) => BlocProvider(
          create: (_) => RegistrationBloc(authRepository: AuthRepository()),
          child: RegistrationScreen(),
        ),
        '/login_page': (context) => BlocProvider(
          create: (_) => LoginBloc(authRepository: AuthRepository()),
          child: LoginPage(),
        ),
        '/profile_page': (context) => BlocProvider(
          create: (_) => ProfileBloc(userRepository: UserRepository()),
          child: ProfilePage(),
        ),
        '/view_all_todos': (context) => AllTodosPage(), // Added TodoPage route
      },
    );
  }
}

