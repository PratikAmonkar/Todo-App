import 'package:flutter/material.dart';
// import 'package:todo_app/database/database_helper.dart';

class TodoCardWidget extends StatelessWidget {
  final String title;
  final int index;
  final String createdDate;
  // final int priority
  const TodoCardWidget({
    Key? key,
    required this.title,
    required this.index,
    required this.createdDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(createdDate);
    var formattedDate = "${date.day}/${date.month}/${date.year}";
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  index.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Created:- $formattedDate",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              // Text(
              //   "Priority low",
              //   style: TextStyle(
              //     color: Colors.white,
              //   ),
              // ),r
            ],
          )
        ],
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
