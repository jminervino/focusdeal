import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/components/home/card_categorie.dart';
import 'package:todo_list/enums/categories.dart';
import 'package:todo_list/enums/importancia.dart';
import 'package:todo_list/models/tasks/tasks.dart';
import 'package:todo_list/views/task_detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<AnimatedListState> _listKey1 = GlobalKey();
  GlobalKey<AnimatedListState> _listKey2 = GlobalKey();
  TextEditingController _qtMetaController = TextEditingController();
  TextEditingController _nometaskController = TextEditingController();
  TaskCategory _categoriaSelecionada = TaskCategory.Educacao;
  Importancia _importanciaSelecionada = Importancia.BaixaPrioridade;

  String dataAtual = "";
  bool loading = false;
  List<Tasks> pendingTasks = [];
  List<Tasks> completedTasks = [];

  @override
  void initState() {
    super.initState();

    getDateNow();
    getTasks();
  }

  void getTasks() async {
    FirebaseFirestore.instance.collection("tasks").get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        Tasks task = Tasks.fromJson(doc.data());
        if (task.completed!) {
          completedTasks.add(task);
        } else {
          pendingTasks.add(task);
        }
      });
    });
  }

  void createTask() {
    CollectionReference tasks = FirebaseFirestore.instance.collection("tasks");

    FirebaseFirestore.instance
        .collection("tasks")
        .orderBy("id", descending: true)
        .limit(1)
        .get()
        .then((snapshot) {
      int nextId =
          snapshot.docs.isNotEmpty ? snapshot.docs.first.data()['id'] + 1 : 1;
      Tasks task = Tasks(
          id: nextId,
          categorie: _categoriaSelecionada.name.toString(),
          name: _nometaskController.text,
          qtMeta: int.parse(_qtMetaController.text),
          qtCumpridas: 0,
          completed: false);
      tasks.doc("task$nextId").set(task.toMap());
      Navigator.pop(context);
      setState(() {
        pendingTasks.add(task);
      });

      _listKey1.currentState!.insertItem(pendingTasks.length - 1);
      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (context) => Home()), (route) => false);
    });
  }

  getDateNow() {
    DateTime date = DateTime.now();
    dataAtual = DateFormat(" d 'de' MMMM 'de' y").format(date);
  }

  void _showAddTaskBottomSheet() {
    showModalBottomSheet(
      backgroundColor: const Color(0xff1f2326),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              children: [
                const Text(
                  "Adicionar Tarefa",
                  style: TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: _nometaskController,
                  decoration: InputDecoration(
                      hintText: "Nome da Tarefa",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 128, 128, 128))),
                ),
                TextField(
                  controller: _qtMetaController,
                  decoration: InputDecoration(
                      hintText: "Meta",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 128, 128, 128))),
                ),
                DropdownButtonFormField(
                    hint: Text(
                      "Selecione a categoria",
                      style: TextStyle(color: const Color(0xfffa7360)),
                    ),
                    items: TaskCategory.values.map((categoria) {
                      return DropdownMenuItem(
                          value: categoria, child: Text(categoria.name));
                    }).toList(),
                    onChanged: (categoria) {
                      setState(() {
                        _categoriaSelecionada = categoria!;
                      });
                    }),
                DropdownButtonFormField(
                    hint: Text(
                      "Importancia",
                      style:
                          TextStyle(color: Color.fromARGB(255, 96, 124, 250)),
                    ),
                    items: Importancia.values.map((importancia) {
                      return DropdownMenuItem(
                          value: importancia, child: Text(importancia.name));
                    }).toList(),
                    onChanged: (importancia) {
                      setState(() {
                        _importanciaSelecionada = importancia!;
                      });
                    }),
                ElevatedButton(
                    onPressed: () => createTask(), child: Text("Criar"))
              ],
            ),
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f2326),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xfffa7360),
          onPressed: () {
            setState(() {
              _showAddTaskBottomSheet();
            });
          },
          child: const Icon(Icons.add)),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      dataAtual,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 121, 121, 121),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: const [
                    Text(
                      "Focusdail",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 26),
                    )
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Color(0xffed8965), Color(0xfff63222)])),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.all(20),
                          child: Row(
                            children: [
                              Text(
                                " ${pendingTasks.length}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28),
                              ),
                              SizedBox(width: 5),
                              Text("Tarefas Pendentes",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
          SizedBox(height: 20),
          // Expanded(
          //   flex: 1,
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 24),
          //     child: SizedBox(
          //       height: 70.0,
          //       child: ListView.builder(
          //           itemCount: TaskCategory.values.length,
          //           scrollDirection: Axis.horizontal,
          //           padding: EdgeInsets.zero,
          //           itemBuilder: (_, i) {
          //             TaskCategory categorieSelected = TaskCategory.values
          //                 .firstWhere((categoria) => categoria.index == i);
          //             return CardCategorie(categorie: categorieSelected);
          //           }),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
          //   child: TextField(
          //     decoration: InputDecoration(
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(30)),
          //         filled: true,
          //         hintText: "Pesquise habitos",
          //         hintStyle: TextStyle(color: Color(0xff6c7280)),
          //         fillColor: Color(0xff3e4653),
          //         prefixIcon: const Icon(
          //           Icons.search,
          //           color: Color(0xff6c7280),
          //         )),
          //     onChanged: (value) => null,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Row(
              children: [
                Icon(Icons.filter_list_rounded, color: Color(0xFFE6EDFF)),
                Text(
                  "Filtrar",
                  style: TextStyle(color: Color(0xFFE6EDFF)),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Text("Tarefas",
                style: TextStyle(
                    color: Color(0xFFE6EDFF),
                    fontSize: 20,
                    fontWeight: FontWeight.w400)),
          ),

          // const Radio(value: 1, groupValue: 1, onChanged: null),
          // loading
          //     ? const Center(child: CircularProgressIndicator())
          //     : pendingTasks .isNotEmpty
          //         ? Column(
          //             children:
          //                 pendingTasks .map((e) => CardTask(taskInfos: e)).toList())
          //         : const Center(
          //             child: Text(
          //             "Não tem tarefas no momento",
          //             style: TextStyle(color: Colors.grey),
          //           )),
          pendingTasks.isNotEmpty
              ? Expanded(
                  child: AnimatedList(
                      key: _listKey1,
                      shrinkWrap: true,
                      initialItemCount: pendingTasks.length,
                      itemBuilder: (context, index, animation) =>
                          _buildCardTask1(
                              index, pendingTasks[index], animation)),
                )
              : const Center(
                  child: Text("Não há tarefas pendentes",
                      style: TextStyle(color: Color(0xffed8965))),
                ),
          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Text("Tarefas Concluidas",
                style: TextStyle(
                    color: Color(0xFFE6EDFF),
                    fontSize: 20,
                    fontWeight: FontWeight.w400)),
          ),
          completedTasks.isNotEmpty
              ? Expanded(
                  child: AnimatedList(
                      key: _listKey2,
                      shrinkWrap: true,
                      initialItemCount: completedTasks.length,
                      itemBuilder: (context, index, animation) =>
                          _buildCardTask2(
                              index, completedTasks[index], animation)),
                )
              : const Center(
                  child: Text(
                  "Não há tarefas concluidas",
                  style: TextStyle(color: Color(0xffed8965)),
                )),
          const SizedBox(height: 20),

          // SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCardTask1(int index, Tasks task, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 24, left: 24),
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskDetails(taskInfos: task))),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xff3e4653),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Checkbox(
                    value: task.completed,
                    onChanged: (value) {
                      setState(() {
                        task.completed = value!;
                        removeListPending(index);
                      });
                    }),
                Flexible(
                    child: Text(
                  task.name!,
                  style: TextStyle(
                      color: Colors.white,
                      decoration:
                          task.completed! ? TextDecoration.lineThrough : null),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardTask2(int index, Tasks task, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 24, left: 24),
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskDetails(taskInfos: task))),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xff3e4653),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Checkbox(
                      value: task.completed,
                      onChanged: (value) {
                        setState(() {
                          task.completed = value!;
                          removeListCompleted(index);
                        });
                      }),
                  Flexible(
                      child: Text(
                    task.name!,
                    style: TextStyle(
                        color: Colors.white,
                        decoration: task.completed!
                            ? TextDecoration.lineThrough
                            : null),
                  ))
                ],
              ),
            ),
          )),
    );
  }

  void removeListPending(int index) {
    Tasks task = pendingTasks[index];
    _listKey1.currentState!.removeItem(
        index, (context, animation) => _buildCardTask1(index, task, animation));
    pendingTasks.removeAt(index);

    completedTasks.add(task);
    _listKey2.currentState?.insertItem(completedTasks.length - 1);
  }

  void removeListCompleted(int index) {
    Tasks task = completedTasks[index];
    _listKey2.currentState!.removeItem(
        index, (context, animation) => _buildCardTask2(index, task, animation));
    completedTasks.removeAt(index);

    pendingTasks.add(task);
    _listKey1.currentState?.insertItem(pendingTasks.length - 1);
  }
}
