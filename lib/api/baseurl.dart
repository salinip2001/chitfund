class ApiConfiguration {
  static const url = 'http://192.168.1.24:3100/';
  //

  Uri getApi(String apiName) {
    return Uri.parse('$url$apiName');
  }

  static Map<String, String> header = {
    'Accept': '*/*',
    'Content-Type': 'application/json'
  };
}
