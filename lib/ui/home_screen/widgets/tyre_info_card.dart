import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../models/tyre_psi.dart';

class TyreInfoCard extends StatelessWidget {
  const TyreInfoCard({
    Key? key,
    required this.isBottomTyre,
    required this.tyrePsi,
  }) : super(key: key);

  final bool isBottomTyre;
  final TyrePsi tyrePsi;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color:
            tyrePsi.isLowPressure ? redColor.withOpacity(0.1) : Colors.white10,
        border: Border.all(
          color: tyrePsi.isLowPressure ? redColor : primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: isBottomTyre
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (tyrePsi.isLowPressure)
                  _lowPressureText(context)
                else
                  const SizedBox(),
                const Spacer(),
                _psiText(context, psiText: '${tyrePsi.psi}'),
                const SizedBox(height: defaultPadding),
                Text(
                  '${tyrePsi.temp} \u2103',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _psiText(context, psiText: '${tyrePsi.psi}'),
                const SizedBox(height: defaultPadding),
                Text(
                  '${tyrePsi.temp} \u2103',
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                if (tyrePsi.isLowPressure)
                  _lowPressureText(context)
                else
                  const SizedBox(),
              ],
            ),
    );
  }

  Widget _lowPressureText(BuildContext context) {
    return Column(
      children: [
        Text(
          'LOW',
          style: Theme.of(context).textTheme.headline3?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        const Text('PRESSURE', style: TextStyle(fontSize: 20)),
      ],
    );
  }

  Widget _psiText(BuildContext context, {required String psiText}) {
    return Text.rich(
      TextSpan(
        text: psiText,
        style: Theme.of(context).textTheme.headline4?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
        children: const [
          TextSpan(text: 'psi', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
