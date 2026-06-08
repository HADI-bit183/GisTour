# GisTour - API REFERENCE DOCUMENTATION

## 🔐 AUTH SERVICE

### Class: `AuthService`
Location: `lib/services/auth_service.dart`

#### Properties
```dart
User? get currentUser          // Current authenticated user
Stream<User?> get authStateChanges  // Auth state stream
String? get currentUserId      // Current user ID
String? get currentUserEmail   // Current user email
```

#### Methods

##### Login Methods
```dart
// Login dengan email dan password
Future<UserCredential> loginWithEmailPassword({
  required String email,
  required String password,
})

// Login dengan Google
Future<UserCredential?> loginWithGoogle()

// Sign out
Future<void> signOut()

// Reset password
Future<void> resetPassword({required String email})
```

##### Registration
```dart
// Register dengan email dan password
Future<UserCredential> registerWithEmailPassword({
  required String email,
  required String password,
  required String displayName,
})
```

##### Profile Management
```dart
// Update profile
Future<void> updateProfile({
  String? displayName,
  String? photoUrl,
})

// Update email
Future<void> updateEmail({required String newEmail})

// Change password
Future<void> changePassword({required String newPassword})

// Delete account
Future<void> deleteAccount()
```

##### Utility
```dart
// Check if user is logged in
bool isLoggedIn()
```

---

## 📍 LOCATION SERVICE

### Class: `LocationService`
Location: `lib/services/location_service.dart`

#### Methods

##### Permission & Status
```dart
// Request location permission
Future<LocationPermission> requestLocationPermission()

// Check if location permission granted
Future<bool> isLocationPermissionGranted()

// Check if location service enabled
Future<bool> isLocationServiceEnabled()
```

##### Get Location
```dart
// Get current position
Future<Position> getCurrentPosition()

// Get current latitude & longitude
Future<Map<String, double>> getCurrentCoordinates()

// Get real-time location stream
Stream<Position> getLocationStream({
  int distanceFilter = 10,
  LocationAccuracy accuracy = LocationAccuracy.high,
})
```

##### Distance Calculation
```dart
// Calculate distance between two coordinates (in km)
double calculateDistance({
  required double userLat,
  required double userLng,
  required double destinationLat,
  required double destinationLng,
})

// Calculate distance from current location to destination
Future<double> getDistanceToDestination({
  required double destinationLat,
  required double destinationLng,
})

// Calculate bearing between two coordinates
double calculateBearing({
  required double userLat,
  required double userLng,
  required double destinationLat,
  required double destinationLng,
})

// Check if user within radius
bool isWithinRadius({
  required double userLat,
  required double userLng,
  required double destinationLat,
  required double destinationLng,
  required double radiusKm,
})

// Format distance to readable string
String formatDistance(double distanceKm)
```

---

## 💡 RECOMMENDATION SERVICE

### Class: `RecommendationService`
Location: `lib/services/recommendation_service.dart`

#### Methods

```dart
// Get recommended destinations based on preferences
Future<List<Map<String, dynamic>>> getRecommendedDestinations({
  required String userId,
  required double userLat,
  required double userLng,
  int limit = 5,
})

// Get popular destinations (highest rated)
Future<List<Map<String, dynamic>>> getPopularDestinations({
  int limit = 10,
})

// Get nearby destinations
Future<List<Map<String, dynamic>>> getNearbyDestinations({
  required double userLat,
  required double userLng,
  double radiusKm = 50,
  int limit = 10,
})

// Get recommendations based on visit history
Future<List<Map<String, dynamic>>> getHistoryBasedRecommendations({
  required String userId,
  required double userLat,
  required double userLng,
  int limit = 5,
})

// Get trending destinations
Future<List<Map<String, dynamic>>> getTrendingDestinations({
  int limit = 10,
  int daysBack = 30,
})
```

---

## 🔔 NOTIFICATION SERVICE

### Class: `NotificationService`
Location: `lib/services/notification_service.dart`

#### Methods

##### Initialization
```dart
// Initialize notifications
Future<void> initialize()
```

