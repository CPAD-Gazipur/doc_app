import 'package:doc_app/utils/config.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const SocialLoginButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        side: const BorderSide(
          width: 1,
          color: Colors.black,
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: Config.widthSize * 0.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/$title.png',
              width: 35,
              height: 35,
            ),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
