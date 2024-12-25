class AppUrl {
  //Development
  //static const String baseUrl = 'https://php8.singsys.net/gis/server/public/api';

  //Staging
  static const String baseUrl = 'http://13.203.113.27';

  //Authenication
  static String login = '$baseUrl/api/user/login';
  static String logout = '$baseUrl/api/logout/currentSession';

  // Post
  static String gettractor = '$baseUrl/api/tractor/get-all';
  static String getimplement = '$baseUrl/api/equipement/get-all';
  static String addsalesentry = '$baseUrl/api/sales/sales-entry';
  static String getsalesentry = '$baseUrl/api/sales/get-all-sales';
  static String getsalesentrydetails = '$baseUrl/api/sales/get/';

  // static String getcategory =
  //     '$baseUrl/api/category/getallcategory?page=1&pageSize=10';
  // static String getbrand = '$baseUrl/api/brand/getall?page=';
  // static String getbranddetails = '$baseUrl/api/brand/getby/';

  // post
}
