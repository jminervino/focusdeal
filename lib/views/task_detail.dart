import 'package:flutter/material.dart';
import 'package:todo_list/models/tasks/tasks.dart';

class TaskDetails extends StatefulWidget {
  final Tasks taskInfos;

  const TaskDetails({required this.taskInfos, super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState(taskInfos);
}

class _TaskDetailsState extends State<TaskDetails> {
  final Tasks taskInfos;
  int percentage = 0;
  _TaskDetailsState(this.taskInfos) {
    calculatePercentage();
  }

  calculatePercentage() {
    percentage = ((taskInfos.qtCumpridas! / taskInfos.qtMeta!) * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff1f2326),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Detalhes da Tarefa"),
                Row(
                  children: [Icon(Icons.edit), Icon(Icons.delete)],
                )
              ],
            )),
        body: Column(
          children: [
            Center(
              child: CircleAvatar(child: Text("$percentage%")),
            ),
            Text(taskInfos.name!,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
            Text("Meta Geral: ${taskInfos.qtMeta}"),
            Text("Cumpridas: ${taskInfos.qtCumpridas}")
          ],
        ));
  }
}
