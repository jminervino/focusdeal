import 'package:flutter/material.dart';
import 'package:todo_list/core/controllers/task_controller.dart';

import 'package:todo_list/core/models/tasks/tasks.dart';
import 'package:todo_list/modules/task/views/task_detail.dart';

class CardTask extends StatefulWidget {
  final Tasks task;
  const CardTask({required this.task, super.key});

  @override
  State<CardTask> createState() => _CardTaskState();
}

class _CardTaskState extends State<CardTask> {
  final taskController = TaskController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        right: 24,
        left: 24,
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetails(taskInfos: widget.task),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff3e4653),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                value: widget.task.completed,
                onChanged: (value) {
                  setState(() {
                    widget.task.completed = !widget.task.completed!;
                    taskController.updateTask(widget.task);
                  });
                },
              ),
              Flexible(
                child: Text(
                  widget.task.name!,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: widget.task.completed! ? TextDecoration.lineThrough : null,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
