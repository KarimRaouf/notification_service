import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> initialize() async {
    // Request permission for notifications
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground Firebase message: ${message.notification?.title}');
    });

    // Handle notification clicks (when the app is in the background or terminated)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Firebase notification clicked: ${message.notification?.title}');
      // Add your custom logic or navigation here
    });

    // Configure background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    getFCMToken();
  }

  // Optional: Get the FCM token for debugging or backend purposes
  static getFCMToken() async {
    String? token = await _firebaseMessaging.getToken();
    print(token);
  }

  // Background message handler
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Background Firebase message: ${message.notification?.title}');
    // You can perform background tasks here
  }
}
