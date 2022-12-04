import 'package:flutter/material.dart';
import 'package:tesla_animation/ui/home_screen/widgets/temp_button.dart';

import '../../../constants/assets.dart';
import '../../../constants/constants.dart';
import '../../../controllers/home_controller.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    Key? key,
    required HomeController homeController,
  })  : _homeController = homeController,
        super(key: key);

  final HomeController _homeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            child: Row(
              children: [
                TempButton(
                  isActive: _homeController.isCoolTempSelected,
                  icon: Assets.coolShape,
                  text: 'COOL',
                  activeColor: primaryColor,
                  onPress: _homeController.updateCoolTempSelected,
                ),
                const SizedBox(width: defaultPadding),
                TempButton(
                  isActive: !_homeController.isCoolTempSelected,
                  icon: Assets.heatShape,
                  text: 'HEAT',
                  activeColor: redColor,
                  onPress: _homeController.updateCoolTempSelected,
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_up, size: 48),
              ),
              const Text('20 \u2103', style: TextStyle(fontSize: 86)),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_down, size: 48),
              ),
            ],
          ),
          const Spacer(),
          Text('CURRENT TEMPERATURE'),
          const SizedBox(height: defaultPadding),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('INSIDE'),
                  Text(
                    '20 \u2103',
                    style: Theme.of(context).textTheme.headline5,
                  )
                ],
              ),
              const SizedBox(width: defaultPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'OUTSIDE',
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                  Text(
                    '50 \u2103',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: Colors.white54),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
