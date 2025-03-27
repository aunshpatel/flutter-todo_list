import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'consts.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: kThemeBlueColor,
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              //Image
              Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                height: 200,
                child: Image.asset('assets/images/todo-list-white-transparent-bg.png')
              ),
              //Home Screen
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: kWhiteColor,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text('Home Screen', style:kSideMenuWhiteSize20Text),
                  onTap: (){
                    Navigator.pushNamed(context, '/home_page');
                  },
                ),
              ),
              //About Us Screen
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: kWhiteColor,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text('About Us', style:kSideMenuWhiteSize20Text),
                  onTap: (){
                    Navigator.pushNamed(context, '/about_us');
                  },
                ),
              ),
              if(!isLoggedIn)...[
                //Login Screen
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text('Login', style:kSideMenuWhiteSize20Text),
                    onTap: (){
                      Navigator.pushNamed(context, '/login_page');
                    },
                  ),
                ),
                //Registration Screen
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text('Registration', style:kSideMenuWhiteSize20Text),
                    onTap: (){
                      Navigator.pushNamed(context, '/registration_page');
                    },
                  ),
                ),
              ],
              if(isLoggedIn)...[
                //Create A Todo
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text('Create A Todo', style:kSideMenuWhiteSize20Text),
                    onTap: (){
                      Navigator.pushNamed(context, '/create_todo_page');
                    },
                  ),
                ),
                //View All Todo
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text('View All Todos', style:kSideMenuWhiteSize20Text),
                    onTap: (){
                      Navigator.pushNamed(context, '/view_all_todos');
                    },
                  ),
                ),
                //Profile
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text('Profile', style:kSideMenuWhiteSize20Text),
                    onTap: (){
                      Navigator.pushNamed(context, '/profile_page');
                    },
                  ),
                ),
              ],
              //Privacy Policy & Contact Us
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: kWhiteColor,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      child: const Text('Privacy Policy', style: kSideMenuWhiteSize16Text,),
                      onPressed: () {
                        launchUrl(Uri.parse('https://realestate-vgcw.onrender.com/mobileapp-privacy-policy'));
                      },
                    ),
                    TextButton(
                      child: Text('Contact Us', style: kSideMenuWhiteSize16Text,),
                      onPressed: () {
                        launchUrl(Uri.parse('https://the-todo-list.onrender.com/contact-us'));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
