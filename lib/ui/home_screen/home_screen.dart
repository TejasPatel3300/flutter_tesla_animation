import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_animation/ui/home_screen/widgets/tyres.dart';
import '../../constants/assets.dart';
import '../../constants/constants.dart';
import '../../controllers/home_controller.dart';

import 'widgets/battery_status_widget.dart';
import 'widgets/door_lock.dart';
import 'widgets/temp_button.dart';
import 'widgets/temp_details.dart';
import 'widgets/tesla_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _homeController = HomeController();

  late final AnimationController _batteryAnimationController;
  late final Animation<double> _animationBattery;
  late final Animation<double> _animationBatteryStatus;

  late final AnimationController _tempAnimationController;
  late final Animation<double> _animationCarShift;
  late final Animation<double> _animationShowTempDetail;
  late final Animation<double> _animationGlow;

  @override
  void initState() {
    super.initState();
    _setUpBatteryAnimationController();
    _setUpTempAnimationController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(
        [
          _homeController,
          _batteryAnimationController,
          _tempAnimationController
        ],
      ),
      builder: (context, _) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNavigationBar(
              selectedTab: _homeController.selectedBottomTabIndex,
              onTap: (value) {
                if (value == 1) {
                  _batteryAnimationController.forward();
                } else if (_homeController.selectedBottomTabIndex == 1 &&
                    value != 1) {
                  _batteryAnimationController.reverse(from: 0.6);
                }

                if (value == 2) {
                  _tempAnimationController.forward();
                } else if (_homeController.selectedBottomTabIndex == 2 &&
                    value != 2) {
                  _tempAnimationController.reverse(from: 0.4);
                }
                _homeController.showTyreController(value);
                _homeController.onSelectedBottomTabChange(index: value);
              }),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(alignment: Alignment.center, children: [
                  SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                  ),
                  Positioned(
                    left: constraints.maxWidth / 2 * _animationCarShift.value,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: constraints.maxHeight * 0.1),
                      child:
                          SvgPicture.asset(Assets.car, width: double.infinity),
                    ),
                  ),
                  AnimatedPositioned(
                    right: _homeController.selectedBottomTabIndex == 0
                        ? constraints.maxWidth * 0.05
                        : constraints.maxWidth / 2,
                    duration: defaultDuration,
                    child: AnimatedOpacity(
                      opacity:
                          _homeController.selectedBottomTabIndex == 0 ? 1 : 0,
                      duration: defaultDuration,
                      child: DoorLock(
                        onTap: _homeController.updateRightDoorLock,
                        isLock: _homeController.isRightDoorLock,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    left: _homeController.selectedBottomTabIndex == 0
                        ? constraints.maxWidth * 0.05
                        : constraints.maxWidth / 2,
                    duration: defaultDuration,
                    child: AnimatedOpacity(
                      opacity:
                          _homeController.selectedBottomTabIndex == 0 ? 1 : 0,
                      duration: defaultDuration,
                      child: DoorLock(
                        onTap: _homeController.updateLeftDoorLock,
                        isLock: _homeController.isLeftDoorLock,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    top: _homeController.selectedBottomTabIndex == 0
                        ? constraints.maxHeight * 0.17
                        : constraints.maxHeight / 2,
                    duration: defaultDuration,
                    child: AnimatedOpacity(
                      opacity:
                          _homeController.selectedBottomTabIndex == 0 ? 1 : 0,
                      duration: defaultDuration,
                      child: DoorLock(
                        onTap: _homeController.updateBonnetDoorLock,
                        isLock: _homeController.isBonnetLock,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    bottom: _homeController.selectedBottomTabIndex == 0
                        ? constraints.maxHeight * 0.17
                        : constraints.maxHeight / 2,
                    duration: defaultDuration,
                    child: AnimatedOpacity(
                      opacity:
                          _homeController.selectedBottomTabIndex == 0 ? 1 : 0,
                      duration: defaultDuration,
                      child: DoorLock(
                        onTap: _homeController.updateTrunkDoorLock,
                        isLock: _homeController.isTrunkLock,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: _animationBattery.value,
                    child: SvgPicture.asset(Assets.battery,
                        width: constraints.maxWidth * 0.4),
                  ),
                  // carshift
                  Positioned(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    top: 50 * (1 - _animationBatteryStatus.value),
                    child: Opacity(
                      opacity: _animationBatteryStatus.value,
                      child: BatteryStatus(constraints: constraints),
                    ),
                  ),
                  Positioned(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    top: 70 * (1 - _animationShowTempDetail.value),
                    child: Opacity(
                      opacity: _animationShowTempDetail.value,
                      child: TempDetails(homeController: _homeController),
                    ),
                  ),
                  Positioned(
                    right: -100 * (1 - _animationGlow.value),
                    width: 200,
                    child: AnimatedSwitcher(
                      duration: defaultDuration,
                      child: _homeController.isCoolTempSelected
                          ? Image.asset(
                              Assets.coolGlow,
                              key: UniqueKey(),
                              width: 200,
                            )
                          : Image.asset(
                              Assets.hotGlow,
                              key: UniqueKey(),
                              width: 200,
                            ),
                    ),
                  ),
                  // tyre
                  if (_homeController.isShowTyre)
                    ...getTyres(constraints)
                  else
                    const SizedBox(),
                  GridView.builder(
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: defaultPadding,
                      mainAxisSpacing: defaultPadding,
                      childAspectRatio:
                          constraints.maxWidth / constraints.maxHeight,
                    ),
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        border: Border.all(color: primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        children: [Text.rich(TextSpan())],
                      ),
                    ),
                  )
                ]);
              },
            ),
          ),
        );
      },
    );
  }

  void _setUpBatteryAnimationController() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.0, 0.5),
    );

    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.6, 1),
    );
  }

  void _setUpTempAnimationController() {
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.2, 0.4),
    );

    _animationShowTempDetail = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.5, 0.6),
    );

    _animationGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.7, 1),
    );
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    super.dispose();
  }
}
