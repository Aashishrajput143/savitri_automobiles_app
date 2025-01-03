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
  static String getspareparts = '$baseUrl/api/sparePart/get-all';
  static String getserviceentry = '$baseUrl/api/service/get-all-service';
  static String getoil = '$baseUrl/api/oil/get-all';
  static String addserviceentry = '$baseUrl/api/service/service-entry';
  static String getserviceentrydetail = '$baseUrl/api/service/get/';
  static String tractorinventory = '$baseUrl/api/tractor/edit-specification';
  static String implementinventory = '$baseUrl/api/equipement/edit';
  static String sparepartinventory = '$baseUrl/api/sparePart/edit';
  static String oilinventory = '$baseUrl/api/oil/edit';
  static String getusers = '$baseUrl/api/admin/getUsers';

  // static String getcategory =
  //     '$baseUrl/api/category/getallcategory?page=1&pageSize=10';
  // static String getbrand = '$baseUrl/api/brand/getall?page=';
  // static String getbranddetails = '$baseUrl/api/brand/getby/';

  // post
}
