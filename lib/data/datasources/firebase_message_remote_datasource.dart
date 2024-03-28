import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onlineshop_app/data/datasources/auth_local_datasource.dart';
import 'package:onlineshop_app/data/datasources/auth_remote_datasource.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FirebaseMessageRemoteDatasource().firebaseBackgroundHandler(message);
}

class FirebaseMessageRemoteDatasource {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    /// Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_shop');

    /// IOS
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});

    final fcmToken = await _firebaseMessaging.getToken();

    /// print token
    debugPrint('FcmToken : $fcmToken');

    /// cek user login
    if (await AuthLocalDatasource().isLogin()) {
      AuthRemoteDatasource().updateFcmToken(fcmToken ?? '');
    }

    FirebaseMessaging.instance.getInitialMessage();

    // test ngeprint
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint(message.notification?.body);
      debugPrint(message.notification?.title);
    });

    /// menangani pesan yang diterima saat aplikasi berjalan di latar belakang (background)
    FirebaseMessaging.onMessage.listen(firebaseBackgroundHandler);

    /// ketika pengguna membuka aplikasi setelah mengklik pesan push yang diterima
    FirebaseMessaging.onMessageOpenedApp.listen(firebaseBackgroundHandler);

    /// digunakan saat aplikasi berjalan di latar belakang (background) atau bahkan jika aplikasi ditutup sama sekali.
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// show notification
  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) {
    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'com.example.onlineshop_app',
          'seller',
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
    showNotification(
      title: message.notification!.title,
      body: message.notification!.body,
    );
  }
}
