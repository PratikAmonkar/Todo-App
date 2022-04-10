import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screens/task_page.dart';
import 'package:todo_app/widgets/task_card_widget.dart';
import 'package:todo_app/widgets/todo_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];
  // DatabaseHelper _databaseHelper = DatabaseHelper();
  final bool isDataEmpty = false;

  @override
  void initState() {
    super.initState();
    refreshTodos().whenComplete(() {
      setState(() {});
    });
  }

  // @override
  // void dispose() {
  //   TodoDatabase.instance.close();
  //   super.initState();
  // }

  Future<void> refreshTodos() async {
    // tasks = await TodoDatabase.instance.getTasks();
    await TodoDatabase.instance.getTasks().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(tasks.length);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 217, 252),
      appBar: AppBar(
        toolbarHeight: 10.0,
        backgroundColor: const Color.fromARGB(255, 232, 217, 252),
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Color.fromARGB(255, 232, 217, 252),
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: const Text(
                  "Todo",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  initialData: const [],
                  future: TodoDatabase.instance.getTasks(),
                  builder: (context, snapshot) {
                    return ScrollConfiguration(
                      behavior: NoGlowBehaviour(),
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskPage(
                                    task: tasks[index],
                                  ),
                                ),
                              ).then(
                                (value) {
                                  setState(() {});
                                },
                              );
                            },
                            child: TaskCardWidget(
                              title: tasks[index].title.toString(),
                              description: tasks[index].description.toString(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  height: 200.0,
                  width: 500.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter todo name",
                      ),
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      onSubmitted: (value) async {
                        if (value != "") {
                          Task _newTask = Task(
                            title: value,
                          );
                          await TodoDatabase.instance.insertTask(_newTask);
                          refreshTodos();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const TaskPage(),
          //   ),
          // );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
