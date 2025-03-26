import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/repositories/user_repositories.dart';
import 'package:todo_list/screens/widgets/consts.dart';
import 'package:todo_list/screens/widgets/rounded_buttons.dart';
import 'package:todo_list/screens/widgets/side_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email='', username='', password='', fullname = '';
  bool _passwordVisible = false, uploading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  /*loadDetails() async{
    username = prefs!.getString('username')!;
    usernameController.text = prefs!.getString('username')!;
    email = prefs!.getString('email')!;
    emailController.text = prefs!.getString('email')!;
    passwordController.text = prefs!.getString('password') ?? '';
    password = prefs!.getString('password') ?? '';
    fullname = prefs!.getString('fullname')!;
    fullnameController.text = prefs!.getString('fullname')!;
    currentUserID = prefs!.getString('currentUserID')!;

    final userProfile = await UserRepository.getUserProfile(currentUserID);
    String userProfileUsername = userProfile?['username'];
    String userProfileFullname = userProfile?['fullname'];
    String userProfileEmail = userProfile?['email'];

    if(username != userProfileUsername){
      setState(() {
        username = userProfileUsername;
        usernameController.text = userProfileUsername;
      });
      prefs.setString('username', username);
    } else if(username == userProfileUsername){
      setState(() {
        username = prefs!.getString('username')!;
        usernameController.text = prefs!.getString('username')!;
      });
    }

    if(fullname != userProfileUsername){
      setState(() {
        fullname = userProfileFullname;
        fullnameController.text = userProfileFullname;
      });
      prefs.setString('username', username);
    } else if(fullname == userProfileFullname){
      setState(() {
        fullname = prefs!.getString('username')!;
        fullnameController.text = prefs!.getString('username')!;
      });
    }

    if(email != userProfileEmail){
      setState(() {
        email = userProfileEmail;
        emailController.text = userProfileEmail;
      });
      prefs.setString('email', email);
    } else if(email == userProfileEmail){
      setState(() {
        emailController.text = prefs!.getString('email')!;
        email = prefs!.getString('email')!;
      });
    }
  }*/

  loadDetails() async {
    // Load data from SharedPreferences
    username = prefs.getString('username') ?? '';
    usernameController.text = prefs.getString('username') ?? '';
    email = prefs.getString('email') ?? '';
    emailController.text = prefs.getString('email') ?? '';
    fullname = prefs.getString('fullname') ?? '';
    fullnameController.text = prefs.getString('fullname') ?? '';
    currentUserID = prefs.getString('currentUserID') ?? '';
    passwordController.text = prefs.getString('password') ?? '';
    password = prefs.getString('password') ?? '';

    UserRepository userRepository = UserRepository();
    final userProfile = await userRepository.getUserProfile();

    String userProfileUsername = userProfile?['username'] ?? '';
    String userProfileFullname = userProfile?['fullname'] ?? '';
    String userProfileEmail = userProfile?['email'] ?? '';

    // Compare and update the profile details
    if (username != userProfileUsername) {
      setState(() {
        username = userProfileUsername;
        usernameController.text = userProfileUsername;
      });
      prefs.setString('username', username);
    }

    if (fullname != userProfileFullname) {
      setState(() {
        fullname = userProfileFullname;
        fullnameController.text = userProfileFullname;
      });
      prefs.setString('fullname', fullname);
    }

    if (email != userProfileEmail) {
      setState(() {
        email = userProfileEmail;
        emailController.text = userProfileEmail;
      });
      prefs.setString('email', email);
    }
  }

  logoutMessage() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('SUCCESS!', style: kLightSemiBoldTextStyle,),
          content: const Text('You have logged out successfully!', style: kLightSemiBoldTextStyle),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: kLightSemiBoldTextStyle),
              onPressed: () {
                Navigator.pushNamed(context, '/main_screen');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()),);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          endDrawerEnableOpenDragGesture: false,
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
            title: Text('Profile Page', style:TextStyle(color: kWhiteColor),),
            backgroundColor: kThemeBlueColor,
          ),
          body: uploading == false ? RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Center(
                    child: Column(
                      children: [
                        TextField(
                          controller: usernameController,
                          onChanged:(value){
                            setState(() {
                              username = value;
                            });
                          },
                          style: kLightSemiBoldTextStyle,
                          decoration: textInputDecoration('Username',),
                        ),
                        const SizedBox(height:20),
                        TextField(
                          controller: fullnameController,
                          onChanged:(value){
                            setState(() {
                              fullname = value;
                            });
                          },
                          style: kLightSemiBoldTextStyle,
                          decoration: textInputDecoration('Full Name',),
                        ),
                        const SizedBox(height:20),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged:(value){
                            setState(() {
                              email = value;
                            });
                          },
                          style: kLightSemiBoldTextStyle,
                          decoration: textInputDecoration('Email',),
                        ),
                        const SizedBox(height:20),
                        TextField(
                          controller: passwordController,
                          obscureText: _passwordVisible == false ? true : false,
                          onChanged:(value){
                            setState(() {
                              password = value;
                            });
                          },
                          style: kLightSemiBoldTextStyle,
                          decoration: passwordInputDecoration(
                              'Password',
                              _passwordVisible,
                                  (){
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              }
                          ),
                        ),
                        const SizedBox(height:10),
                        const Text("In case you do not see your password and want to update it, you can just enter the new password and press 'Update' button.", style: kRegularRedText),
                        const SizedBox(height:20),
                        RoundedButton(
                          colour:kLightTitleColor,
                          title:'Update Profile',
                          onPress:null,
                        ),
                        const SizedBox(height:10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundedButton(
                              colour:kDarkTitleColor,
                              title:'Logout',
                              onPress:() async {
                                prefs = await SharedPreferences.getInstance();
                                prefs.setBool('isLoggedIn', isLoggedIn);
                                prefs.setString('email', '');
                                prefs.setString('username', '');
                                prefs.setString('password', '');
                                prefs.setString('avatarImage', '');
                                prefs.setString('currentUserID', '');
                                prefs.setString('userID', '');
                                setState(() {
                                  isLoggedIn = false;
                                  currentUserID = '';
                                  token = '';
                                  // _signOut();
                                  logoutMessage();
                                });
                              },
                            ),
                            RoundedButton(
                              colour:kRedColor,
                              title:'Delete',
                              onPress:() async{
                                prefs = await SharedPreferences.getInstance();
                                setState(() {
                                  // triggerDeleteProfile('WARNING', 'Are you sure you want to delete your profile?');
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              ),
            ),
          ) :
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kLightTitleColor),
              backgroundColor: Colors.transparent,
              strokeWidth: 5,
            ),
          ),
        )
    );
  }
}
