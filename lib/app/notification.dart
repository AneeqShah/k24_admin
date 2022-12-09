import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:k24_admin/config/back_end.dart';

class NotificationServices {
  ///Push 1-1 Notification
  Future pushOneToOneNotification({
    required String title,
    required String body,
    required String sendTo,
    required String message,
    required String location,
  }) async {
    print("I am sending to : $sendTo");
    return await http
        .post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "key=${BackendConfigs.kServerKey}"
            },
            body: json.encode({
              "data": {
                "body": body,
                "title": title,
                "sound": "default",
                "location": location,
                "message": message
              },
              "android": {"priority": "high"},
              "apns": {
                "payload": {
                  "aps": {"sound": "default"}
                }
              },
              "to": sendTo
            }))
        .then((value) => print(value.body));
  }

  //
  Future pushBroadCastNotification({
    required String title,
    required String body,
    required String department,
  }) async {
    String toParams = "/topics/" + department;
    return await http
        .post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "key=${BackendConfigs.kServerKey}"
            },
            body: json.encode({
              "data": {"body": body, "title": title, "sound": "default"},
              "android": {"priority": "high"},
              "content_available": true,
              "apn-priority": 5,
              "apns": {
                "payload": {
                  "aps": {"sound": "default"}
                }
              },
              "to": "$toParams"
            }))
        .then((value) {
      print("Body: ${value.body}");
      print(value.statusCode);
    }).catchError((e) {
      print(e.toString());
    });
  }

  ///Get One Specific User Token
  Stream<String> streamSpecificUserToken(String docID) {
    return FirebaseFirestore.instance
        .collection('deviceTokens')
        .doc(docID)
        .snapshots()
        .map((event) {
      return event.data()!['deviceTokens'];
    });
  }
}
