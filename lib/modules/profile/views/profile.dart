import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/core/services/local_storage.dart';
import 'package:todo_list/modules/profile/components/container_info.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = "";
  String userEmail = "";

  final _localStorageService = LocalStorageService();

  void getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('user_name') ?? "";
    userEmail = prefs.getString('user_email') ?? "";

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [],
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(),
              const SizedBox(height: 20),
              ContainerInfo(
                labelText: "Nome",
                infoUser: userName,
                icon: Icons.person_outline,
                preffixIcon: Icons.edit,
              ),
              const Divider(height: 14, color: Colors.transparent),
              ContainerInfo(
                labelText: "Email",
                infoUser: userEmail,
                icon: Icons.email_outlined,
              ),
              const Divider(height: 14, color: Colors.transparent),
              const ContainerInfo(
                labelText: "Senha",
                infoUser: "*******",
                icon: Icons.lock_outlined,
              ),
              const Divider(height: 30, color: Colors.transparent),
              ElevatedButton(
                onPressed: () => logout(),
                child: const Text("Sair"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void logout() async {
    await _localStorageService.clearUser();
    Navigator.pushReplacementNamed(context, "splashScreen");
  }
}
