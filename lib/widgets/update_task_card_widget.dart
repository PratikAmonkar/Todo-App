import 'package:flutter/material.dart';

class UpdateTodoCardWidget extends StatelessWidget {
  final String title;
  final int index;
  final String createdDate;
  final int isDone;
  const UpdateTodoCardWidget({
    Key? key,
    required this.title,
    required this.index,
    required this.createdDate,
    required this.isDone,
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
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        color: isDone == 1 ? Colors.grey : Colors.purple,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: isDone == 1
                    ? const Icon(
                        Icons.check_box_outlined,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.square_outlined,
                        color: Colors.white,
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
            height: 5.0,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  "Created on:- $formattedDate",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
