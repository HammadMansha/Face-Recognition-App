class ApiData {
  //-----------------------Base url--------
  static const String baseUrl = "http://110.93.212.136:3000";
  //---------------------All API's call end points------------
  static const String authApi = "";
  //--------------------Verify invitation OTP--------------
  static const String verifyInviteOtp = "/invitations/code/verify";
  //-------------------Register new user-----------------
  static const String registerUser = "/users";
  //-------------------Login user-----------------
  static const String loginUser = "/auth/login";
  //------------------Alert Api-----------------

  static const String alertStream = '/events/alert-stream';
  static const String alertJobs = '/alerts';

  //------------------------Thumbnail base url----------------------
  static const String thumbnailBaseUrl = "https://backend.lytics.systems/uploads/";
  static const String tvVideoBaseUrl="https://actus.lytics.systems/Videos/";
  static const String otherVideoBaseUrl="https://backend.lytics.systems/uploads/";


  // static const String thumbnailBaseUrl = "$baseUrl/uploads/";
  // static const String tvVideoBaseUrl="$baseUrl/uploads/";
  // static const String otherVideoBaseUrl="$baseUrl/uploads/";
}
