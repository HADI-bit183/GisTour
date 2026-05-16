// This is a basic Flutter widget test for Desa Wisata app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisata/main.dart';

void main() {
  testWidgets('Desa Wisata splash screen tampil', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const DesaWisataApp());

    // Cek teks splash muncul
    expect(find.text('Desa Wisata'), findsOneWidget);
    expect(find.text('Jelajahi Keindahan Nusantara'), findsOneWidget);

    // Lewati semua timer (termasuk Future.delayed di SplashScreen)
    await tester.pumpAndSettle(const Duration(seconds: 4));
  });
}
