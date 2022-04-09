import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/screens/task_page.dart';
import 'package:todo_app/widgets/task_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool isDataEmpty = false;

  @override
  Widget build(BuildContext context) {
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
                child: ListView(
                  children: const [
                    TaskCardWidget(
                      title: 'demo 1',
                      description:
                          'fdsfsdfgsdjfbsd  fdgdfgdfgdfgdfgdsfgdfg fdsgsdfgdfh sdg fddfg fdgdfgdfg sdafg fsdfsdgddfgdfgdfgdfgdfsg dsfdsgwsefadfsfgd hdsgsdfgsgsaASFD GSFGDFGDFGDFG FG',
                    ),
                    TaskCardWidget(
                      title: 'demo 2',
                      description: 'fdsfsdfgsdjfbsd',
                    ),
                    TaskCardWidget(
                      title: 'demo 3',
                      description: 'fdsfsdfgsdjfbsd dsf',
                    ),
                    TaskCardWidget(),
                  ],
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
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
