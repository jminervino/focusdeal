import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list/core/views/components/custom_snackbar.dart';
import 'package:todo_list/modules/authentication/controllers/auth_controller.dart';
import 'package:todo_list/modules/authentication/exceptions/auth_exception.dart';
import 'package:todo_list/modules/authentication/views/cadastro.dart';
import 'package:todo_list/modules/authentication/components/login_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg-login.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4,
                  sigmaY: 5,
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color(0xFF000000).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    // border: Border.all(
                    //   width: 1.5,
                    //   color: Colors.white.withOpacity(0.3),
                    // ),
                  ),
                  child: IntrinsicHeight(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: "Email",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _senhaController,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: "Senha",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () => _signIn(),
                                    child: const Text("Continuar"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  margin: const EdgeInsets.only(right: 12),
                                  color: Colors.grey,
                                ),
                              ),
                              const Text(
                                "Ou",
                                style: TextStyle(color: Colors.white),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  margin: const EdgeInsets.only(left: 12),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const LoginButton(
                            text: "Entrar com Facebook",
                            icon: FontAwesomeIcons.facebook,
                            iconColor: Color(0xff4267B2),
                          ),
                          const LoginButton(
                            text: "Entrar com Google",
                            icon: FontAwesomeIcons.google,
                            iconColor: Colors.red,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Ainda não tem conta?",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const Cadastro(),
                                  ),
                                ),
                                child: Text(
                                  "Cadastrar",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String senha = _senhaController.text;

    try {
      User? user = await _authController.signIn(email, senha);
      if (user != null) {
        Navigator.pushNamed(context, "home");
      }
    } catch (e) {
      if (e is AuthExceptions) {
        CustomSnackBar.show(context, e.message, TypeCustomSnack.Error);
      }
    }
  }
}
