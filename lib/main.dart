import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'providers/auth_provider.dart';
import 'providers/booking_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/theme_provider.dart';
import 'services/auth_service.dart';
import 'services/notification_service.dart';
import 'pages/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize locale untuk DateFormat id_ID
  await initializeDateFormatting('id_ID', null);

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized');
  } catch (e) {
    print('Firebase Error: $e');
  }

  // Initialize Notification Service
  try {
    final notificationService = NotificationService();
    await notificationService.initialize();
  } catch (e) {
    // Silent fail
  }

  runApp(const GisTourApp());
}

class GisTourApp extends StatelessWidget {
  const GisTourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              AuthProvider(authService: AuthService())..initializeAuthState(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (_) => FavoriteProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => BookingProvider(), lazy: false),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider()..initialize(),
          lazy: false,
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'GisTour - Wisata Gisting',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