##### Local Notifications
```dart
// Show local notification
Future<void> showLocalNotification({
  required String title,
  required String body,
  String? payload,
  int id = 0,
})

// Show promo notification
Future<void> showPromoNotification({
  required String title,
  required String body,
  required String destinationId,
})

// Show event notification
Future<void> showEventNotification({
  required String title,
  required String body,
  required String eventId,
})

// Show booking confirmation notification
Future<void> showBookingConfirmationNotification({
  required String bookingId,
  required String destinationName,
  required String date,
})
```

##### Topic Subscription
```dart
// Subscribe to promo topic
Future<void> subscribeToPromoTopic()

// Subscribe to event topic
Future<void> subscribeToEventTopic()

// Subscribe to user-specific booking topic
Future<void> subscribeToBookingTopic({
  required String userId,
})

// Unsubscribe from topic
Future<void> unsubscribeFromTopic(String topic)
```

##### FCM Management
```dart
// Get FCM token
Future<String?> getFCMToken()

// Enable notifications
Future<void> enableNotifications()

// Disable notifications
Future<void> disableNotifications()
```

---

## 💳 PAYMENT SERVICE

### Class: `PaymentService`
Location: `lib/services/payment_service.dart`

#### Enums
```dart
enum PaymentMethod { qris, eWallet, bankTransfer }
enum PaymentStatus { pending, processing, success, failed, cancelled }
```

#### Methods

##### Payment Operations
```dart
// Create payment
Future<Map<String, dynamic>> createPayment({
  required String bookingId,
  required String userId,
  required double amount,
  required PaymentMethod method,
})

// Check payment status
Future<Map<String, dynamic>> checkPaymentStatus({
  required String paymentId,
})

// Process payment
Future<Map<String, dynamic>> processPayment({
  required String paymentId,
  required PaymentMethod method,
})

// Cancel payment
Future<void> cancelPayment({required String paymentId})
```

##### Payment History & Stats
```dart
// Get payment history
Future<List<Map<String, dynamic>>> getPaymentHistory({
  required String userId,
  int limit = 20,
})

// Get total spent
Future<double> getTotalSpent({required String userId})
```

##### QR Code & Reference
```dart
// Verify QR code
Future<Map<String, dynamic>> verifyQRCode({
  required String qrCodeData,
})

// Validate payment amount
bool validatePaymentAmount(double amount)
```

##### Payment Methods
```dart
// Get payment methods
List<Map<String, dynamic>> getPaymentMethods()

// Get bank account details
Map<String, String> getBankAccountDetails()

// Format payment method name
String formatPaymentMethodName(String method)

// Format currency
String formatCurrency(double amount)
```

---

## ⭐ REVIEW SERVICE

### Class: `ReviewService`
Location: `lib/services/review_service.dart`

#### Methods

##### Create & Manage Reviews
```dart
// Create review
Future<ReviewModel> createReview({
  required String destinationId,
  required String userId,
  required String userName,
  String? userPhotoUrl,
  required double rating,
  required String comment,
  List<String> imageUrls = const [],
})

// Get destination reviews
Future<List<ReviewModel>> getDestinationReviews({
  required String destinationId,
  int limit = 50,
})

// Get user reviews
Future<List<ReviewModel>> getUserReviews({
  required String userId,
})

// Get review by ID
Future<ReviewModel?> getReviewById({
  required String reviewId,
})

// Update review
Future<void> updateReview({
  required String reviewId,
  String? comment,
  double? rating,
})

// Delete review
Future<void> deleteReview({
  required String reviewId,
  required String destinationId,
})
```

##### Ratings & Analytics
```dart
// Get average rating for destination
Future<double> getAverageRating({
  required String destinationId,
})

// Get rating distribution
Future<Map<int, int>> getRatingDistribution({
  required String destinationId,
})

// Mark review as helpful
Future<void> markHelpful({
  required String reviewId,
  required String userId,
})
```

##### Filtering & Search
```dart
// Get reviews with pagination
Future<List<ReviewModel>> getReviewsWithPagination({
  required String destinationId,
  required int pageNumber,
  int pageSize = 10,
})

// Filter reviews by rating
Future<List<ReviewModel>> filterByRating({
  required String destinationId,
  required int minRating,
  required int maxRating,
})

// Search reviews
Future<List<ReviewModel>> searchReviews({
  required String destinationId,
  required String query,
})
```

