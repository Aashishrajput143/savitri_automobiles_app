class AppFonts {
  static final AppFonts appFonts = AppFonts._internal();
  factory AppFonts() {
    return appFonts;
  }
  AppFonts._internal();

  get muliLang => 'MULI-LIGHT';
  get robots => 'RobotoSlab';
  get robotsRegular => 'RobotsRegular';
}

AppFonts appFonts = AppFonts();
