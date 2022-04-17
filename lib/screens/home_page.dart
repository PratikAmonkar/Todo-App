import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/task_page.dart';
import 'package:todo_app/screens/update_todo_page.dart';
import 'package:todo_app/widgets/task_card_widget.dart';
import 'package:todo_app/widgets/todo_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];
  String isPresent = "0";

  @override
  void initState() {
    super.initState();
    refreshTodos().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> refreshTodos() async {
    await TodoDatabase.instance.getTasks().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 10.0,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
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
                    return tasks.isNotEmpty
                        ? ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: ListView.builder(
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateTodoPage(
                                          tasksId: tasks[index].id,
                                          title: tasks[index].title.toString(),
                                        ),
                                      ),
                                    ).then((value) {
                                      refreshTodos();
                                      setState(() {});
                                    });
                                  },
                                  child: TaskCardWidget(
                                    title: tasks[index].title.toString(),
                                  ),
                                );
                              },
                            ),
                          )
                        : Image.asset(
                            'images/data_empty.png',
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskPage(),
            ),
          ).then((value) {
            refreshTodos();
            setState(() {});
          });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
