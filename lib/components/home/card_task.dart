import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/tasks/tasks.dart';
import 'package:todo_list/views/home.dart';
import 'package:todo_list/views/task_detail.dart';

class CardTask extends StatefulWidget {
  final Tasks taskInfos;
  const CardTask({required this.taskInfos, super.key});

  @override
  State<CardTask> createState() => _CardTaskState(taskInfos);
}

class _CardTaskState extends State<CardTask> {
  TextEditingController tarefaNameController = TextEditingController();
  final Tasks taskInfos;

  final FocusNode _focusNode = FocusNode();

  taskConcluided(bool value) {
    CollectionReference tasks = FirebaseFirestore.instance.collection("tasks");
    if (value) {
      tasks.doc("task${taskInfos.id}").update(
          {'qtd_cumpridas': taskInfos.qtCumpridas! + 1, 'completed': true});
    } else {
      tasks.doc("task${taskInfos.id}").update(
          {'qtd_cumpridas': taskInfos.qtCumpridas! - 1, 'completed': false});
    }

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Home()), (route) => false);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  _CardTaskState(this.taskInfos);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 24, left: 24),
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskDetails(taskInfos: taskInfos))),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xff3e4653),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Checkbox(
                    value: taskInfos.completed,
                    onChanged: (value) {
                      setState(() {
                        taskInfos.completed = value!;
                        // taskConcluided(taskInfos.completed!);
                      });
                    }),
                Flexible(
                    child: Text(
                  taskInfos.name!,
                  style: TextStyle(
                      color: Colors.white,
                      decoration: taskInfos.completed!
                          ? TextDecoration.lineThrough
                          : null),
                ))
              ],
            ),
          ),
        ));
  }
}
