import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/screens/widgets/consts.dart';
import 'package:todo_list/screens/widgets/side_drawer.dart';
import '../blocs/todo/todo_bloc.dart';
import '../models/todo_model.dart';

class CreateATodo extends StatefulWidget {
  const CreateATodo({super.key});

  @override
  State<CreateATodo> createState() => _CreateATodoState();
}

class _CreateATodoState extends State<CreateATodo> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  String startDate = '', endDate = '', startTime = '', endTime = '';
  late DateTime? selectedStartDate, selectedEndDate;

  TimeOfDay selectedStartTime = TimeOfDay.now(), selectedEndTime = TimeOfDay.now();

  String _status = 'Pending';
  String _priority = 'Low';
  bool _allDay = false;

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h:mm a').format(dt);
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      barrierDismissible: false,
      initialTime: selectedStartTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? SizedBox(),
        );
      },
    );

    // if (pickedTime != null && pickedTime != selectedStartTime) {
    if (pickedTime != null) {
      setState(() {
        selectedStartTime = pickedTime;
        _startTimeController.text = formatTimeOfDay(pickedTime);
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
      barrierDismissible: false,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? SizedBox(),
        );
      },
    );

    //if (pickedTime != null && pickedTime != selectedEndTime) {
    if (pickedTime != null) {
      setState(() {
        selectedEndTime = pickedTime;
        _endTimeController.text = formatTimeOfDay(pickedTime);
      });
    }
  }

  Future<void> _selectStartDate() async{
    selectedStartDate = await showDatePicker(
      context: context,
      barrierDismissible: false,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if(selectedStartDate != null) {
      setState(() {
        _startDateController.text = DateFormat('yMMMMd').format(selectedStartDate!);
        startDate = DateFormat('yMMMMd').format(selectedStartDate!);
        // selectedStartDate = pickedDate;
      });
    }
  }

  Future<void> _selectEndDate() async{
    selectedEndDate = await showDatePicker(
      context: context,
      barrierDismissible: false,
      firstDate: selectedStartDate ?? DateTime(1900),
      lastDate: DateTime(2200),
    );
    if(selectedEndDate != null) {
      setState(() {
        _endDateController.text = DateFormat('yMMMMd').format(selectedEndDate!);
        endDate = DateFormat('yMMMMd').format(selectedEndDate!);
        // selectedEndDate = pickedDate;
      });
    }
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text(title, style: kBlueBoldSize20Text),
          content: Text(message, style: kBlueSize18Text),
          actions: [
            TextButton(
              onPressed: () {
                if (title == "Success") {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/view_all_todos');
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text("OK", style: kBlueSize18Text),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoCreatedSuccess) {
          _showAlertDialog(context, "SUCCESS!", "Todo created successfully! You will be redirected to the todo list page.");
        } else if (state is TodoCreationFailure) {
          _showAlertDialog(context, "WARNING!", "Failed to create todo. Please try again.");
        }
      },
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
          title: Text('Create A Todo', style:TextStyle(color: kWhiteColor),),
          backgroundColor: kThemeBlueColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              // Title
              TextFormField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Title',
                  filled: true,
                  prefixIcon: Icon(Icons.title),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: kThemeBlueColor)),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Please enter a title' : null,
              ),
              SizedBox(height: 10),

              // Description
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: 'Description',
                  filled: true,
                  prefixIcon: Icon(Icons.description),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: kThemeBlueColor)),
                ),
              ),
              SizedBox(height: 10),

              // Start Date & Start Time (In One Row)
              Row(
                children: [
                  // Start Date
                  Expanded(
                    child: TextField(
                      controller: _startDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                        filled: true,
                        prefixIcon: Icon(Icons.calendar_today_sharp),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: kThemeBlueColor)),
                      ),
                      onTap: () {
                        _selectStartDate();
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  //Start Time
                  Expanded(
                    child: TextFormField(
                      controller: _startTimeController,
                      readOnly: true,
                      onTap: () {
                        _selectStartTime(context);
                      },
                      decoration: InputDecoration(
                        labelText: 'Start Time',
                        filled: true,
                        prefixIcon: Icon(Icons.access_time_rounded),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: kThemeBlueColor)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // End Date & End Time (In One Row)
              Row(
                children: [
                  // End Date
                  Expanded(
                    child: TextField(
                      controller: _endDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'End Date',
                        filled: true,
                        prefixIcon: Icon(Icons.calendar_today_sharp),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: kThemeBlueColor)),
                      ),
                      onTap: () {
                        _selectEndDate();
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  // End Time
                  Expanded(
                    child: TextFormField(
                      controller: _endTimeController,
                      readOnly: true,
                      onTap: () {
                        _selectEndTime(context);
                      },
                      decoration: InputDecoration(
                        labelText: 'End Time',
                        filled: true,
                        prefixIcon: Icon(Icons.access_time_rounded),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: kThemeBlueColor)),
                      ),
                      validator: (value) => value?.isEmpty ?? true ? 'Please enter a valid end time' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // All Day Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _allDay,
                    onChanged: (value) {
                      setState(() {
                        _allDay = value!;
                      });
                    },
                  ),
                  Text("All Day"),
                ],
              ),
              SizedBox(height: 10),

              // Status Dropdown
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(labelText: "Status"),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
                items: ['Pending', 'In-Progress', 'Completed'].map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status),
                )).toList(),
              ),
              SizedBox(height: 10),

              // Priority Dropdown
              DropdownButtonFormField<String>(
                value: _priority,
                decoration: InputDecoration(labelText: "Priority"),
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
                items: ['Low', 'Medium', 'High'].map((priority) => DropdownMenuItem(
                  value: priority,
                  child: Text(priority),
                )).toList(),
              ),
              SizedBox(height: 10),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Create Todo"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    final todo = Todo(title: _titleController.text, description: _descriptionController.text, startDate: _startDateController.text, endDate: _endDateController.text, startTime: _startTimeController.text, endTime: _endTimeController.text, status: _status, priority: _priority, allDay: _allDay, userRef: currentUserID);
    BlocProvider.of<TodoBloc>(context).add(CreateTodoEvent(todo: todo));
  }
}
