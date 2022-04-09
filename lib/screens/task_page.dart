import 'package:flutter/material.dart';
import 'package:todo_app/widgets/todo_card_widget.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
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
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter task title",
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 12.0,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter description here....",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
                  const TodoCardWidget(),
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
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter todo here....",
                        border: InputBorder.none,
                      ),
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
