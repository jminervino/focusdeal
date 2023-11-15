import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/controllers/task_controller.dart';
import 'package:todo_list/core/models/tasks/tasks.dart';
import 'package:todo_list/modules/home/components/addtask_bottom_sheet.dart';
import 'package:todo_list/modules/home/components/card_home.dart';

import 'package:todo_list/modules/home/components/card_task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String dataAtual = "";
  String? name;
  bool loading = false;
  List<Tasks> pendingTasks = [];

  @override
  void initState() {
    super.initState();
    getDateNow();
    getTasks();
  }

  getDateNow() {
    DateTime date = DateTime.now();

    dataAtual = DateFormat(" d 'de' MMMM 'de' y", 'pt_BR').format(date);
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void _showAddTaskBottomSheet() {
    showModalBottomSheet(
      backgroundColor: const Color(0xff1f2326),
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) => const AddTaskBottomSheet(),
    );
  }

  void showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 30.0, // ajuste conforme necessário para posicionar corretamente
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(33, 150, 243, 1), // cor do SnackBar
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(message),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  void getTasks() async {
    await Provider.of<TaskController>(context, listen: false).getTask();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(builder: (context, taskProvider, child) {
      List<Tasks> tasks = taskProvider.tasks;

      return ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          backgroundColor: const Color(0xff1f2326),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xfffa7360),
            onPressed: () => _showAddTaskBottomSheet(),
            child: const Icon(Icons.add),
          ),
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Color(0xFF797979),
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          dataAtual,
                          style: const TextStyle(
                            color: Color(0xFF797979),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Focusdail",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 26,
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, "userSettings"),
                          child: const CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 68, 68, 68),
                            child: Icon(Icons.person, size: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CardHome(tasksPeding: taskProvider.tasks.length),
              const SizedBox(height: 20),
              // const ListCardsCategories(),
              // const SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              //       filled: true,
              //       hintText: "Pesquise habitos",
              //       hintStyle: const TextStyle(color: Color(0xff6c7280)),
              //       fillColor: const Color(0xff3e4653),
              //       prefixIcon: const Icon(
              //         Icons.search,
              //         color: Color(0xff6c7280),
              //       ),
              //     ),
              //     onChanged: (value) => null,
              //   ),
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(
              //     vertical: 10,
              //     horizontal: 24,
              //   ),
              //   child: Row(
              //     children: [
              //       Icon(
              //         Icons.filter_list_rounded,
              //         color: Color(0xFFE6EDFF),
              //       ),
              //       Text(
              //         "Filtrar",
              //         style: TextStyle(
              //           color: Color(0xFFE6EDFF),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 24,
                ),
                child: Text(
                  "Tarefas",
                  style: TextStyle(
                    color: Color(0xFFE6EDFF),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: taskProvider.tasks.length,
                  itemBuilder: (_, i) {
                    return CardTask(
                      task: tasks[i],
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }

  // Widget _buildCardTask1(int index, Tasks task, Animation<double> animation) {
  //   return SizeTransition(
  //     sizeFactor: animation,
  //     child: CardTask(
  //       task: task,
  //       onChanged: (value) {
  //         setState(() {
  //           task.completed = value!;
  //           removeListPending(index);
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _buildCardTask2(int index, Tasks task, Animation<double> animation) {
  //   return SizeTransition(
  //     sizeFactor: animation,
  //     child: CardTask(
  //       task: task,
  //       onChanged: (value) {
  //         setState(() {
  //           task.completed = value!;
  //           removeListCompleted(index);
  //         });
  //       },
  //     ),
  //   );
  // }

  // void removeListPending(int index) {
  //   Tasks task = pendingTasks[index];
  //   _listKey1.currentState!
  //       .removeItem(index, (context, animation) => _buildCardTask1(index, task, animation));
  //   pendingTasks.removeAt(index);

  //   completedTasks.add(task);
  //   _listKey2.currentState?.insertItem(completedTasks.length - 1);
  // }

  // void removeListCompleted(int index) {
  //   Tasks task = completedTasks[index];
  //   _listKey2.currentState!
  //       .removeItem(index, (context, animation) => _buildCardTask2(index, task, animation));
  //   completedTasks.removeAt(index);

  //   pendingTasks.add(task);
  //   _listKey1.currentState?.insertItem(pendingTasks.length - 1);
  // }
}
