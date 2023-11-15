import 'package:flutter/material.dart';

enum TypeCustomSnack { Success, Error }

class CustomSnackBar {
  static const Map<TypeCustomSnack, Color> _colors = {
    TypeCustomSnack.Success: Color(0xFF11C182),
    TypeCustomSnack.Error: Color(0xFFB71C1C)
  };

  static const Map<TypeCustomSnack, IconData> _icons = {
    TypeCustomSnack.Success: Icons.verified,
    TypeCustomSnack.Error: Icons.error
  };

  static const Map<TypeCustomSnack, String> _messagesTop = {
    TypeCustomSnack.Success: "Sucesso",
    TypeCustomSnack.Error: "Erro"
  };

  static void show(BuildContext context, String message, TypeCustomSnack type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _colors[type],
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.vertical,
        elevation: 3,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          // padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(
                _icons[type],
                color: Colors.white,
                size: 35,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _messagesTop[type]!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    message,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
