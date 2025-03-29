import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/todo/todo_bloc.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/screens/widgets/consts.dart';
import 'package:todo_list/screens/widgets/side_drawer.dart';

class AllTodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(GetTodosEvent());
    return Scaffold(
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
        title: Text('All Todos', style:TextStyle(color: kWhiteColor),),
        backgroundColor: kThemeBlueColor,
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: Text("${index + 1}) Title: ${todo.title}", style: kBlueBoldSize20Text)),
                            if(todo.allDay == true)...[
                              Flexible(child: Text("All Day Event", style: kBlueBoldSize20Text)),
                            ]
                          ],
                        ),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("${index + 1}) ", style: kBlueBoldSize20Text),
                                SizedBox(width: 4),
                                Text("Title: ${todo.title}", style: kBlueBoldSize20Text, softWrap: true),
                              ],
                            ),
                            if(todo.allDay == true)...[
                              Flexible(child: Text("All Day Event", style: kBlueBoldSize20Text)),
                            ]
                          ],
                        ),
                        const Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Description:", style: kBoldSize18Text),
                            SizedBox(width: 10,),
                            Flexible(
                              child: Text(todo.description, style: kSemiBoldSize18Text),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("From:", style: kBoldSize18Text),
                            SizedBox(width: 10,),
                            Text("${todo.startDate} ${todo.startTime}", style: kSemiBoldSize18Text),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("To:", style: kBoldSize18Text),
                            SizedBox(width: 10,),
                            Text("${todo.endDate} ${todo.endTime}", style: kSemiBoldSize18Text),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Status:", style: kBoldSize18Text),
                            SizedBox(width: 10,),
                            Text(todo.status, style: kSemiBoldSize18Text),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Priority:", style: kBoldSize18Text,),
                            SizedBox(width: 10,),
                            Text(
                                todo.priority,
                                style: todo.priority == 'Low' ? kSemiBoldGreenSize18Text : (todo.priority == 'Medium' ? kSemiBoldYellowSize18Text : kSemiBoldRedSize18Text)
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
               /* return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                );*/
              },
            );
          }
          return Center(child: Text('No Todos Available', style: kHomePageTitle,));
        },
      ),
    );
  }
}
