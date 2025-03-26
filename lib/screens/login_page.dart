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
  String email = '', pwd = '';
  String loginEmailID = '', loginPassword = '';
  bool showSpinner = false, _passwordVisible = false;

  // Login success or failure message
  void _showMessage(String title, String message, bool success) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (success) {
                  Navigator.pushReplacementNamed(context, '/home_page');
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
          actions: <Widget>[],
          centerTitle: true,
          title: Text('Login Screen', style:TextStyle(color: kWhiteColor),),
          backgroundColor: kThemeBlueColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left:24.0,right:24.0),
          child: showSpinner == true ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10,),
                Text('Logging In'),
              ],
            ),
          ) : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 15.0,
              ),
              Flexible(
                child: HeroLogo(height:250,image:'assets/images/todo-list-dark-theme-logo.png', tag:'photo'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged:(value){
                  email = emailController.text;
                  // SharedPreferences.getInstance().then((prefs) {
                  //   prefs.setString('email', email);
                  // },);
                },
                decoration: textInputDecoration('Enter your email',),
              ),
              // TextField(
              //   controller: emailController,
              //   decoration: const InputDecoration(labelText: 'Email'),
              // ),
              const SizedBox(
                height: 15.0,
              ),

              TextField(
                controller: passwordController,
                obscureText: _passwordVisible == false ? true : false,
                onChanged:(value){
                  pwd = passwordController.text;
                  // SharedPreferences.getInstance().then((prefs) {
                  //   prefs.setString('password', pwd);
                  // },);
                },
                decoration: passwordInputDecoration(
                    'Enter your password',
                    _passwordVisible,
                        (){
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    }
                ),
              ),
              // TextField(
              //   controller: passwordController,
              //   decoration: const InputDecoration(labelText: 'Password'),
              //   obscureText: true,
              // ),
              const SizedBox(height: 20),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    _showMessage('SUCCESS!', 'Congratulations, you have logged in successfully! You will be redirected to home page now.', true);
                    setState(() {
                      isLoggedIn = true;
                      showSpinner = false;
                    });
                    // Navigator.pushReplacementNamed(context, '/home_page');
                  } else if (state is LoginFailure) {
                    setState(() {
                      isLoggedIn = false;
                      showSpinner = false;
                    });
                    _showMessage('WARNING!', 'Login failed, please try again.', false);
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator();
                    }
                    return RoundedButton(
                      colour:kThemeBlueColor,
                      title:'Login',
                      onPress:()  {
                        final email = emailController.text;
                        final password = passwordController.text;
                        setState(() {
                          showSpinner = true;
                        });
                        context.read<LoginBloc>().add(LoginSubmitted(email: email, password: password));
                      },
                    );
                    return ElevatedButton(
                      onPressed: () {
                        final email = emailController.text;
                        final password = passwordController.text;
                        setState(() {
                          showSpinner = true;
                        });
                        context.read<LoginBloc>().add(LoginSubmitted(email: email, password: password));
                      },
                      child: const Text('Login'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}