---

## 👤 AUTH PROVIDER

### Class: `AuthProvider extends ChangeNotifier`
Location: `lib/providers/auth_provider.dart`

#### Properties
```dart
User? get currentUser            // Current user object
bool get isLoading               // Loading state
String? get errorMessage         // Error message
bool get isLoggedIn              // Login status
String? get userId               // Current user ID
String? get userEmail            // Current user email
String? get userName             // Current user name
```

#### Methods
```dart
// Login
Future<void> login({
  required String email,
  required String password,
})

// Register
Future<void> register({
  required String email,
  required String password,
  required String displayName,
})

// Login with Google
Future<void> loginWithGoogle()

// Logout
Future<void> logout()

// Reset password
Future<void> resetPassword({required String email})

// Update profile
Future<void> updateProfile({
  String? displayName,
  String? photoUrl,
})

// Update email
Future<void> updateEmail({required String newEmail})

// Change password
Future<void> changePassword({required String newPassword})

// Delete account
Future<void> deleteAccount()

// Check if logged in
bool checkIsLoggedIn()

// Refresh user data
Future<void> refreshUser()
```

---

## ❤️ FAVORITE PROVIDER

### Class: `FavoriteProvider extends ChangeNotifier`
Location: `lib/providers/favorite_provider.dart`

#### Properties
```dart
List<FavoriteModel> get favorites   // List of favorites
bool get isLoading                  // Loading state
String? get errorMessage            // Error message
int get favoriteCount               // Number of favorites
```

#### Methods

##### CRUD Operations
```dart
// Load user favorites
Future<void> loadFavorites({required String userId})

// Add to favorites
Future<void> addFavorite({
  required String userId,
  required String destinationId,
  required String destinationName,
  String? imageUrl,
  double? rating,
  String? kategori,
})

// Remove from favorites
Future<void> removeFavorite({required String destinationId})

// Get favorites
Future<List<FavoriteModel>> getFavorites({
  required String userId,
})

// Clear all favorites
Future<void> clearAllFavorites({required String userId})
```

##### Query Methods
```dart
// Check if destination is favorited
bool isFavorite(String destinationId)

// Toggle favorite
Future<void> toggleFavorite({
  required String userId,
  required String destinationId,
  required String destinationName,
  String? imageUrl,
  double? rating,
  String? kategori,
})

// Get favorite by destination ID
FavoriteModel? getFavoriteByDestinationId(String destinationId)

// Get favorites by category
List<FavoriteModel> getFavoritesByCategory(String category)

// Get favorites sorted by rating
List<FavoriteModel> getFavoritesSortedByRating()

// Search favorites
List<FavoriteModel> searchFavorites(String query)
```

---

## 🎨 THEME PROVIDER

### Class: `ThemeProvider extends ChangeNotifier`
Location: `lib/providers/theme_provider.dart`

#### Properties
```dart
bool get isDarkMode         // Dark mode status
bool get isInitialized      // Initialization status
ThemeData get lightTheme    // Light theme
ThemeData get darkTheme     // Dark theme
```

#### Methods

##### Theme Management
```dart
// Initialize theme
Future<void> initialize()

// Toggle theme
Future<void> toggleTheme()

// Set light mode
Future<void> setLightMode()

// Set dark mode
Future<void> setDarkMode()

// Reset to light mode
Future<void> resetTheme()
```

##### Color Utilities
```dart
// Get current theme
ThemeData getCurrentTheme()

// Get primary color
Color getPrimaryColor()

// Get secondary color
Color getSecondaryColor()

// Get background color
Color getBackgroundColor()

// Get surface color
Color getSurfaceColor()

// Get text color
Color getTextColor()

// Get border color
Color getBorderColor()
```

---

## 🎫 BOOKING PROVIDER

### Class: `BookingProvider extends ChangeNotifier`
Location: `lib/providers/booking_provider.dart`

#### Properties
```dart
List<BookingModel> get bookings  // List of bookings
bool get isLoading               // Loading state
String? get errorMessage         // Error message
int get bookingCount             // Number of bookings
```

#### Methods

