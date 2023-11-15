import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  final int tasksPeding;
  const CardHome({this.tasksPeding = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xffed8965),
              Color(0xfff63222),
            ],
          ),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.all(20),
                  child: Row(
                    children: [
                      Text(
                        "$tasksPeding",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "Tarefas Pendentes",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
