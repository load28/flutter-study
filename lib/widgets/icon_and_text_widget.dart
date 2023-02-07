import 'package:flutter/cupertino.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;

  const IconAndTextWidget({Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
    this.color = const Color(0xFF332d2b),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
