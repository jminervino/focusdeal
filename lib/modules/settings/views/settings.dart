import 'package:flutter/material.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffed8965),
                  Color(0xfff63222),
                ],
              ),
            ),
            child: Column(
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const Text(
                        "Perfil",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.75,
              widthFactor: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff1f2326),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Perfil",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      buildButtonActivity(Icons.person, "Detalhes da conta", 'profile'),
                      buildButtonActivity(Icons.edit_document, "Documentos"),
                      const Spacer(),
                      buildButtonActivity(Icons.lock, "Alterar senha", 'changePassword'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25 - 30,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: const CircleAvatar(
              radius: 32,
              backgroundColor: Color(0xff2E5975),
              child: Icon(Icons.person),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25 - 30,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.camera_alt_rounded,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonActivity(IconData icon, String btnName, [String profile = '']) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, profile);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    btnName,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
              const Icon(
                Icons.keyboard_arrow_right_sharp,
                color: Colors.white,
              ),
            ],
          ),
        ),
        const Divider(
          color: Color.fromARGB(78, 158, 158, 158),
        )
      ],
    );
  }
}
