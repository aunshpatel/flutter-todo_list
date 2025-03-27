import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/screens/widgets/consts.dart';
import 'package:todo_list/screens/widgets/rounded_buttons.dart';
import 'package:todo_list/screens/widgets/side_drawer.dart';
import '../blocs/login/login_bloc.dart';
import '../blocs/login/login_event.dart';
import '../blocs/login/login_state.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showSpinner = false;
  bool _passwordVisible = false;

  void _showMessage(String title, String message, bool success) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(title, style: kBlueBoldSize20Text,),
          content: Text(message, style: kBlueSize18Text,),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (success) {
                  Navigator.pushReplacementNamed(context, '/home_page');
                }
              },
              child: Text('OK', style: kBlueSize18Text,),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawer: const SideDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: kWhiteColor,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        centerTitle: true,
        title: Text('Login Screen', style: TextStyle(color: kWhiteColor)),
        backgroundColor: kThemeBlueColor,
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            setState(() {
              showSpinner = false;
              isLoggedIn = true;
            });
            prefs.setBool('isLoggedIn', isLoggedIn);
            Future.delayed(Duration(milliseconds: 100), () {
              _showMessage('SUCCESS!', 'You have logged in successfully! You will now be redirected to home page.', true);
            });
          }
          else if (state is LoginFailure) {
            setState(() {
              showSpinner = false;
              isLoggedIn = false;
            });
            prefs.setBool('isLoggedIn', isLoggedIn);
            Future.delayed(Duration(milliseconds: 100), () {
              _showMessage('WARNING!', 'Login failed, please try again.', false);
            });
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return showSpinner ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
                SizedBox(height: 20,),
                Text('Hold on tight! You are being logged in.', style: kBlueBoldSize20Text,),
              ],
            ) : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 15.0),
                  Flexible(
                    child: HeroLogo(
                      height: 250,
                      image: 'assets/images/todo-list-dark-theme-logo.png',
                      tag: 'photo',
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: textInputDecoration('Enter your email'),
                  ),
                  SizedBox(height: 15.0),
                  TextField(
                    controller: passwordController,
                    obscureText: !_passwordVisible,
                    decoration: passwordInputDecoration(
                      'Enter your password',
                      _passwordVisible,
                          () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  RoundedButton(
                    colour: kThemeBlueColor,
                    title: 'Login',
                    onPress: () {
                      final email = emailController.text;
                      final password = passwordController.text;
                      setState(() {
                        showSpinner = true;
                      });
                      context.read<LoginBloc>().add(
                        LoginSubmitted(email: email.trim(), password: password.trim()),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("New User?", style: kLightSize18Text),
                      TextButton(
                        child: const Text('Register Here', style: kBlueSize18Text,),
                        onPressed: () {
                          Navigator.pushNamed(context, '/registration_page');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}