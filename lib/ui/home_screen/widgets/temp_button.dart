import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/constants.dart';

class TempButton extends StatelessWidget {
  const TempButton({
    Key? key,
    required this.icon,
    required this.text,
    this.isActive = false,
    required this.onPress,
    required this.activeColor,
  }) : super(key: key);

  final String icon;
  final String text;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOutBack,
            height: isActive ? 76 : 50,
            width: isActive ? 76 : 50,
            child: SvgPicture.asset(
              icon,
              color: isActive ? activeColor : Colors.white30,
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              fontSize: 16,
              color: isActive ? activeColor : Colors.white30,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
