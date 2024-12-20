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
  static get cultivator => 'assets/images/cultivator.png';
  static get harrow => 'assets/images/harrow.png';
  static get plough => 'assets/images/plough.png';
  static get rotary => 'assets/images/rotary.png';
  static get volvo => 'assets/images/Volvo.png';
  static get pillowblock => 'assets/images/pillowblock.png';
  static get electronicclutch => 'assets/images/electronicclutch.png';
  static get fuelfilter => 'assets/images/fuelfilter.png';
  static get gearbox => 'assets/images/Gearbox.png';
  static get motul => 'assets/images/motul.png';
  static get gtx => 'assets/images/gtx.png';
  static get edge => 'assets/images/edge.png';
  static get magnetic => 'assets/images/magnetic.png';

  //icons
  static get searchIcon => 'assets/icons/searchIcon.svg';

  static final AppImages _appImages = AppImages._internal();
  factory AppImages() {
    return _appImages;
  }
  AppImages._internal();
}

AppImages appImages = AppImages();
