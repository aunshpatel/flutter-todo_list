import 'package:flutter/material.dart';
import 'package:todo_list/screens/widgets/consts.dart';
import 'package:todo_list/screens/widgets/side_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              title: Text('Home Screen', style:TextStyle(color: kWhiteColor),),
              backgroundColor: kThemeBlueColor,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Wrap(
                        children: [
                          Text("Welcome to", style: kHomePageTitle),
                          Text("The Todo List", style: kHomePageTitle),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}
