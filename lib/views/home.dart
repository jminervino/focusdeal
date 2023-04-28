import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => null, child: const Icon(Icons.add)),
      appBar: AppBar(title: Row()),
      body: ListView(
        children: [Text("Olá João"), Text("Categorias"), Text("Tarefas")],
      ),
    );
  }
}
