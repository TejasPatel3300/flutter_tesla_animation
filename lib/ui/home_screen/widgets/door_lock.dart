import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/assets.dart';
import '../../../constants/constants.dart';

class DoorLock extends StatelessWidget {
  const DoorLock({Key? key, required this.isLock, required this.onTap})
      : super(key: key);

  final bool isLock;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: defaultDuration,
        switchInCurve: Curves.easeInOutBack,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: isLock
            ? SvgPicture.asset(
                Assets.doorLock,
                key: const ValueKey('doorLock'),
              )
            : SvgPicture.asset(
                Assets.doorUnlock,
                key: const ValueKey('doorUnlock'),
              ),
      ),
    );
  }
}
