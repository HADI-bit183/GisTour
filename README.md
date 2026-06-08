# GisTour - Aplikasi Wisata Gisting

Aplikasi Flutter untuk wisata destinasi Gisting, Kabupaten Tanggamus, Lampung dengan fitur lengkap seperti booking tiket, review, favorit, dan event.

## 🚀 Fitur Utama

- **Authentication** - Email/Password & Google Sign-In
- **Destinasi Wisata** - Daftar lengkap dengan detail dan lokasi
- **Booking Tiket** - Pesan tiket dengan berbagai metode pembayaran
- **Favorit** - Simpan destinasi favorit
- **Review & Rating** - Beri ulasan dan rating untuk destinasi
- **Event Wisata** - Lihat dan ikuti event wisata terbaru
- **Notifikasi** - Push notification untuk promo dan event
- **Dark Mode** - Support light dan dark theme
- **Lokasi Real-time** - Terintegrasi dengan Google Maps

## 📋 Prasyarat

- Flutter 3.11.0 atau lebih tinggi
- Dart 3.11.0 atau lebih tinggi
- Firebase Project (Authentication, Firestore, Cloud Messaging)

## 🔧 Setup & Installation

### 1. Clone Repository
```bash
git clone <repository-url>
cd gistour
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Setup Firebase

#### Android
- Download `google-services.json` dari Firebase Console
- Letakkan di `android/app/`

#### iOS
- Download `GoogleService-Info.plist` dari Firebase Console
- Letakkan di `ios/Runner/`

### 4. Run Application
```bash
flutter run
```

## 📁 Struktur Folder

```
lib/
├── main.dart                 # Entry point aplikasi
├── data/                     # Data static & models
├── models/                   # Data models
├── pages/                    # UI Pages
├── providers/                # State management
├── services/                 # Business logic & API
└── widgets/                  # Reusable widgets
```

## 🔐 Services

### Auth Service
- Email/Password Authentication
- Google Sign-In
- Password Reset
- Profile Management

### Location Service
- Get current location
- Calculate distance
- Real-time tracking

### Payment Service
- QRIS Payment
- E-Wallet Payment
- Bank Transfer

### Notification Service
- Firebase Cloud Messaging
- Local notifications
- Topic subscription

### Review Service
- Create & read reviews
- Rating & feedback
- Image upload

## 📱 Pages

| Halaman | Fungsi |
|---------|--------|
| Splash Screen | Loading awal aplikasi |
| Login/Register | Autentikasi user |
| Beranda | Dashboard utama |
| Daftar Wisata | List semua destinasi |
| Detail Wisata | Detail destinasi & booking |
| Favorit | Daftar favorit |
| Tiket | Tiket yang sudah dibeli |
| Review | Ulasan destinasi |
| Event | Event wisata |
| Profil | User profile & settings |
| Peta | Google Maps integration |

## 🛠️ Technology Stack

- **Framework**: Flutter 3.11+
- **State Management**: Provider
- **Backend**: Firebase
  - Authentication
  - Firestore Database
  - Cloud Messaging
  - Storage
- **Maps**: Google Maps Flutter
- **Location**: Geolocator
- **UI**: Material 3

## 📚 Dokumentasi

Lihat dokumentasi lengkap di folder root:
- `QUICK_START.md` - Panduan cepat implementasi
- `IMPLEMENTASI_GISTOUR.md` - Setup detail Firebase
- `API_REFERENCE.md` - Dokumentasi API lengkap

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Build Release
```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 🤝 Contributing

Kontribusi sangat diterima! Silakan:
1. Fork repository
2. Buat branch feature (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buka Pull Request

## 📝 License

Project ini dilisensikan di bawah MIT License - lihat file LICENSE untuk detail.

## 👨‍💻 Author

**Nicko** - Full Stack Developer

- GitHub: [@nicko-dev](https://github.com/nicko-dev)
- Email: nicko@example.com

## 🙏 Acknowledgments

- Flutter Team untuk framework yang amazing
- Firebase untuk backend services
- Community untuk support dan feedback

## 📞 Support

Untuk pertanyaan atau issues:
- Buka GitHub Issues
- Email: support@gistour.com
- WhatsApp: +62-xxx-xxxx-xxxx

---

**Happy Coding! 🚀**

Last Updated: June 2026
