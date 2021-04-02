import 'package:flutter/material.dart';

class StepWidget extends StatelessWidget {
  final int step;
  const StepWidget({
    Key key,
    this.step,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                step == 1 ? Colors.grey.shade100 : Colors.grey.shade800,
            child: Text("1"),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          CircleAvatar(
            backgroundColor:
                step == 2 ? Colors.grey.shade100 : Colors.grey.shade800,
            child: Text("2"),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          CircleAvatar(
            backgroundColor:
                step == 3 ? Colors.grey.shade100 : Colors.grey.shade800,
            child: Text("3"),
          ),
        ],
      ),
    );
  }
}