##### Booking Management
```dart
// Load user bookings
Future<void> loadBookings({required String userId})

// Create booking
Future<BookingModel> createBooking({
  required String userId,
  required String destinationId,
  required String destinationName,
  required DateTime visitDate,
  required int quantity,
  required double pricePerTicket,
})

// Process payment for booking
Future<void> processBookingPayment({
  required String bookingId,
  required PaymentMethod method,
})

// Cancel booking
Future<void> cancelBooking({required String bookingId})

// Mark booking as used
Future<void> markBookingAsUsed({required String bookingId})
```

##### Query Methods
```dart
// Get bookings by status
List<BookingModel> getBookingsByStatus(String status)

// Get active bookings
List<BookingModel> getActiveBookings()

// Get upcoming bookings
List<BookingModel> getUpcomingBookings()

// Get past bookings
List<BookingModel> getPastBookings()

// Get booking by ID
BookingModel? getBookingById(String bookingId)
```

##### Statistics
```dart
// Get total spent
Future<double> getTotalSpent({required String userId})

// Get booking statistics
Future<Map<String, dynamic>> getBookingStatistics({
  required String userId,
})
```

---

## 📦 MODELS

### ReviewModel
```dart
const ReviewModel({
  required String id,
  required String userId,
  required String userName,
  String? userPhotoUrl,
  required String destinationId,
  required double rating,
  required String comment,
  List<String> imageUrls = const [],
  required DateTime createdAt,
  DateTime? updatedAt,
  int helpfulCount = 0,
  List<String> helpfulUsers = const [],
})

// Methods
Map<String, dynamic> toJson()
factory ReviewModel.fromJson(String docId, Map<String, dynamic> json)
ReviewModel copyWith({...})
```

### FavoriteModel
```dart
const FavoriteModel({
  required String id,
  required String userId,
  required String destinationId,
  required String destinationName,
  String? imageUrl,
  double? rating,
  String? kategori,
  required DateTime createdAt,
})

// Methods
Map<String, dynamic> toJson()
factory FavoriteModel.fromJson(String docId, Map<String, dynamic> json)
FavoriteModel copyWith({...})
```

### BookingModel
```dart
const BookingModel({
  required String bookingId,
  required String userId,
  required String destinationId,
  required String destinationName,
  required DateTime visitDate,
  required int quantity,
  required double pricePerTicket,
  required double totalPrice,
  required String paymentStatus,  // pending, paid, cancelled
  required String bookingStatus,  // confirmed, expired, used, cancelled
  String? qrCode,
  String? paymentId,
  String? notes,
  required DateTime createdAt,
  DateTime? updatedAt,
  DateTime? usedAt,
})

// Methods
Map<String, dynamic> toJson()
factory BookingModel.fromJson(String docId, Map<String, dynamic> json)
BookingModel copyWith({...})
bool isValid()
bool canBeUsedToday()
```

### EventModel
```dart
const EventModel({
  required String id,
  required String title,
  required String description,
  String? imageUrl,
  required DateTime eventDate,
  DateTime? eventEndDate,
  required String location,
  String? locationDetails,
  required double ticketPrice,
  int? ticketLimit,
  int ticketsSold = 0,
  String? organizerName,
  String? organizerPhone,
  List<String> tags = const [],
  double? rating,
  int? reviewCount,
  required DateTime createdAt,
  DateTime? updatedAt,
  bool isActive = true,
})

// Methods
Map<String, dynamic> toJson()
factory EventModel.fromJson(String docId, Map<String, dynamic> json)
EventModel copyWith({...})
bool isUpcoming()
bool isToday()
bool isPassed()
bool hasTicketsAvailable()
int? getRemainingTickets()
```

---

## 📱 PAGES

### FavoritePage
```dart
const FavoritePage({super.key})

// Displays:
// - List of favorite destinations
// - Remove from favorites
// - View detail buttons
```

### TicketPage
```dart
const TicketPage({super.key})

// Displays:
// - Tabs: Active, Used, History
// - Ticket info with status
// - QR Code display
```

### ProfilePage
```dart
const ProfilePage({super.key})

// Displays:
// - User profile info
// - Edit profile
// - Change password
// - Dark mode toggle
// - Logout
```

