import 'package:flutter/material.dart';

class TodoCardWidget extends StatelessWidget {
  const TodoCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            margin: const EdgeInsets.only(
              right: 12.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                6.0,
              ),
              border: Border.all(
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.check,
            ),
          ),
          const Text(
            "Unnamed todo",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
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