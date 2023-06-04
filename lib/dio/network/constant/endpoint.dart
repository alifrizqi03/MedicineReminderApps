class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://10.0.2.2:8000/api/v1";

  // receiveTimeout
  static const int receiveTimeout = 20000;

  // connectTimeout
  static const int connectionTimeout = 20000;

  static const String auth = '/auth';
  static const String ad = '/ad';
}
