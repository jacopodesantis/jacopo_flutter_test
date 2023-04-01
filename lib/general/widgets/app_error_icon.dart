import 'package:flutter/material.dart';

class AppErrorIcon extends StatelessWidget {
  final double? size;

  const AppErrorIcon({this.size = 30, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: size! * 0.7,
          width: size! * 0.7,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
        Icon(
          Icons.error,
          color: const Color.fromRGBO(255, 61, 0, 1),
          size: size,
        ),
      ],
    );
  }
}
