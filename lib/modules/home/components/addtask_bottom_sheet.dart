import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/controllers/task_controller.dart';
import 'package:todo_list/enums/categories.dart';
import 'package:todo_list/enums/importancia.dart';
import 'package:todo_list/core/models/tasks/tasks.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final TextEditingController _qtMetaController = TextEditingController();
  final TextEditingController _nometaskController = TextEditingController();

  TaskCategory? _categoriaSelecionada;
  Importancia? _importanciaSelecionada;

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context, listen: false);

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
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Nome da Tarefa",
                  hintStyle: TextStyle(
                    color: Color(0xFF808080),
                  ),
                ),
              ),
              TextField(
                controller: _qtMetaController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Meta",
                  hintStyle: TextStyle(
                    color: Color(0xFF808080),
                  ),
                ),
              ),
              DropdownButtonFormField(
                  style: const TextStyle(color: Color(0xfffa7360)),
                  hint: const Text(
                    "Selecione a categoria",
                    style: TextStyle(
                      color: Color(0xfffa7360),
                    ),
                  ),
                  items: TaskCategory.values.map((categoria) {
                    return DropdownMenuItem(
                      value: categoria,
                      child: Text(categoria.name),
                    );
                  }).toList(),
                  onChanged: (categoria) {
                    setState(() {
                      _categoriaSelecionada = categoria!;
                    });
                  }),
              DropdownButtonFormField(
                style: const TextStyle(color: Color(0xFF607CFA)),
                hint: const Text(
                  "Importancia",
                  style: TextStyle(color: Color(0xFF607CFA)),
                ),
                items: Importancia.values.map((importancia) {
                  return DropdownMenuItem(
                    value: importancia,
                    child: Text(importancia.name),
                  );
                }).toList(),
                onChanged: (importancia) {
                  setState(() {
                    _importanciaSelecionada = importancia!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  Tasks task = Tasks(
                    categorie: _categoriaSelecionada!.name,
                    importancia: _importanciaSelecionada,
                    completed: false,
                    qtCumpridas: 0,
                    name: _nometaskController.text,
                    qtMeta: int.parse(_qtMetaController.text),
                  );
                  await taskController.createTask(task);
                  Navigator.pop(context);
                },
                /* createTask() */
                child: const Text("Criar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
