import 'notification.dart';

class NotificationHandler {
  final NotificationServices _services = NotificationServices();

  ///Push 1-1 Notification
  oneToOneNotificationHelper(
      {required String docID,
      required String body,
      required String title,
      required String message,
      required String location}) {
    _services.streamSpecificUserToken(docID).first.then((value) {
      print("im called $value");
      _services.pushOneToOneNotification(
        sendTo: value,
        title: title,
        body: body,
        location: location, message: message,
      );
    });
  }
}
