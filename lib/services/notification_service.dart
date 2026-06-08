import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Initialize notifications
  Future<void> initialize() async {
    try {
      // Request notification permission (iOS)
      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        provisional: false,
        sound: true,
      );

      // Initialize local notifications
      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSettings = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Handle notification tapped
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTapped);

      // Handle background message
      FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

      // Get FCM token
      final token = await _firebaseMessaging.getToken();
      if (token != null) {
        // Token available for device targeting
      }
    } catch (e) {
      // Silent fail
    }
  }

  // Handle foreground message
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    showLocalNotification(
      title: message.notification?.title ?? 'GisTour',
      body: message.notification?.body ?? 'Notifikasi baru',
      payload: message.data.toString(),
    );
  }

  // Handle notification tapped
  void _handleNotificationTapped(RemoteMessage message) {
    // Handle navigation based on message data
  }

  // Handle background message
  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    // Handle background message
  }

  // Handle local notification tap
  void _onNotificationTapped(NotificationResponse response) {
    // Handle local notification tap
  }

  // Show local notification
  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
    int id = 0,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'gistour_channel',
        'GisTour Notifications',
        channelDescription: 'Notifikasi dari GisTour',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
        enableVibration: true,
        playSound: true,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _localNotifications.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
    } catch (e) {
      // Silent fail
    }
  }

  // Subscribe to promo topic
  Future<void> subscribeToPromoTopic() async {
    try {
      await _firebaseMessaging.subscribeToTopic('promo');
    } catch (e) {
      // Silent fail
    }
  }

  // Subscribe to event topic
  Future<void> subscribeToEventTopic() async {
    try {
      await _firebaseMessaging.subscribeToTopic('event');
    } catch (e) {
      // Silent fail
    }
  }

  // Subscribe to booking topic
  Future<void> subscribeToBookingTopic({required String userId}) async {
    try {
      await _firebaseMessaging.subscribeToTopic('booking_$userId');
    } catch (e) {
      // Silent fail
    }
  }

  // Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
    } catch (e) {
      // Silent fail
    }
  }

  // Get FCM token
  Future<String?> getFCMToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      return null;
    }
  }

  // Enable notifications
  Future<void> enableNotifications() async {
    try {
      await _firebaseMessaging.setAutoInitEnabled(true);
    } catch (e) {
      // Silent fail
    }
  }

  // Disable notifications
  Future<void> disableNotifications() async {
    try {
      await _firebaseMessaging.deleteToken();
    } catch (e) {
      // Silent fail
    }
  }

  // Show promo notification
  Future<void> showPromoNotification({
    required String title,
    required String body,
    required String destinationId,
  }) async {
    await showLocalNotification(
      title: title,
      body: body,
      payload: 'promo:$destinationId',
      id: DateTime.now().millisecond,
    );
  }

  // Show event notification
  Future<void> showEventNotification({
    required String title,
    required String body,
    required String eventId,
  }) async {
    await showLocalNotification(
      title: title,
      body: body,
      payload: 'event:$eventId',
      id: DateTime.now().millisecond,
    );
  }

  // Show booking confirmation notification
  Future<void> showBookingConfirmationNotification({
    required String bookingId,
    required String destinationName,
    required String date,
  }) async {
    await showLocalNotification(
      title: 'Tiket Berhasil Dipesan',
      body: 'Tiket untuk $destinationName pada $date telah dikonfirmasi',
      payload: 'booking:$bookingId',
      id: DateTime.now().millisecond,
    );
  }
}
