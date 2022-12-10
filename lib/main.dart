import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:k24_admin/config/front_end_config.dart';
import 'package:k24_admin/presentation/views/splash/splash_view.dart';

import 'app/my_app.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FrontEndConfigs.notification = message.data['message'].toString();
  print('assas${FrontEndConfigs.notification}');
  storage.write(key: 'order', value: FrontEndConfigs.notification);

  print('ssss=${message.data}');
  createNotification(
    title: message.data['title'].toString(),
    body: message.data['body'].toString(),
  );
}

Future<void> createNotification(
    {required String title, required String body}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1, channelKey: 'basic_channel', title: title, body: body),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: '',
      ),
    ],
  ).then((value) => print(value));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}
listenActionStream() {
  AwesomeNotifications().actionStream.listen((receivedAction) {
    var payload = receivedAction.payload;

    if (receivedAction.channelKey == 'normal_channel') {
      //do something here
    }
  });
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
const storage = FlutterSecureStorage();
StreamController<bool> _showLockScreenStream = StreamController();
StreamSubscription? _showLockScreenSubs;
GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _showLockScreenSubs = _showLockScreenStream.stream.listen((bool show) {
      if (mounted && show) {
        _showLockScreenDialog();
      }
    });
    AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Allow Notifications'),
              content:
              const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
    FirebaseMessaging.onMessage.listen((message) {
      print('createeee${message}');
      createNotification(
        title: message.data['title'].toString(),
        body: message.data['body'].toString(),
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print('assasaa${message}');
      if (message.data['body']['message']!.contains('asd') ||
          message.data['message']!.contains('res')) {
        FrontEndConfigs.notification = message.data['message'];
      }
      // createNotification(
      //   title: message.data['title'].toString(),
      //   body: message.data['body'].toString(),
      // );
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _showLockScreenSubs?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      print('searchpage = resumed');
      _showLockScreenStream.add(true);
    }
  }

  void _showLockScreenDialog() async {
    String? value = await storage.read(key: 'order');
    print('searchpage = ${value}');
    Future.delayed(
      Duration.zero,
    );
    if (value == 'order') {
      storage.write(key: 'abc', value: '');
      // _navigatorKey.currentState!
      //     .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      //   return const ChatListView();
      // }));
    } else if (value == 'res') {
      storage.write(key: 'abc', value: '');
      // _navigatorKey.currentState!
      //     .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      //   return const ReservationScreen();
      // }));
    } else if (value == 'accept') {
      // _navigatorKey.currentState!
      //     .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      //   return const RentedCar();
      // }));
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K24',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      home: const SplashView(),
    );
  }
}

