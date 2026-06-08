# GisTour - QUICK START GUIDE

## ✅ CHECKLIST IMPLEMENTASI LENGKAP

### Phase 1: Setup & Configuration (30 menit)

- [ ] **Step 1: Update pubspec.yaml**
  - Copy semua dependencies dari file `pubspec.yaml` yang sudah dibuat
  - Jalankan: `flutter pub get`

- [ ] **Step 2: Setup Firebase Project**
  - Buat Firebase project di https://console.firebase.google.com
  - Download `google-services.json` untuk Android
  - Download `GoogleService-Info.plist` untuk iOS
  - Aktifkan Authentication (Email/Password + Google)
  - Aktifkan Firestore Database
  - Aktifkan Cloud Messaging

- [ ] **Step 3: Copy Service Files**
  - Buat folder: `lib/services/`
  - Copy ke folder tersebut:
    - `auth_service.dart`
    - `location_service.dart`
    - `notification_service.dart`
    - `payment_service.dart`
    - `recommendation_service.dart`
    - `review_service.dart`

- [ ] **Step 4: Copy Model Files**
  - Buat folder: `lib/models/`
  - Copy ke folder tersebut:
    - `booking_model.dart`
    - `event_model.dart`
    - `favorite_model.dart`
    - `review_model.dart`

- [ ] **Step 5: Copy Provider Files**
  - Buat folder: `lib/providers/`
  - Copy ke folder tersebut:
    - `auth_provider.dart`
    - `booking_provider.dart`
    - `favorite_provider.dart`
    - `theme_provider.dart`

- [ ] **Step 6: Copy Page Files**
  - Buat folder: `lib/pages/`
  - Copy ke folder tersebut:
    - `booking_page.dart`
    - `event_page.dart`
    - `favorite_page.dart`
    - `profile_page.dart`
    - `review_page.dart`
    - `ticket_page.dart`

- [ ] **Step 7: Update main.dart**
  - Gunakan kode dari IMPLEMENTASI_GISTOUR.md section "Integrasi ke main.dart"
  - Setup MultiProvider dengan semua providers

---

### Phase 2: Firebase Configuration (20 menit)

- [ ] **Setup Firestore Collections**
  - Buat collections di Firestore:
    - `users`
    - `favorites`
    - `bookings`
    - `reviews`
    - `payments`
    - `events`
    - `destinations` (sudah ada)

- [ ] **Setup Firestore Security Rules**
  - Copy rules dari IMPLEMENTASI_GISTOUR.md section "Setup Firestore Rules"
  - Publish rules di Firestore

- [ ] **Setup Android (android/app/build.gradle)**
  - Tambahkan dependency: `implementation 'com.google.gms:google-services:4.3.14'`
  - Tambahkan plugin: `apply plugin: 'com.google.gms.google-services'`

- [ ] **Setup iOS (ios/Podfile)**
  - Uncomment bagian platform :ios dan set ke 11.0 atau lebih tinggi
  - Jalankan: `cd ios && pod install && cd ..`

---

### Phase 3: Integration & Testing (30 menit)

- [ ] **Test Firebase Connection**
  ```dart
  // Di main.dart, test connection
  print('Firebase initialized');
  ```

- [ ] **Test Auth**
  - Test Register dengan email baru
  - Test Login dengan email yang sudah terdaftar
  - Test Google Sign-In
  - Test Logout

- [ ] **Test Location Service**
  - Request location permission
  - Verify getCurrentPosition() bekerja
  - Test calculateDistance()

- [ ] **Test Notification**
  - Subscribe ke topic: "promo"
  - Send test notification dari Firebase Console

- [ ] **Test Theme Provider**
  - Verify light mode berjalan
  - Toggle ke dark mode
  - Verify perubahan color scheme

- [ ] **Test Favorite Provider**
  - Add favorite dari destination
  - Check isFavorite()
  - Remove favorite

- [ ] **Test Booking Provider**
  - Create booking
  - Verify booking di Firestore
  - Process payment

- [ ] **Run Flutter Analyzer**
  ```bash
  flutter analyze
  ```

---

### Phase 4: UI Integration (1 jam)

- [ ] **Add Navigation Routes**
  - Integrasikan `FavoritePage` ke Bottom Navigation
  - Integrasikan `TicketPage` ke Bottom Navigation
  - Integrasikan `ProfilePage` ke Bottom Navigation
  - Add route untuk `ReviewPage` (dari detail destinasi)
  - Add route untuk `EventPage` (ke Bottom Navigation)
  - Add route untuk `BookingPage` (dari detail destinasi)

- [ ] **Update Existing Pages**
  - Link "Add to Favorite" button dengan `FavoriteProvider`
  - Link "Book" button dengan `BookingPage`
  - Link "Reviews" section dengan `ReviewPage`
  - Link "See Events" dengan `EventPage`

- [ ] **Test Navigation**
  - Semua tombol navigate ke halaman yang benar
  - Back button bekerja di semua halaman
  - Data flow antar halaman lancar

---

### Phase 5: Data Population (30 menit)

- [ ] **Populate Destinations**
  - Jika belum ada, add destinations ke Firestore
  - Atau sync dari local `wisata_data.dart`

- [ ] **Populate Events**
  - Add beberapa event sample ke Firestore

- [ ] **Populate Reviews**
  - Add beberapa review sample (optional)

---

### Phase 6: Testing & Debugging (1 jam)

- [ ] **Full App Flow Test**
  - Login flow: Email + Password ✓
  - Login flow: Google ✓
  - View favorites ✓
  - Add/remove favorite ✓
  - View tickets ✓
  - Book ticket + payment ✓
  - View profile + logout ✓
  - View events ✓
  - Leave review ✓

