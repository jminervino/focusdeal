import 'package:flutter/material.dart';
import 'package:todo_list/enums/categories.dart';
import 'package:todo_list/modules/home/components/card_categorie.dart';

class ListCardsCategories extends StatelessWidget {
  const ListCardsCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: SizedBox(
          height: 70.0,
          child: ListView.builder(
              itemCount: TaskCategory.values.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemBuilder: (_, i) {
                TaskCategory categorieSelected =
                    TaskCategory.values.firstWhere((categoria) => categoria.index == i);
                return CardCategorie(categorie: categorieSelected);
              }),
        ),
      ),
    );
  }
}
