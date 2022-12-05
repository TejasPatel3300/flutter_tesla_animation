import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_animation/models/tyre_psi.dart';
import 'package:tesla_animation/ui/home_screen/widgets/tyres.dart';
import '../../constants/assets.dart';
import '../../constants/constants.dart';
import '../../controllers/home_controller.dart';

import 'widgets/battery_status_widget.dart';
import 'widgets/door_lock.dart';
import 'widgets/temp_button.dart';
import 'widgets/temp_details.dart';
import 'widgets/tesla_bottom_navigation.dart';
import 'widgets/tyre_info_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _homeController = HomeController();

  // battery
  late final AnimationController _batteryAnimationController;
  late final Animation<double> _animationBattery;
  late final Animation<double> _animationBatteryStatus;

  // temperature
  late final AnimationController _tempAnimationController;
  late final Animation<double> _animationCarShift;
  late final Animation<double> _animationShowTempDetail;
  late final Animation<double> _animationGlow;

  // tyre
  late final AnimationController _tyreAnimationController;
  late final Animation<double> _animationTyre1Psi;
  late final Animation<double> _animationTyre2Psi;
  late final Animation<double> _animationTyre3Psi;
  late final Animation<double> _animationTyre4Psi;

  final List<Animation<double>> _tyreAnimationList = [];

  @override
  void initState() {
    super.initState();
    _setUpBatteryAnimationController();
    _setUpTempAnimationController();
    _setUpTyreAnimationController();
    _tyreAnimationList.addAll(
      [
        _animationTyre1Psi,
        _animationTyre2Psi,
        _animationTyre3Psi,
        _animationTyre4Psi,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(
        [
          _homeController,
          _batteryAnimationController,
          _tempAnimationController,
          _tyreAnimationController,
        ],
      ),
      builder: (context, _) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNavigationBar(
              selectedTab: _homeController.selectedBottomTabIndex,
              onTap: (index) {
                if (index == 1) {
                  _batteryAnimationController.forward();
                } else if (_homeController.selectedBottomTabIndex == 1 &&
                    index != 1) {
                  _batteryAnimationController.reverse(from: 0.6);
                }

                if (index == 2) {
                  _tempAnimationController.forward();
                } else if (_homeController.selectedBottomTabIndex == 2 &&
                    index != 2) {
                  _tempAnimationController.reverse(from: 0.4);
                }

                if (index == 3) {
                  _tyreAnimationController.forward();
                } else if (_homeController.selectedBottomTabIndex == 3 &&
                    index != 3) {
                  _tyreAnimationController.reverse();
                }
                _homeController.showTyreController(index);
                _homeController.tyreStatusController(index);

                // we switch the tabs after every transition related configurations are done
                _homeController.onSelectedBottomTabChange(index: index);
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
                  if (_homeController.isShowTyreController)
                    ...getTyres(constraints)
                  else
                    const SizedBox(),
                  if (_homeController.isShowTyreStatus)
                    GridView.builder(
                      itemCount: 4,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: defaultPadding,
                        mainAxisSpacing: defaultPadding,
                        childAspectRatio:
                            constraints.maxWidth / constraints.maxHeight,
                      ),
                      itemBuilder: (context, index) => ScaleTransition(
                        scale: _tyreAnimationList[index],
                        child: TyreInfoCard(
                          isBottomTyre: index > 1,
                          tyrePsi: demoPsiList[index],
                        ),
                      ),
                    )
                  else
                    const SizedBox(),
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

  void _setUpTyreAnimationController() {
    _tyreAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // waiting for car to slide-in in first 400 miliseconds
    _animationTyre1Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.34, 0.5),
    );
    _animationTyre2Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.5, 0.66),
    );
    _animationTyre3Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.66, 0.82),
    );
    _animationTyre4Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.82, 1),
    );
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationController.dispose();
    super.dispose();
  }
}
