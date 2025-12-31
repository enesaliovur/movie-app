import 'dart:convert';

dynamic decodeResponseData(dynamic data) {
  if (data is String) {
    try {
      return json.decode(data);
    } catch (e) {
      return data;
    }
  }
  return data;
}
