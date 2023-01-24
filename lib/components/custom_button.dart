import 'package:doc_app/utils/config.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final String title;
  final bool disable;
  final Function() onPressed;

  const CustomButton({
    Key? key,
    required this.width,
    required this.title,
    this.disable = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Config.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
        onPressed: disable ? null : onPressed,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
