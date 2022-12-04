import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/assets.dart';

List<Widget> getTyres(BoxConstraints constraints) {
  return [
    Positioned(
      left: constraints.maxWidth * 0.2,
      top: constraints.maxHeight * 0.22,
      child: SvgPicture.asset(Assets.flTyre),
    ),
    Positioned(
      right: constraints.maxWidth * 0.2,
      top: constraints.maxHeight * 0.22,
      child: SvgPicture.asset(Assets.flTyre),
    ),
    Positioned(
      left: constraints.maxWidth * 0.2,
      bottom: constraints.maxHeight * 0.26,
      child: SvgPicture.asset(Assets.flTyre),
    ),
    Positioned(
      right: constraints.maxWidth * 0.2,
      bottom: constraints.maxHeight * 0.26,
      child: SvgPicture.asset(Assets.flTyre),
    ),
  ];
}
