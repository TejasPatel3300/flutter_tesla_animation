class Assets {
  Assets._internal();

  static final Assets _singleton = Assets._internal();
  factory Assets() => _singleton;

  static const String rootPath = 'assets/images/';
  static const String battery = '${rootPath}battery.svg';
  static const String car = '${rootPath}car.svg';
  static const String charge = '${rootPath}charge.svg';
  static const String coolShape = '${rootPath}cool_shape.svg';
  static const String doorLock = '${rootPath}door_lock.svg';
  static const String doorUnlock = '${rootPath}door_unlock.svg';
  static const String flTyre = '${rootPath}fl_tyre.svg';
  static const String heatShape = '${rootPath}heat_shape.svg';
  static const String lock = '${rootPath}lock.svg';
  static const String temp = '${rootPath}temp.svg';
  static const String tyre = '${rootPath}tyre.svg';
  static const String coolGlow = '${rootPath}cool_glow.png';
  static const String hotGlow = '${rootPath}hot_glow.png';
}
