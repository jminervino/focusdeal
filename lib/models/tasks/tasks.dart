import 'package:todo_list/enums/importancia.dart';

class Tasks {
  int? id;
  String? categorie;
  String? name;
  int? qtMeta;
  Importancia? importancia;
  int? qtCumpridas;
  bool? completed;

  Tasks(
      {this.id,
      this.categorie,
      this.name,
      this.qtMeta,
      this.importancia,
      this.qtCumpridas,
      this.completed});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // categorie = TaskCategory.values.firstWhere(
    //     (e) => e.name.toLowerCase() == json['categorie'].toLowerCase());
    categorie = json['categorie'];
    name = json['name'];
    qtMeta = json['qtd_meta'];
    qtCumpridas = json['qtd_cumpridas'];
    completed = json['completed'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categorie': categorie,
      'name': name,
      'qtd_meta': qtMeta,
      'qtd_cumpridas': qtCumpridas,
      'completed': completed
    };
  }
}
