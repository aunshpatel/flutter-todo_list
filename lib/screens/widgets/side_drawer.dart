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
              SizedBox(
                  height: 200,
                  child: Image.asset('assets/images/todo-list-white-transparent-bg.png')
              ),
              //Home Screen
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: kBlackColor,
                        )
                    )
                ),
                child: ListTile(
                  title: Text('Home Screen', style:kSideMenuWhiteTextStyle),
                  onTap: (){
                    Navigator.pushNamed(context, '/home_page');
                  },
                ),
              ),
              //Privacy Policy
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: kBlackColor,
                    ),
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      child: const Text('Privacy Policy', style: kSideMenuWhiteSize16Style,),
                      onPressed: () {
                        launchUrl(Uri.parse('https://realestate-vgcw.onrender.com/mobileapp-privacy-policy'));
                      },
                    ),
                    TextButton(
                      child: Text('Contact Us', style: kSideMenuWhiteSize16Style,),
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
