import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/screens/widgets/consts.dart';
import 'package:todo_list/screens/widgets/rounded_buttons.dart';
import 'package:todo_list/screens/widgets/side_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../blocs/registration/registration_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '', pwd = '', confirmPwd = '', username = '';
  String loginEmailID = '', loginPassword = '', fullName = '';
  bool showSpinner = false, isEmailIdValid = false, isLengthValid = false, isUppercaseValid = false, isNumberValid = false, isSpecialCharValid = false, doPasswordsMatch = false;
  bool _passwordVisible = false, _confirmPasswordVisible = false, allPwdCriteriaMatch = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  validatePassword() {
    if (pwd.length < 8) {
      setState(() {
        isLengthValid = false;
      });
    }
    else if (pwd.length >= 8) {
      setState(() {
        isLengthValid = true;
      });
    }

    if (!RegExp(r'[A-Z]').hasMatch(pwd)) {
      setState(() {
        isUppercaseValid = false;
      });
    }
    else if (RegExp(r'[A-Z]').hasMatch(pwd)) {
      setState(() {
        isUppercaseValid = true;
      });
    }

    if (!RegExp(r'[0-9]').hasMatch(pwd)) {
      setState(() {
        isNumberValid = false;
      });
    }
    else if (RegExp(r'[0-9]').hasMatch(pwd)) {
      setState(() {
        isNumberValid = true;
      });
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pwd)) {
      setState(() {
        isSpecialCharValid = false;
      });
    }
    else if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pwd)) {
      setState(() {
        isSpecialCharValid = true;
      });
    }

    if (pwd == confirmPwd) {
      setState(() {
        doPasswordsMatch = true;
      });
    } else {
      setState(() {
        doPasswordsMatch = false;
      });
    }

    if (isLengthValid &&  isUppercaseValid &&  isNumberValid &&  isSpecialCharValid &&  doPasswordsMatch) {
      setState(() {
        allPwdCriteriaMatch = true;
      });
    } else {
      setState(() {
        allPwdCriteriaMatch = false;
      });
    }
  }

  Future<void> _registrationLoginMessage(String messageContent, String redirectRoute) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('SUCCESS!', style: kSideMenuBlueSize20Text),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(messageContent, style: kLightSemiBoldSize20Text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: kLightTitleColor),),
              onPressed: () {
                // Navigator.pushNamed(context, '/login_screen');
                Navigator.pushNamed(context, redirectRoute);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _errorMessage(String messageTitle, String messageBody) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text(messageTitle, style: kSideMenuBlueSize20Text),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(messageBody, style: kDarkSemiBoldSize16Text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: kLightTitleColor),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCriteriaCheck(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Color(0XFF008000) : Color(0XFFFF4840),
        ),
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Color(0XFF008000) : Color(0XFFFF4840),
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      drawer: SideDrawer(),
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
        title: Text('Registration Screen', style:TextStyle(color: kWhiteColor),),
        backgroundColor: kThemeBlueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationSuccess) {
              // Show success message and redirect to Home Page
              _registrationLoginMessage('You have registered successfully! You will now be redirected to the Home Page.', '/home_page');
            }

            if (state is RegistrationFailure) {
              // Show error message and stay on the Registration Page
              _errorMessage('You have failed to register! Please try again.', '/registration_page',);
            }
          },
          child: BlocBuilder<RegistrationBloc, RegistrationState>(
            builder: (context, state) {
              if (state is RegistrationLoading) {
                return Center(
                  child: CircularProgressIndicator(),  // Show a loading spinner
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    HeroLogo(
                      height: 220,
                      image: 'assets/images/todo-list-dark-theme-logo.png',
                      tag: 'photo',
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    //Username
                    TextField(
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: kThemeBlueColor),
                      decoration: textInputDecoration(
                        'Enter your username',
                      ),
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    //Full name
                    TextField(
                      controller: fullnameController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: kThemeBlueColor),
                      decoration: textInputDecoration(
                        'Enter your full name',
                      ),
                      onChanged: (value) {
                        setState(() {
                          fullName = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    //Email ID
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        String emailValue = '';
                        setState(() {
                          email = value;
                          emailValue = email;
                        });
                        if (emailValue.isEmpty) {setState(() {
                          isEmailIdValid = false;});
                        }
                        final regex = RegExp(emailRegex);
                        if (!regex.hasMatch(emailValue)) {
                          setState(() {
                            isEmailIdValid = false;
                          });
                        } else {
                          setState(() {
                            isEmailIdValid = true;
                          });
                        }
                      },
                      style: const TextStyle(color: kThemeBlueColor),
                      decoration: textInputDecoration(
                        'Enter your email',
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    //Password
                    TextField(
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      style: const TextStyle(color: kThemeBlueColor),
                      decoration: passwordInputDecoration(
                        'Enter your password',
                        _passwordVisible,  () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      onChanged: (value) {
                        setState(() {
                          pwd = value;
                        });
                        validatePassword();
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    //Confirm Password
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: !_confirmPasswordVisible,
                      onChanged: (value) {
                        confirmPwd = value;
                        if (pwd == confirmPwd) {
                          setState(() {
                            doPasswordsMatch = true;
                          });
                        } else {
                          setState(() {
                            doPasswordsMatch = false;
                          });
                        }

                        if (isLengthValid &&  isUppercaseValid &&  isNumberValid &&  isSpecialCharValid &&  doPasswordsMatch) {
                          setState(() {
                            allPwdCriteriaMatch = true;
                          });
                        } else {
                          setState(() {
                            allPwdCriteriaMatch = false;
                          });
                        }
                      },
                      style: const TextStyle(color: kThemeBlueColor),
                      decoration: passwordInputDecoration(
                        'Confirm your password',
                        _confirmPasswordVisible,  () {
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      },
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    // Password Criteria
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildCriteriaCheck('1 Capital Letter', isUppercaseValid),
                            _buildCriteriaCheck('8 Characters', isLengthValid),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildCriteriaCheck('1 Special Character', isSpecialCharValid),
                            _buildCriteriaCheck('1 Number', isNumberValid),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            _buildCriteriaCheck('Passwords Match', doPasswordsMatch),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    RoundedButton(
                      title: 'Register',
                      colour: (isEmailIdValid &&username.isNotEmpty &&fullName.isNotEmpty &&allPwdCriteriaMatch) ? kThemeBlueColor: kLightTitleColor,
                      onPress: (isEmailIdValid &&username.isNotEmpty &&fullName.isNotEmpty &&allPwdCriteriaMatch) ? () {
                        context.read<RegistrationBloc>().add(
                          RegisterUserEvent(
                            username: username.trim(),
                            fullName: fullName.trim(),
                            email: email.trim(),
                            password: pwd.trim(),
                          ),
                        );
                      } : null,
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("By registering, you accept our", style: kRegularRedSize15Text),
                        TextButton(
                          child: const Text('Privacy Policy'),
                          onPressed: () {
                            launchUrl(Uri.parse('https://realestate-vgcw.onrender.com/mobileapp-privacy-policy'));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
