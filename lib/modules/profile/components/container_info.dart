import 'package:flutter/material.dart';

class ContainerInfo extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final IconData? preffixIcon;
  final String infoUser;
  final void Function(bool? value)? onChanged;

  const ContainerInfo({
    this.onChanged,
    this.preffixIcon,
    required this.icon,
    required this.infoUser,
    required this.labelText,
    super.key,
  });

  @override
  State<ContainerInfo> createState() => _ContainerInfoState();
}

class _ContainerInfoState extends State<ContainerInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xfff4f4f4),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    widget.icon,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.labelText,
                      style: const TextStyle(
                        color: Color(0xFF747474),
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      widget.infoUser,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ],
            ),
            widget.preffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: IconButton(
                      onPressed: () => widget.onChanged,
                      icon: Icon(widget.preffixIcon),
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Container(),
            // labelText != "Senha"
            //     ? Container()
            //     : OutlinedButton(
            //         onPressed: () => Navigator.of(context).push(
            //           MaterialPageRoute(
            //             builder: (context) => const AlterarSenha(),
            //           ),
            //         ),
            //         style: ButtonStyle(
            //           side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
            //         ),
            //         child: Text(
            //           "Alterar",
            //           style: TextStyle(
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //       )
          ],
        ));
  }
}
