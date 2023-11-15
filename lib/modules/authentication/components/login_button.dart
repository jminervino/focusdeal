// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;

  const LoginButton({
    Key? key,
    required this.text,
    required this.icon,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: const Color(0xFFEFEFEF),
          ),
          child: Row(
            children: [
              FaIcon(
                icon,
                color: iconColor,
              ),
              const SizedBox(width: 6),
              Text(
                text,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
