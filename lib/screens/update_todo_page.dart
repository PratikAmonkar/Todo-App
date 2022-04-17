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
  var isCompleted = [];

   int todoCompleted = 0;
   int taskCounts = 0;

  final bool isDataEmpty = false;
  bool todoDelete = false;
  bool isDataNotEmpty = false;

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
        taskCounts = todo.length;
      });
    });
    await TodoDatabase.instance
        .getCompletedTodos(widget.tasksId, 1)
        .then((value) {
      setState(() {
        isCompleted = value;
        todoCompleted = isCompleted.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      onSubmitted: (value) async {
                        if (value != "") {
                          await TodoDatabase.instance.updateTaskTitle(
                            widget.tasksId,
                            value,
                          );
                          setState(() {
                            widget.title = value;
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Text(
                "Completed $todoCompleted of $taskCounts",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
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
                        return Dismissible(
                          key: Key(todo[index].id.toString()),

                          onDismissed: (direction) async {
                            await TodoDatabase.instance
                                .deleteTodo(todo[index].id);
                            setState(() {
                              refreshTodos();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'item dismissed',
                                ),
                              ),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              if (todo[index].isDone == 1) {
                                await TodoDatabase.instance
                                    .updateTodoDone(todo[index].id, 0);
                                refreshTodos();
                              } else {
                                await TodoDatabase.instance
                                    .updateTodoDone(todo[index].id, 1);
                                refreshTodos();
                              }
                            },
                            child: UpdateTodoCardWidget(
                              title: todo[index].title.toString(),
                              index: index + 1,
                              createdDate: todo[index].createdDate,
                              isDone: todo[index].isDone,
                            ),
                          ),
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
                    child: TextField(
                      controller: todoTitle,
                      decoration: const InputDecoration(
                        hintText: "Enter todo here....",
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) async {
                        if (value != "") {
                          Todo _newTodo = Todo(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .remainder(100000)
                                .toInt(),
                            taskId: widget.tasksId,
                            title: value,
                            isDone: 0,
                            createdDate: DateTime.now().toString(),
                          );
                          await TodoDatabase.instance.insertTodos(
                            _newTodo,
                          );
                          setState(
                            () {
                              refreshTodos();
                              todoTitle.text = "";
                            },
                          );
                        }
                      },
                    ),
                  ),
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