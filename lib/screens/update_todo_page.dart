import 'package:flutter/material.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_card_widget.dart';
import 'package:todo_app/widgets/update_task_card_widget.dart';

class UpdateTodoPage extends StatefulWidget {
  final int tasksId;
  String title;
  UpdateTodoPage({
    Key? key,
    required this.tasksId,
    required this.title,
  }) : super(key: key);

  @override
  State<UpdateTodoPage> createState() => _UpdateTodoPageState();
}

class _UpdateTodoPageState extends State<UpdateTodoPage> {
  var todo = [];
  final bool isDataEmpty = false;
  bool todoDelete = false;
  // bool titlePresent = true;

  @override
  void initState() {
    super.initState();
    refreshTodos().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> refreshTodos() async {
    await TodoDatabase.instance.getTodos(widget.tasksId).then((value) {
      setState(() {
        todo = value;
      });
    });
    // print(tasks[0].title);
  }

  @override
  Widget build(BuildContext context) {
    // print(todo[0].id);
    // TextEditingController taskTitle = TextEditingController();
    TextEditingController todoTitle = TextEditingController();
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
                      controller: TextEditingController(
                        text: widget.title,
                      ),
                      // onSubmitted: () {},
                      decoration: const InputDecoration(
                        // hintText: "Enter task title",
                        border: InputBorder.none,
                      ),
                      // onChanged: (value) {
                      //   setState(() {
                      //     widget.title = value;
                      //   });

                      // TextEditingController.fromValue(value);
                      // if (value != "") {
                      //   setState(() {
                      //      titlePresent = true;
                      //   });
                      // } else {
                      //   setState(
                      //     () {
                      //       titlePresent = false;
                      //     },
                      //   );
                      // }
                      // },
                      onSubmitted: (value) async {
                        if (value != "") {
                          // Task _updatedTask = Task(
                          //   title: value,
                          // );

                          await TodoDatabase.instance.updateTaskTitle(
                            widget.tasksId,
                            value,
                          );
                          // refreshTodos();
                          setState(() {
                            widget.title = value;
                            // titlePresent = true;
                          });
                        }
                      },

                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                initialData: const [],
                future: TodoDatabase.instance.getTodos(
                  widget.tasksId,
                ),
                builder: (context, snapshot) {
                  return ScrollConfiguration(
                    behavior: NoGlowBehaviour(),
                    child: ListView.builder(
                      itemCount: todo.length,
                      itemBuilder: (context, index) {
                        return UpdateTodoCardWidget(
                          title: todo[index].title.toString(),
                          // todoId: todo[index].id,
                          index: index + 1,
                          createdDate: todo[index].createdDate,
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
                  // Expanded(
                  //   child: TextField(
                  //     controller: todoTitle,
                  //     decoration: const InputDecoration(
                  //       hintText: "Enter todo here....",
                  //       border: InputBorder.none,
                  //     ),
                  //     onSubmitted: (value) async {
                  //       if (value != "") {
                  //         Todo _newTodo = Todo(
                  //           taskId: widget.tasksId,
                  //           title: value,
                  //           isDone: 0,
                  //         );
                  //         await TodoDatabase.instance.insertTodos(
                  //           _newTodo,
                  //         );
                  //       }
                  //       setState(
                  //         () {
                  //           // refreshTodos();
                  //           todoTitle.text = "";
                  //         },
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          await TodoDatabase.instance.deleteTask(
            widget.tasksId,
          );
          Navigator.of(context).pop();
          // refreshTodos();
          // showMyDialog(context, widget.tasksId).whenComplete(
          //   () {
          //     refreshTodos();
          //     print(todo.isEmpty);
          //     // todo.isNotEmpty ? null : Navigator.of(context).pop();
          //     todo.isEmpty ? Navigator.of(context).pop() : null;
          //   },
          // );
          // refreshTodos();
          // if (todo.isEmpty) {
          //   Navigator.of(context).pop();
          // }

          // if (todoDelete) {
          //   Navigator.of(context).pop();
          // }
        },
        child: const Icon(
          Icons.delete_forever,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}

const snackBar = SnackBar(
  content: Text('Tasks deleted successfully'),
);

// Future<void> showMyDialog(context, tasksId) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Warning!!'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: const <Widget>[
//               Text(
//                 'Are you sure you want to delete task?.',
//               ),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Cancel'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             child: const Text('Yes'),
//             onPressed: () async {
//               await TodoDatabase.instance.deleteTask(
//                 tasksId,
//               );
//               // todoDelete =
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

// class NoGlowBehaviour extends ScrollBehavior {
//   @override
//   Widget buildViewportChrome(
//       BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }
// }