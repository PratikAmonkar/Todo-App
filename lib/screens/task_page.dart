import 'package:flutter/material.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_card_widget.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Todo> todos = [];
  int taskId = 0;
  bool titlePresent = false;

  TextEditingController taskTitle = TextEditingController();
  TextEditingController todoTitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    // refreshTodos().whenComplete(
    //   () {
    //     setState(() {});
    //   },
    // );
  }

  Future<void> refreshTodos() async {
    await TodoDatabase.instance.getTodos(taskId).then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, true);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 6.0,
                left: 15.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: taskTitle,
                      enabled: titlePresent ? false : true,
                      decoration: const InputDecoration(
                        hintText: "Enter task title",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      // onChanged: (value) {
                      //   if (value != "") {
                      //     setState(() {
                      //       titlePresent = true;
                      //     });
                      //   } else {
                      //     setState(
                      //       () {
                      //         titlePresent = false;
                      //       },
                      //     );
                      //   }
                      // },
                      onSubmitted: (value) async {
                        if (value != "") {
                          Task _newTask = Task(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .remainder(100000)
                                .toInt(),
                            title: value,
                          );
                          taskId =
                              await TodoDatabase.instance.insertTask(_newTask);
                          // print("After getting from database id = ${taskId}");
                          refreshTodos();
                          setState(() {
                            titlePresent = true;
                          });
                        }
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Text("Completed 5 of 10",style: TextStyle(
                color:Colors.black,
                fontWeight: FontWeight.bold,
              ),),
            ),
            Expanded(
              child: FutureBuilder(
                initialData: const [],
                future: TodoDatabase.instance.getTodos(taskId),
                builder: (context, snapshot) {
                  return ScrollConfiguration(
                    behavior: NoGlowBehaviour(),
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        return TodoCardWidget(
                          title: todos[index].title.toString(),
                          index: index + 1,
                          createdDate: todos[index].createdDate,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 50.0,
              ),
              padding: const EdgeInsets.only(
                left: 12.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: taskId != 0
                        ? TextField(
                            controller: todoTitle,
                            decoration: const InputDecoration(
                              hintText: "Enter todo here....",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onSubmitted: (value) async {
                              if (value != "") {
                                Todo _newTodo = Todo(
                                  id: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .remainder(100000)
                                      .toInt(),
                                  taskId: taskId,
                                  title: value,
                                  isDone: 0,
                                  createdDate: DateTime.now().toString(),
                                );
                                await TodoDatabase.instance.insertTodos(
                                  _newTodo,
                                );
                              }
                              setState(
                                () {
                                  refreshTodos();
                                  todoTitle.text = "";
                                },
                              );
                            },
                          )
                        : const Text(
                            "",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
