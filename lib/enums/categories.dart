enum TaskCategory {
  // ignore: constant_identifier_names
  Negocios,
  Saude,
  Educacao,
  Profissional,
  Pessoal,
  Lazer,
  Social
}

extension TaskCategoryExtension on TaskCategory {
  String get name => this.toString().split('.').last;
}

TaskCategory taskCategoryFromString(String str) {
  return TaskCategory.values.firstWhere(
    (e) => e.name == str,
  );
}
