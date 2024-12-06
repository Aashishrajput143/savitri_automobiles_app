class AppImages {
  //Images
  static get maatibackground => 'assets/images/maatibackground.jpeg';
  static get logo => 'assets/images/logo.png';
  static get logoicon => 'assets/images/logoicon.png';
  static get logodash => 'assets/images/logodash.png';
  static get logoblack => 'assets/images/logoblack.png';
  static get splashscreen => 'assets/images/splashscreen.png';
  static get swaraj735FE => 'assets/images/Swaraj735FE.png';
  static get swaraj735XT => 'assets/images/Swaraj735XT.png';
  static get tractor735FEePS => 'assets/images/735FEePS.png';
  static get tractor => 'assets/images/tractor.png';
  static get profile => 'assets/images/Profile.png';

  //icons
  static get searchIcon => 'assets/icons/searchIcon.svg';

  static final AppImages _appImages = AppImages._internal();
  factory AppImages() {
    return _appImages;
  }
  AppImages._internal();
}

AppImages appImages = AppImages();