### ReviewPage
```dart
ReviewPage({
  required String destinationId,
  required String destinationName,
})

// Displays:
// - Create review form
// - List of reviews with ratings
// - Comment and images
```

### EventPage
```dart
const EventPage({super.key})

// Displays:
// - Tabs: Upcoming, All Events
// - Event cards with info
// - Event detail modal
```

### BookingPage
```dart
BookingPage({
  required String destinationId,
  required String destinationName,
  required double ticketPrice,
})

// Displays:
// - Date selection
// - Quantity selector
// - Price breakdown
// - Payment method selection
// - Booking button
```

---

## 🔗 FIRESTORE SCHEMA

### Collection: `users/{userId}`
```json
{
  "displayName": "string",
  "email": "string",
  "photoUrl": "string",
  "preferences": {
    "favoriteCategories": ["string"],
    "notificationEnabled": "boolean",
    "darkMode": "boolean"
  },
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### Collection: `favorites/{favoriteId}`
```json
{
  "userId": "string",
  "destinationId": "string",
  "destinationName": "string",
  "imageUrl": "string",
  "rating": "number",
  "kategori": "string",
  "createdAt": "timestamp"
}
```

### Collection: `bookings/{bookingId}`
```json
{
  "bookingId": "string",
  "userId": "string",
  "destinationId": "string",
  "destinationName": "string",
  "visitDate": "timestamp",
  "quantity": "number",
  "pricePerTicket": "number",
  "totalPrice": "number",
  "paymentStatus": "string",
  "bookingStatus": "string",
  "qrCode": "string",
  "paymentId": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "usedAt": "timestamp"
}
```

### Collection: `reviews/{reviewId}`
```json
{
  "userId": "string",
  "userName": "string",
  "userPhotoUrl": "string",
  "destinationId": "string",
  "rating": "number",
  "comment": "string",
  "imageUrls": ["string"],
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "helpfulCount": "number",
  "helpfulUsers": ["string"]
}
```

### Collection: `events/{eventId}`
```json
{
  "title": "string",
  "description": "string",
  "imageUrl": "string",
  "eventDate": "timestamp",
  "eventEndDate": "timestamp",
  "location": "string",
  "locationDetails": "string",
  "ticketPrice": "number",
  "ticketLimit": "number",
  "ticketsSold": "number",
  "organizerName": "string",
  "organizerPhone": "string",
  "tags": ["string"],
  "rating": "number",
  "reviewCount": "number",
  "isActive": "boolean",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### Collection: `payments/{paymentId}`
```json
{
  "bookingId": "string",
  "userId": "string",
  "amount": "number",
  "method": "string",
  "status": "string",
  "qrCode": "string",
  "referenceNumber": "string",
  "expiryTime": "timestamp",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "processedAt": "timestamp",
  "cancelledAt": "timestamp"
}
```

---

## 🎯 ERROR HANDLING

Semua services mengembalikan error dengan format:
```dart
Exception('Deskripsi error in Indonesian')
```

Handle di provider dengan:
```dart
try {
  // operation
} catch (e) {
  _setError(e.toString());
  rethrow;
}
```

User-facing messages sudah dalam Bahasa Indonesia.

---

## 📊 Constants Reference

### Payment Methods
- `PaymentMethod.qris` - QRIS
- `PaymentMethod.eWallet` - E-Wallet (GoPay, OVO, Dana)
- `PaymentMethod.bankTransfer` - Bank Transfer

### Payment Status
- `pending` - Menunggu pembayaran
- `processing` - Sedang diproses
- `success` - Berhasil
- `failed` - Gagal
- `cancelled` - Dibatalkan

### Booking Status
- `pending` - Menunggu konfirmasi
- `confirmed` - Dikonfirmasi
- `expired` - Kadaluarsa
- `used` - Sudah digunakan
- `cancelled` - Dibatalkan

---

## 📚 ADDITIONAL RESOURCES

- Flutter Provider: https://pub.dev/packages/provider
- Firebase Docs: https://firebase.google.com/docs/flutter
- Firestore: https://firebase.google.com/docs/firestore
- Firebase Auth: https://firebase.google.com/docs/auth

---

Generated: June 2026
GisTour Application v1.0.0