- [ ] **Error Handling Test**
  - Wrong password ✓
  - Network error ✓
  - Payment failure ✓
  - Location permission denied ✓

- [ ] **Performance Test**
  - List destinations load cepat
  - Image loading smooth
  - No excessive rebuilds

- [ ] **Device Testing**
  - Test di Android device/emulator ✓
  - Test di iOS device/simulator ✓
  - Test landscape orientation ✓
  - Test dark mode ✓

---

## 📊 FILES CHECKLIST

### Services (6 files)
- [ ] `auth_service.dart` ✓
- [ ] `location_service.dart` ✓
- [ ] `notification_service.dart` ✓
- [ ] `payment_service.dart` ✓
- [ ] `recommendation_service.dart` ✓
- [ ] `review_service.dart` ✓

### Models (4 files)
- [ ] `booking_model.dart` ✓
- [ ] `event_model.dart` ✓
- [ ] `favorite_model.dart` ✓
- [ ] `review_model.dart` ✓

### Providers (4 files)
- [ ] `auth_provider.dart` ✓
- [ ] `booking_provider.dart` ✓
- [ ] `favorite_provider.dart` ✓
- [ ] `theme_provider.dart` ✓

### Pages (6 files)
- [ ] `booking_page.dart` ✓
- [ ] `event_page.dart` ✓
- [ ] `favorite_page.dart` ✓
- [ ] `profile_page.dart` ✓
- [ ] `review_page.dart` ✓
- [ ] `ticket_page.dart` ✓

### Configuration (2 files)
- [ ] `pubspec.yaml` ✓
- [ ] `IMPLEMENTASI_GISTOUR.md` ✓
- [ ] `QUICK_START.md` (ini) ✓

---

## 🎯 TIMELINE IMPLEMENTATION

| Phase | Task | Duration | Status |
|-------|------|----------|--------|
| 1 | Setup & Dependencies | 30 menit | ⏳ |
| 2 | Firebase Config | 20 menit | ⏳ |
| 3 | Integration & Testing | 30 menit | ⏳ |
| 4 | UI Integration | 1 jam | ⏳ |
| 5 | Data Population | 30 menit | ⏳ |
| 6 | Testing & Debug | 1 jam | ⏳ |
| **TOTAL** | | **~4 jam** | |

---

## 🔗 IMPORTANT LINKS

### Firebase Console
- https://console.firebase.google.com

### Flutter Documentation
- https://flutter.dev/docs
- https://pub.dev (package search)

### Firebase Docs
- https://firebase.google.com/docs/flutter/setup
- https://firebase.google.com/docs/firestore

### Provider Documentation
- https://pub.dev/packages/provider

---

## 💡 TIPS & TRICKS

### 1. Quick Testing Authentication
```bash
# Test dengan email dummy
email: test@example.com
password: password123

# Google Account dengan email apa saja
```

### 2. Local Development
```bash
# Hot reload code sambil develop
flutter run

# Debug dengan console
flutter run -v
```

### 3. Emulator Setup
```bash
# Android Emulator
flutter emulators
flutter emulators launch Pixel_5_API_31

# iOS Simulator
open -a Simulator
```

### 4. Testing Firestore Locally
```bash
# Firebase Emulator
firebase emulators:start
```

---

## ⚠️ COMMON ISSUES & SOLUTIONS

### Issue 1: "flutter pub get" Error
**Solution:**
```bash
flutter clean
flutter pub get
```

### Issue 2: Firebase Authentication Not Working
**Solution:**
- Verify google-services.json di android/app/
- Verify GoogleService-Info.plist di ios/Runner/
- Check Firebase Console - Authentication enabled?

### Issue 3: Firestore Rules Blocking Access
**Solution:**
- During development, set rules to:
```
match /{document=**} {
  allow read, write: if true;
}
```
- Move to proper rules after testing

### Issue 4: Image Not Loading
**Solution:**
- Use placeholder/errorBuilder
- Already implemented di semua pages

### Issue 5: Permission Issues (Location, Camera)
**Solution:**
- Add permissions di AndroidManifest.xml & Info.plist
- Request permissions at runtime (sudah diimplementasi)

---

## 📱 BUILD COMMANDS

### Development
```bash
flutter run
flutter run -v  # Verbose mode
```

### Build Release
```bash
# Android APK
flutter build apk --release

# Android App Bundle (untuk Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## 🚀 DEPLOYMENT CHECKLIST

Sebelum production:

- [ ] Update app version di pubspec.yaml
- [ ] Change debug to release builds
- [ ] Verify all Firebase rules
- [ ] Test all error scenarios
- [ ] Performance optimization done
- [ ] Remove debug prints
- [ ] Add proper error messages
- [ ] Test di real device
- [ ] Get Play Store/App Store accounts
- [ ] Upload to stores

---

## 📞 SUPPORT

Jika ada error atau pertanyaan:

1. **Check logs:**
   ```bash
   flutter logs
   ```

2. **Analyze code:**
   ```bash
   flutter analyze
   ```

3. **Reset everything:**
   ```bash
   flutter clean
   rm -rf pubspec.lock
   flutter pub get
   ```

4. **Search issues:**
   - GitHub issues
   - Stack Overflow
   - Flutter Discord

---

## 🎉 CONGRATULATIONS!

Jika semua checklist sudah selesai, aplikasi GisTour Anda sudah siap untuk digunakan! 🎊

**Next Steps:**
- Deploy ke Play Store / App Store
- Gather user feedback
- Continue development untuk fitur baru
- Monitor app performance

---

**Happy Coding! 💻**

GisTour Team
