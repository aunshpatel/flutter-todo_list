import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/todo/todo_bloc.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/screens/widgets/consts.dart';
import 'package:todo_list/screens/widgets/side_drawer.dart';
import 'package:sticky_headers/sticky_headers.dart';

class AllTodosPage extends StatefulWidget {
  const AllTodosPage({super.key});

  @override
  State<AllTodosPage> createState() => _AllTodosPageState();
}

class _AllTodosPageState extends State<AllTodosPage> {
  late TodoBloc _todoBloc;
  bool _isVisible = false;
  @override
  void initState() {
    super.initState();
    _todoBloc = context.read<TodoBloc>();
    _todoBloc.add(GetTodosEvent()); // Fetch todos when page loads
  }

  void _updateFilter(String key, String value) {
    final currentState = _todoBloc.state;
    if (currentState is TodoLoaded) {
      final updatedFilters = currentState.filters.copyWith(
        status: key == "status" ? value : currentState.filters.status,
        priority: key == "priority" ? value : currentState.filters.priority,
        startDateOrder: key == "startDateOrder" ? value : currentState.filters.startDateOrder,
        statusOrder: key == "statusOrder" ? value : currentState.filters.statusOrder,
        priorityOrder: key == "priorityOrder" ? value : currentState.filters.priorityOrder,
      );
      _todoBloc.add(UpdateFiltersEvent(updatedFilters));
    }
  }

  void _clearFilters() {
    _todoBloc.add(UpdateFiltersEvent(const TodoFilters()));
  }

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
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    //Filters
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                      child:  SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: StickyHeader(
                          header: Card(
                            color: kThemeBlueColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    if(_isVisible == false) {
                                      _isVisible = true;
                                    } else  {
                                      _isVisible = false;
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _isVisible == true ? Text('Hide Filters', style: kWhiteBoldSize18Text,) : Text('Show Filters', style: kWhiteBoldSize18Text,),
                                    SizedBox(width: 10,),
                                    Icon(Icons.filter_list_sharp, color: kWhiteColor, size: 24.0)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          content: Visibility(
                            visible: _isVisible,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Wrap(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text('Status Filter:', style: kSideMenuBlueSize16Text,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: _buildDropdown("Default", ["", "Pending", "In-Progress", "Completed"], "status"),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    //Sorting dropdown
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text('Priority Filter:', style: kSideMenuBlueSize16Text,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: _buildDropdown("Default", ["", "Low", "Medium", "High"], "priority"),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text('Start Date Order:', style: kSideMenuBlueSize16Text,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child:  _buildDropdown("Default", ["", "Ascending", "Descending"], "startDateOrder"),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text('Status Order:', style: kSideMenuBlueSize16Text,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: _buildDropdown("Default", ["", "Ascending", "Descending"], "statusOrder"),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text('Priority Order:', style: kSideMenuBlueSize16Text,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: _buildDropdown("Default", ["", "Ascending", "Descending"], "priorityOrder"),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    //Search button
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                          onPressed: _clearFilters,
                                          color: kThemeBlueColor,
                                          child: const Text('Clear All Filters', style: kWhiteBoldSize18Text,),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Data
                    Padding(
                      padding:  const EdgeInsets.fromLTRB(8, 10, 8, 0),
                      child: SizedBox(
                        height:MediaQuery.of(context).size.height - 190,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
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
                                },
                              )
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Center(child: Text('No Todos Available', style: kHomePageTitle,));
        },
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> options, String key) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        String selectedValue = "";
        if (state is TodoLoaded) {
          final filters = state.filters;
          selectedValue = key == "status" ? filters.status : key == "priority" ? filters.priority : key == "startDateOrder" ? filters.startDateOrder : key == "statusOrder" ? filters.statusOrder : key == "priorityOrder" ? filters.priorityOrder : "";
        }

        return DropdownButton<String>(
          value: selectedValue,
          hint: Text(label),
          onChanged: (value) {
            _updateFilter(key, value ?? "");
          },
          items: options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option.isEmpty ? label : option),
            );
          }).toList(),
        );
      },
    );
  }
}

