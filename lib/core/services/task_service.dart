import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/core/models/tasks/tasks.dart';

class TaskService {
  final CollectionReference tasksCollection = FirebaseFirestore.instance.collection("tasks");

  // bool validaTask(Tasks task){
  //   if(task.)
  // }

  Future<void> create(Tasks task) async {
    DocumentReference docRef = tasksCollection.doc();
    task.id = docRef.id;
    docRef.set(task.toMap());
  }

  Future<List<Tasks>> get() async {
    List<Tasks> taskList = [];

    var snapshot = await tasksCollection.get();
    for (var doc in snapshot.docs) {
      Tasks task = Tasks.fromJson(doc.data() as Map<String, dynamic>);
      taskList.add(task);
    }

    return taskList;
  }

  Future<dynamic> update(infos) async {
    try {
      tasksCollection.doc(infos['id']).set(infos, SetOptions(merge: true));
      print("Documento atualizado com sucesso.");
    } catch (e) {
      print("erro ao atualizar a task $e");
    }
  }

  Future<void> delete(String taskId) async {
    try {
      await tasksCollection.doc(taskId).delete();
      print("Documento deletado com sucesso.");
    } catch (e) {
      print("erro ao deletar $e");
    }
  }
}
