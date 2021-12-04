enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION
}

class ResponseCode {
  //API STATUS CODES
  static const int SUCCESS = 200; // Success with content
  static const int NO_CONTENT = 201; // Success with no content
  static const int BAD_REQUEST = 400; // Failure , API api rejected the request
  static const int FORBIDDEN = 403; // Failure , API api rejected the request
  static const int UNAUTHORIZED = 401; // Failure, user is Unauthorized
  static const int NOT_FOUND =
      404; // Failure, api url is not correct and not found
  static const int INTERNAL_SERVER_ERR =
      500; //Failure, crash happend in server site

  //LOCAL STATUS CODES
  static const int UNKNOWN = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  //API STATUS CODES
  static const String SUCCESS = "success"; // Success with content
  static const String NO_CONTENT =
      "success with no content"; // Success with no content
  static const String BAD_REQUEST =
      "Bad request, try again later "; // Failure , API api rejected the request
  static const String FORBIDDEN =
      "forbidden request, try again later"; // Failure , API api rejected the request
  static const String UNAUTHORIZED =
      "user is unauthorizeds, you have no access"; // Failure, user is Unauthorized
  static const String NOT_FOUND =
      "Url is not found, try again later"; // Failure, api url is not correct and not found
  static const String INTERNAL_SERVER_ERR =
      "something went wrong, try again later"; //Failure, crash happend in server site

  //LOCAL STATUS CODES
  static const String UNKNOWN = "something went wrong, try again later";
  static const String CONNECT_TIMEOUT = "time out error, try again later";
  static const String CANCEL = "request was cancelled, try again later";
  static const String RECEIVE_TIMEOUT = "time out error, try again later";
  static const String SEND_TIMEOUT = "time out error, try again later";
  static const String CACHE_ERROR = "cache error, try again later";
  static const String NO_INTERNET_CONNECTION =
      "Please check your internet connection";
}
