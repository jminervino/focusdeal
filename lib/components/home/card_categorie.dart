import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/enums/categories.dart';
import 'package:todo_list/models/tasks/tasks.dart';

class CardCategorie extends StatefulWidget {
  final TaskCategory categorie;
  const CardCategorie({required this.categorie, super.key});

  @override
  State<CardCategorie> createState() => _CardCategorieState(categorie);
}

class _CardCategorieState extends State<CardCategorie> {
  final TaskCategory categorie;
  int qtdTasks = 0;
  _CardCategorieState(this.categorie) {
    getTasksPerCategories();
  }

  getTasksPerCategories() {
    FirebaseFirestore.instance.collection('tasks').get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        Tasks task = Tasks.fromJson(doc.data());
        if (task.categorie == categorie) {
          qtdTasks++;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 20),
        child: Container(
            padding: EdgeInsets.all(10),
            width: 150.0,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xff3e4653), Colors.red]),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$qtdTasks Tasks",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 10),
                ),
                const SizedBox(height: 3),
                Text(categorie.name,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500)),
              ],
            )));
  }
}
