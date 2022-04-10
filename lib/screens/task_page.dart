import 'package:flutter/material.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/widgets/todo_card_widget.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key, task}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  // DatabaseHelper _databaseHelper = DatabaseHelper();

  String? _taskTitle;
  String? _taskDescription;
  String? _todoTitle;

  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  TextEditingController todoTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 217, 252),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 217, 252),
        automaticallyImplyLeading: false,
        toolbarHeight: 5.0,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
                bottom: 6.0,
                left: 15.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: taskTitle,
                      decoration: const InputDecoration(
                        hintText: "Enter task title",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _taskTitle = value;
                        });
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 12.0,
              ),
              child: TextField(
                controller: taskDescription,
                decoration: const InputDecoration(
                  hintText: "Enter description here....",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _taskDescription = value;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView(
                children: const [
                  TodoCardWidget(),
                  TodoCardWidget(),
                  TodoCardWidget(),
                  TodoCardWidget(),
                  TodoCardWidget(),
                  TodoCardWidget(),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 70.0,
              ),
              padding: const EdgeInsets.only(
                left: 12.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoTitle,
                      decoration: const InputDecoration(
                        hintText: "Enter todo here....",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _todoTitle = value;
                        });
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text(
          "Save todo",
        ),
        icon: const Icon(
          Icons.check,
        ),
      ),
    );
  }
}
