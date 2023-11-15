import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/controllers/task_controller.dart';
import 'package:todo_list/core/models/tasks/tasks.dart';

class TaskDetails extends StatefulWidget {
  final Tasks taskInfos;

  const TaskDetails({required this.taskInfos, super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState(taskInfos);
}

class _TaskDetailsState extends State<TaskDetails> {
  final Tasks taskInfos;
  int percentage = 0;
  final TextEditingController _taskNameController = TextEditingController();
  bool modoEdit = false;

  @override
  void initState() {
    super.initState();
    _taskNameController.text = taskInfos.name!;
  }

  _TaskDetailsState(this.taskInfos) {
    calculatePercentage();
  }

  calculatePercentage() {
    percentage = ((taskInfos.qtCumpridas! / taskInfos.qtMeta!) * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffed8965),
                  Color(0xfff63222),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const Text(
                        "Detalhes da Tarefa",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                modoEdit = !modoEdit;
                              });
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    actionsPadding: const EdgeInsets.all(14.0),
                                    actions: [
                                      Center(
                                        child: Image.asset('assets/images/icon-alert.png'),
                                      ),
                                      const SizedBox(height: 4),
                                      const Center(
                                        child: Text(
                                          "Tem Certeza?",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      const Text(
                                        "Está ação não pode ser revertida, todas os valores associados a essa tarefa serão apagados!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(255, 87, 87, 87),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Theme.of(context).primaryColor,
                                              ),
                                              onPressed: () => _deleteTask(),
                                              child: const Text("Deletar Tarefa"),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                  side: const BorderSide(color: Colors.black),
                                                ),
                                                elevation: 0,
                                                backgroundColor: Colors.transparent,
                                              ),
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text(
                                                "Cancelar",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  );
                                }),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF444444),
                    child: Text(
                      "$percentage%",
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  enabled: modoEdit,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  controller: _taskNameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.65,
              widthFactor: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff1f2326),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Meta Geral: ${taskInfos.qtMeta}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Cumpridas: ${taskInfos.qtCumpridas}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _deleteTask() async {
    final taskController = Provider.of<TaskController>(context, listen: false);
    taskController.deleteTask(taskInfos.id!);
    Navigator.pop(context);
  }
}
