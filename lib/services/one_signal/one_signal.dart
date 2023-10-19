import 'dart:convert';
import 'package:http/http.dart' as http;

class OneSignals {
  Future<http.Response> sendNotification(
    List tokenIdList,
    String heading,
    String contents,
    String? image, {
    String? id,
    String? token,
    String? senderName,
    String? type,
  }) async {
    return await http.post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "app_id":
            'b80a7b21-dfb0-49d5-bc1c-d8e20d7da33c', //kAppId is the App Id that one get from the OneSignal When the application is registered.
        "include_player_ids":
            tokenIdList, //tokenIdList Is the List of All the Token Id to to Whom notification must be sent.
        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color": "FF9976D2",
        "small_icon": "ic_stat_onesignal_default",
        "large_icon": image,
        "headings": {"en": heading},
        "contents": {"en": contents},
        "data": {
          "id": id,
          "token": token,
          "senderName": senderName,
          "type": type,
        }
      }),
    );
  }
}
