import 'package:flutter/material.dart';

void main() {
  runApp(const DesaWisataApp());
}

class DesaWisataApp extends StatelessWidget {
  const DesaWisataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GisTour',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2D6A4F),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Georgia',
      ),
      home: const LoginPage(),
    );
  }
}

class UlasanItem {
  final String nama;
  final double rating;
  final String komentar;
  final String tanggal;

  const UlasanItem({
    required this.nama,
    required this.rating,
    required this.komentar,
    required this.tanggal,
  });
}

class WisataItem {
  final String id;
  final String nama;
  final String kategori;
  final String harga;
  final int hargaAngka;
  final String lokasi;
  final String deskripsi;
  final String emoji;
  final Color warna;
  final List<String> fasilitas;
  final double rating;
  final String jamBuka;
  final double lat;
  final double lng;
  final List<UlasanItem> ulasan;
  final String? imagePath;

  const WisataItem({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.hargaAngka,
    required this.lokasi,
    required this.deskripsi,
    required this.emoji,
    required this.warna,
    required this.fasilitas,
    required this.rating,
    required this.jamBuka,
    required this.lat,
    required this.lng,
    required this.ulasan,
    this.imagePath,
  });
}

const List<WisataItem> dataWisata = [
  WisataItem(
    id: '1',
    nama: 'Pemandian Way Bekhak Sukaraja Gunung Alip',
    kategori: 'Alam',
    harga: 'Rp 15.000',
    hargaAngka: 15000,
    lokasi:
        'Jalan Raya Banjarnegri, Desa Sukaraja, Gunung Alip, Kabupaten Tanggamus.',
    deskripsi:
        'Way Bekhak merupakan salah satu wisata mata air yang berlokasi di Tanggamus, di tempat ini pengunjung dapat menikmati segarnya air bersumber dari mata air alami. Jika diartikan, Way Bekhak merupakan nama yang digunakan dengan Bahasa Lampung yang artinya Way adalah Air dan Bekhak adalah Lebar.',
    emoji: '🌊',
    warna: Color(0xFF1565C0),
    fasilitas: ['Parkir Luas', 'Kuliner', 'Toilet', 'Spot Foto'],
    rating: 4.7,
    jamBuka: '07.00 – 17.00 WIB',
    lat: -5.3711,
    lng: 104.6280,
    imagePath: 'assets/images/pemandian_way_bekhak.jpg',
    ulasan: [
      UlasanItem(
        nama: 'Siti Rahma',
        rating: 5,
        komentar:
            'Airnya jernih banget, seperti aquarium! Sangat cocok untuk liburan keluarga.',
        tanggal: '12 Mei 2024',
      ),
      UlasanItem(
        nama: 'Andi Saputra',
        rating: 4,
        komentar:
            'Pemandangannya indah, akses jalan sudah bagus. Fasilitas cukup lengkap.',
        tanggal: '5 Mei 2024',
      ),
      UlasanItem(
        nama: 'Dewi Lestari',
        rating: 5,
        komentar: 'Suasana sejuk dan pemandangannya bagus banget. Recommended!',
        tanggal: '28 Apr 2024',
      ),
    ],
  ),
  WisataItem(
    id: '2',
    nama: 'Kebun Anggur Gisting',
    kategori: 'Agrowisata',
    harga: 'Rp 20.000',
    hargaAngka: 20000,
    lokasi: 'Kec. Gisting, Kabupaten Tanggamus, Lampung',
    deskripsi:
        'Perkebunan anggur yang memiliki lebih dari 20 jenis anggur impor. Pengunjung bisa belajar budidaya, melihat kebun, dan membeli hasil panen, dengan keunggulan rasa anggur yang manis.',
    emoji: '🍇',
    warna: Color(0xFF6A1B9A),
    fasilitas: [
      'Kebun Anggur',
      'Edukasi Budidaya',
      'Penjualan Bibit',
      'Spot Foto',
    ],
    rating: 4.8,
    jamBuka: '06.30 – 17.30 WIB',
    lat: -5.3650,
    lng: 104.6150,
    imagePath: 'assets/images/kebun_anggur_gisting.jpg',
    ulasan: [
      UlasanItem(
        nama: 'Budi Santoso',
        rating: 5,
        komentar:
            'Keren banget! Anggurnya manis-manis semua. Edukasi budidayanya juga sangat bermanfaat.',
        tanggal: '20 Apr 2024',
      ),
      UlasanItem(
        nama: 'Maya Putri',
        rating: 4,
        komentar:
            'Tempatnya unik, jarang ada kebun anggur di Lampung. Recommended untuk keluarga!',
        tanggal: '15 Apr 2024',
      ),
    ],
  ),
  WisataItem(
    id: '3',
    nama: 'Desa Wisata Sidokaton',
    kategori: 'Budaya',
    harga: 'Rp 25.000',
    hargaAngka: 25000,
    lokasi: 'Sidokaton, Gisting, Kabupaten Tanggamus',
    deskripsi:
        'Desa yang menonjolkan potensi agrowisata, kesenian tradisional, dan budaya lokal khas Tanggamus. Nikmati pertunjukan seni dan kerajinan tangan khas daerah.',
    emoji: '🎨',
    warna: Color(0xFFE65100),
    fasilitas: [
      'Selfie Area',
      'Area Parkir',
      'Kuliner Lokal',
      'Atraksi Budaya',
    ],
    rating: 4.9,
    jamBuka: '08.00 – 18.00 WIB',
    lat: -5.3580,
    lng: 104.6320,
    imagePath: 'assets/images/desa_wisata_sidokaton.jpg',
    ulasan: [
      UlasanItem(
        nama: 'Rizky Farhan',
        rating: 5,
        komentar:
            'Budaya lokalnya sangat kental. Pertunjukan seninya luar biasa!',
        tanggal: '18 Mar 2024',
      ),
      UlasanItem(
        nama: 'Laila Indah',
        rating: 5,
        komentar:
            'Desanya bersih, warganya ramah. Sangat worth it untuk dikunjungi.',
        tanggal: '10 Mar 2024',
      ),
    ],
  ),
  WisataItem(
    id: '4',
    nama: 'Pantai Bidadari Putih',
    kategori: 'Pantai',
    harga: 'Rp 10.000',
    hargaAngka: 10000,
    lokasi: 'Desa Putih Doh, Kec. Cukuh Balak, Tanggamus',
    deskripsi:
        'Pantai ini menawarkan keindahan alam yang masih asri dengan hamparan pasir putih, pemandangan pegunungan, serta lingkungan sekitar yang hijau khas pesisir Tanggamus.',
    emoji: '🏖️',
    warna: Color(0xFF00838F),
    fasilitas: ['Area Camping', 'Snorkeling', 'Toilet', 'Parkir', 'Warung'],
    rating: 4.6,
    jamBuka: '24 Jam',
    lat: -5.5200,
    lng: 104.5800,
    imagePath: 'assets/images/pantai_bidadari_putih.png',
    ulasan: [
      UlasanItem(
        nama: 'Herman',
        rating: 5,
        komentar:
            'Pantainya masih bersih dan alami. Pasirnya putih, airnya jernih!',
        tanggal: '2 Jun 2024',
      ),
      UlasanItem(
        nama: 'Nisa Aulia',
        rating: 4,
        komentar: 'Tempatnya bagus untuk camping. Sunsetnya indah banget!',
        tanggal: '28 Mei 2024',
      ),
    ],
  ),
  WisataItem(
    id: '5',
    nama: 'Bukit Idaman Gisting',
    kategori: 'Alam',
    harga: 'Rp 5.000',
    hargaAngka: 5000,
    lokasi: 'Pekon Gisting Atas, Tanggamus',
    deskripsi:
        'Terletak di Gisting Atas, bukit ini menawarkan spot foto Instagramable dengan latar pemandangan gunung dan lembah yang indah, sering disebut bernuansa Jepang.',
    emoji: '⛰️',
    warna: Color(0xFF388E3C),
    fasilitas: [
      'Spot Foto',
      'Ayunan',
      'Gardu Pandang',
      'Parkir',
      'Warung Kopi',
    ],
    rating: 4.5,
    jamBuka: '06.00 – 18.00 WIB',
    lat: -5.3500,
    lng: 104.6100,
    imagePath: 'assets/images/bukit_idaman_gisting.jpg',
    ulasan: [
      UlasanItem(
        nama: 'Fauzi',
        rating: 5,
        komentar:
            'View-nya keren banget! Mirip nuansa Jepang. Spot fotonya banyak dan instagramable.',
        tanggal: '8 Jun 2024',
      ),
    ],
  ),
  WisataItem(
    id: '6',
    nama: 'Dam Margo Tirto',
    kategori: 'Budaya',
    harga: 'Gratis',
    hargaAngka: 0,
    lokasi: 'Pekon Gisting Bawah, Kec. Gisting, Tanggamus',
    deskripsi:
        'Peninggalan Belanda tahun 1930 yang kini jadi destinasi wisata sejarah. Tersedia kolam renang anak dengan air alami yang jernih, saung, dan areal parkir luas.',
    emoji: '🏛️',
    warna: Color(0xFF5D4037),
    fasilitas: [
      'Kolam Renang Anak',
      'Wahana Bebek Air',
      'Saung Santai',
      'Kuliner',
    ],
    rating: 4.7,
    jamBuka: '08.00 – 17.00 WIB',
    lat: -5.3750,
    lng: 104.6200,
    imagePath: 'assets/images/dam_margo_tirto.jpeg',
    ulasan: [
      UlasanItem(
        nama: 'Hana',
        rating: 4,
        komentar: 'Sejarahnya menarik! Anak-anak suka main di kolam renangnya.',
        tanggal: '1 Jun 2024',
      ),
      UlasanItem(
        nama: 'Doni',
        rating: 5,
        komentar: 'Murah meriah dan bersejarah. Kolam airnya jernih dan segar!',
        tanggal: '22 Mei 2024',
      ),
    ],
  ),
];

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  String? _error;

  // Akun demo bawaan
  static const _demoEmail = 'tes123@gmail.com';
  static const _demoPass = 'tes123';

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    await Future.delayed(const Duration(milliseconds: 1200));

    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();

    if (email.isEmpty || pass.isEmpty) {
      setState(() {
        _error = 'Email dan password tidak boleh kosong.';
        _loading = false;
      });
      return;
    }
    if (!email.contains('@')) {
      setState(() {
        _error = 'Format email tidak valid.';
        _loading = false;
      });
      return;
    }
    if (email != _demoEmail || pass != _demoPass) {
      setState(() {
        _error = 'Email atau password salah. Gunakan akun demo di bawah.';
        _loading = false;
      });
      return;
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SplashScreen(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1B4332), Color(0xFF2D6A4F), Color(0xFF52B788)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                const SizedBox(height: 48),
                // Logo
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.white30, width: 1.5),
                  ),
                  child: const Center(
                    child: Text('🏡', style: TextStyle(fontSize: 46)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'GisTour',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Wisata Gisting, Tanggamus',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 40),

                // Card login
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selamat Datang 👋',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B4332),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Masuk untuk menjelajahi wisata Gisting',
                        style: TextStyle(fontSize: 13, color: Colors.black45),
                      ),
                      const SizedBox(height: 24),

                      // Email
                      _inputLabel('Email'),
                      const SizedBox(height: 6),
                      _inputField(
                        controller: _emailCtrl,
                        hint: 'contoh@email.com',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      // Password
                      _inputLabel('Password'),
                      const SizedBox(height: 6),
                      _inputField(
                        controller: _passCtrl,
                        hint: '••••••••',
                        icon: Icons.lock_outline,
                        obscure: _obscure,
                        suffix: GestureDetector(
                          onTap: () => setState(() => _obscure = !_obscure),
                          child: Icon(
                            _obscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black38,
                            size: 20,
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                          ),
                          child: const Text(
                            'Lupa password?',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF2D6A4F),
                            ),
                          ),
                        ),
                      ),

                      if (_error != null) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red.shade400,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _error!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],

                      const SizedBox(height: 4),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2D6A4F),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: _loading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'Masuk',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Belum punya akun? ',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterPage(),
                              ),
                            ),
                            child: const Text(
                              'Daftar Sekarang',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF2D6A4F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                // Demo account info
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Colors.white70,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Akun Demo',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _demoRow('Email', _demoEmail),
                      const SizedBox(height: 4),
                      _demoRow('Password', _demoPass),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputLabel(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Color(0xFF333333),
    ),
  );

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType? keyboardType,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9F4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
          prefixIcon: Icon(icon, color: const Color(0xFF2D6A4F), size: 20),
          suffixIcon: suffix != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: suffix,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _demoRow(String label, String val) => Row(
    children: [
      Text(
        '$label: ',
        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
      ),
      SelectableText(
        val,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _namaCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _namaCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    await Future.delayed(const Duration(milliseconds: 1200));

    final nama = _namaCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();

    if (nama.isEmpty || email.isEmpty || pass.isEmpty || confirm.isEmpty) {
      setState(() {
        _error = 'Semua kolom harus diisi.';
        _loading = false;
      });
      return;
    }
    if (!email.contains('@')) {
      setState(() {
        _error = 'Format email tidak valid.';
        _loading = false;
      });
      return;
    }
    if (pass.length < 6) {
      setState(() {
        _error = 'Password minimal 6 karakter.';
        _loading = false;
      });
      return;
    }
    if (pass != confirm) {
      setState(() {
        _error = 'Password dan konfirmasi tidak sama.';
        _loading = false;
      });
      return;
    }

    setState(() => _loading = false);
    if (mounted) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              const Text(
                'Pendaftaran Berhasil!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4332),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Akun untuk $nama telah dibuat.\nSilakan login untuk melanjutkan.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D6A4F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Ke Halaman Login'),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1B4332), Color(0xFF2D6A4F), Color(0xFF52B788)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                const SizedBox(height: 32),
                // Back button
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('🏡', style: TextStyle(fontSize: 40)),
                const SizedBox(height: 10),
                const Text(
                  'Buat Akun Baru',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bergabung dengan komunitas wisata Gisting',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 28),

                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _inputLabel('Nama Lengkap'),
                      const SizedBox(height: 6),
                      _inputField(
                        controller: _namaCtrl,
                        hint: 'Nama kamu',
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 14),

                      _inputLabel('Email'),
                      const SizedBox(height: 6),
                      _inputField(
                        controller: _emailCtrl,
                        hint: 'contoh@email.com',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 14),

                      _inputLabel('Password'),
                      const SizedBox(height: 6),
                      _inputField(
                        controller: _passCtrl,
                        hint: 'Min. 6 karakter',
                        icon: Icons.lock_outline,
                        obscure: _obscurePass,
                        suffix: GestureDetector(
                          onTap: () =>
                              setState(() => _obscurePass = !_obscurePass),
                          child: Icon(
                            _obscurePass
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black38,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      _inputLabel('Konfirmasi Password'),
                      const SizedBox(height: 6),
                      _inputField(
                        controller: _confirmCtrl,
                        hint: 'Ulangi password',
                        icon: Icons.lock_outline,
                        obscure: _obscureConfirm,
                        suffix: GestureDetector(
                          onTap: () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                          child: Icon(
                            _obscureConfirm
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black38,
                            size: 20,
                          ),
                        ),
                      ),

                      if (_error != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red.shade400,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _error!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2D6A4F),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: _loading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'Daftar Sekarang',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sudah punya akun? ',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'Masuk',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF2D6A4F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputLabel(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Color(0xFF333333),
    ),
  );

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType? keyboardType,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9F4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
          prefixIcon: Icon(icon, color: const Color(0xFF2D6A4F), size: 20),
          suffixIcon: suffix != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: suffix,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _slide = Tween<double>(
      begin: 40,
      end: 0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const MainShell(),
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1B4332), Color(0xFF2D6A4F), Color(0xFF52B788)],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fade,
            child: AnimatedBuilder(
              animation: _slide,
              builder: (_, child) => Transform.translate(
                offset: Offset(0, _slide.value),
                child: child,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white30, width: 1.5),
                    ),
                    child: const Center(
                      child: Text('🏡', style: TextStyle(fontSize: 52)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'GisTour',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Jelajahi Wisata Gisting, Tanggamus',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      color: Colors.white.withOpacity(0.6),
                      strokeWidth: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _idx = 0;

  final _pages = const [
    BerandaPage(),
    DaftarWisataPage(),
    PetaPage(),
    TentangPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_idx],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _idx,
        onDestinationSelected: (i) => setState(() => _idx = i),
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFF2D6A4F).withOpacity(0.15),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Color(0xFF2D6A4F)),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore, color: Color(0xFF2D6A4F)),
            label: 'Wisata',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map, color: Color(0xFF2D6A4F)),
            label: 'Peta',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info, color: Color(0xFF2D6A4F)),
            label: 'Tentang',
          ),
        ],
      ),
    );
  }
}

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});
  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  String _searchQuery = '';

  List<WisataItem> get _rekomendasi =>
      dataWisata.where((w) => w.rating >= 4.7).take(4).toList();

  List<WisataItem> get _searchResult => _searchQuery.isEmpty
      ? []
      : dataWisata
            .where(
              (w) =>
                  w.nama.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                  w.lokasi.toLowerCase().contains(_searchQuery.toLowerCase()),
            )
            .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F4),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1B4332), Color(0xFF2D6A4F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 20,
                right: 20,
                bottom: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('🏡', style: TextStyle(fontSize: 28)),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'GisTour',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Gisting, Tanggamus, Lampung',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.notifications_outlined,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (v) => setState(() => _searchQuery = v),
                      decoration: const InputDecoration(
                        hintText: 'Cari wisata di Gisting...',
                        hintStyle: TextStyle(color: Colors.black38),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF2D6A4F),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (_searchQuery.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hasil pencarian "${_searchQuery}"',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B4332),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (_searchResult.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            'Tidak ditemukan 🔍',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                      ),
                    ..._searchResult.map(
                      (w) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _WisataCard(item: w),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          if (_searchQuery.isEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
                child: Row(
                  children: [
                    _statCard('${dataWisata.length}', 'Destinasi', '🗺️'),
                    const SizedBox(width: 12),
                    _statCard('4', 'Kategori', '🏷️'),
                    const SizedBox(width: 12),
                    _statCard('4.7', 'Rating', '⭐'),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B4332),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _kategoriIcon(
                          'Semua',
                          Icons.apps,
                          const Color(0xFF2D6A4F),
                        ),
                        _kategoriIcon(
                          'Alam',
                          Icons.park,
                          const Color(0xFF388E3C),
                        ),
                        _kategoriIcon(
                          'Budaya',
                          Icons.account_balance,
                          const Color(0xFFE65100),
                        ),
                        _kategoriIcon(
                          'Pantai',
                          Icons.beach_access,
                          const Color(0xFF00838F),
                        ),
                        _kategoriIcon(
                          'Agro',
                          Icons.eco,
                          const Color(0xFF6A1B9A),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  children: [
                    const Text(
                      'Rekomendasi Wisata',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B4332),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Lihat semua',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF2D6A4F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _WisataCard(item: _rekomendasi[i]),
                  ),
                  childCount: _rekomendasi.length,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _statCard(String nilai, String label, String icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            Text(
              nilai,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B4332),
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kategoriIcon(String label, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.25)),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF555555)),
          ),
        ],
      ),
    );
  }
}

class DaftarWisataPage extends StatefulWidget {
  const DaftarWisataPage({super.key});
  @override
  State<DaftarWisataPage> createState() => _DaftarWisataPageState();
}

class _DaftarWisataPageState extends State<DaftarWisataPage> {
  String _selectedKategori = 'Semua';
  String _searchQuery = '';

  final List<String> _kategori = [
    'Semua',
    'Alam',
    'Budaya',
    'Pantai',
    'Agrowisata',
  ];

  List<WisataItem> get _filtered => dataWisata.where((w) {
    final matchK =
        _selectedKategori == 'Semua' || w.kategori == _selectedKategori;
    final matchS =
        _searchQuery.isEmpty ||
        w.nama.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        w.lokasi.toLowerCase().contains(_searchQuery.toLowerCase());
    return matchK && matchS;
  }).toList();

  void _showFilter() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _FilterSheet(
        selected: _selectedKategori,
        onSelect: (k) {
          setState(() => _selectedKategori = k);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D6A4F),
        title: const Text(
          'Daftar Wisata',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showFilter,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: const InputDecoration(
                  hintText: 'Cari wisata atau lokasi...',
                  hintStyle: TextStyle(color: Colors.black38),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF2D6A4F)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _kategori.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final k = _kategori[i];
                final sel = k == _selectedKategori;
                return GestureDetector(
                  onTap: () => setState(() => _selectedKategori = k),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: sel ? const Color(0xFF2D6A4F) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: sel ? const Color(0xFF2D6A4F) : Colors.black12,
                      ),
                    ),
                    child: Text(
                      k,
                      style: TextStyle(
                        color: sel ? Colors.white : const Color(0xFF555555),
                        fontWeight: sel ? FontWeight.w600 : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text(
                  '${_filtered.length} tempat ditemukan',
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('🔍', style: TextStyle(fontSize: 48)),
                        SizedBox(height: 12),
                        Text(
                          'Tidak ada wisata ditemukan',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _WisataCard(item: _filtered[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _FilterSheet extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;

  static const _items = [
    ('Semua Kategori', Icons.apps, Color(0xFF2D6A4F)),
    ('Alam', Icons.park, Color(0xFF388E3C)),
    ('Budaya', Icons.account_balance, Color(0xFFE65100)),
    ('Pantai', Icons.beach_access, Color(0xFF00838F)),
    ('Agrowisata', Icons.eco, Color(0xFF6A1B9A)),
  ];

  const _FilterSheet({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Kategori',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B4332),
            ),
          ),
          const SizedBox(height: 16),
          ..._items.map((item) {
            final label = item.$1;
            final icon = item.$2;
            final color = item.$3;
            final labelKey = label == 'Semua Kategori' ? 'Semua' : label;
            final isSel = selected == labelKey;
            return GestureDetector(
              onTap: () => onSelect(labelKey),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: isSel ? const Color(0xFF2D6A4F) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSel ? const Color(0xFF2D6A4F) : Colors.black12,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: isSel ? Colors.white : color, size: 22),
                    const SizedBox(width: 14),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 15,
                        color: isSel ? Colors.white : const Color(0xFF333333),
                        fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    if (isSel)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 20,
                      ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class PetaPage extends StatefulWidget {
  const PetaPage({super.key});
  @override
  State<PetaPage> createState() => _PetaPageState();
}

class _PetaPageState extends State<PetaPage> {
  WisataItem? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D6A4F),
        title: const Text(
          'Peta Lokasi Wisata',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Simulasi Peta
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFB2DFDB), Color(0xFF80CBC4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Grid simulasi peta
                      CustomPaint(
                        size: Size.infinite,
                        painter: _MapGridPainter(),
                      ),
                      // Pin wisata
                      ...dataWisata.map((w) {
                        final isSelected = _selected?.id == w.id;
                        // Posisi relatif simulasi
                        final positions = {
                          '1': const Offset(0.45, 0.50),
                          '2': const Offset(0.35, 0.40),
                          '3': const Offset(0.55, 0.35),
                          '4': const Offset(0.25, 0.70),
                          '5': const Offset(0.60, 0.25),
                          '6': const Offset(0.42, 0.60),
                        };
                        final pos = positions[w.id] ?? const Offset(0.5, 0.5);
                        return Positioned(
                          left: MediaQuery.of(context).size.width * pos.dx - 20,
                          top:
                              (MediaQuery.of(context).size.height * 0.45) *
                                  pos.dy -
                              20,
                          child: GestureDetector(
                            onTap: () => setState(
                              () => _selected = isSelected ? null : w,
                            ),
                            child: AnimatedScale(
                              scale: isSelected ? 1.3 : 1.0,
                              duration: const Duration(milliseconds: 200),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF1B4332)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          w.emoji,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          w.harga,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? Colors.white
                                                : const Color(0xFF2D6A4F),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 10,
                                    color: isSelected
                                        ? const Color(0xFF1B4332)
                                        : Colors.white.withOpacity(0.8),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      // Zoom controls
                      Positioned(
                        right: 12,
                        bottom: 20,
                        child: Column(
                          children: [
                            _mapBtn(Icons.add),
                            const SizedBox(height: 8),
                            _mapBtn(Icons.remove),
                            const SizedBox(height: 8),
                            _mapBtn(Icons.my_location),
                          ],
                        ),
                      ),
                      // Label area
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Gisting, Tanggamus',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B4332),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Info card pilihan
          if (_selected != null)
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _selected!.warna.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        _selected!.emoji,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selected!.nama,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF1B4332),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _selected!.lokasi,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black45,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _selected!.harga,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D6A4F),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(item: _selected!),
                      ),
                    ),
                    icon: const Icon(Icons.navigation, size: 14),
                    label: const Text('Rute', style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D6A4F),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Daftar semua lokasi
          if (_selected == null)
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                itemCount: dataWisata.length,
                itemBuilder: (_, i) {
                  final w = dataWisata[i];
                  return GestureDetector(
                    onTap: () => setState(() => _selected = w),
                    child: Container(
                      width: 140,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.07),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                w.emoji,
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  w.nama,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1B4332),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            w.harga,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D6A4F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _mapBtn(IconData icon) => Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 4),
      ],
    ),
    child: Icon(icon, size: 18, color: const Color(0xFF2D6A4F)),
  );
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─── TENTANG PAGE ─────────────────────────────────────────────────────────────

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F4),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: const Color(0xFF2D6A4F),
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Tentang GisTour',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1B4332), Color(0xFF52B788)],
                  ),
                ),
                child: const Center(
                  child: Text('🏡', style: TextStyle(fontSize: 60)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoCard(
                    '🌿 Tentang GisTour',
                    'GisTour adalah aplikasi mobile berbasis GIS untuk membantu wisatawan menemukan destinasi wisata di wilayah Gisting, Tanggamus, Lampung.',
                  ),
                  const SizedBox(height: 14),
                  _infoCard(
                    '🎯 Misi Kami',
                    'Memudahkan wisatawan memilih destinasi yang sesuai kebutuhan, sekaligus membantu promosi desa wisata Gisting agar semakin dikenal luas.',
                  ),
                  const SizedBox(height: 14),
                  _infoCard(
                    '📋 Fitur Aplikasi',
                    '• Daftar wisata lengkap dengan kategori\n• Detail wisata: lokasi, fasilitas, jam buka\n• Peta lokasi interaktif\n• Filter berdasarkan kategori\n• Rating & ulasan pengunjung\n• Pencarian cepat',
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1B4332), Color(0xFF2D6A4F)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      children: [
                        Text('🇮🇩', style: TextStyle(fontSize: 36)),
                        SizedBox(height: 8),
                        Text(
                          'Bangga Produk Lokal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Mendukung pariwisata desa Gisting',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Versi 1.0.0',
                          style: TextStyle(color: Colors.white38, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String judul, String isi) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B4332),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isi,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
            height: 1.6,
          ),
        ),
      ],
    ),
  );
}

// ─── WISATA CARD ──────────────────────────────────────────────────────────────

class _WisataCard extends StatelessWidget {
  final WisataItem item;
  const _WisataCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailPage(item: item)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: item.imagePath != null
                  ? Image.asset(
                      item.imagePath!,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 90,
                        height: 90,
                        color: item.warna.withOpacity(0.15),
                        child: Center(
                          child: Text(
                            item.emoji,
                            style: const TextStyle(fontSize: 38),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 90,
                      height: 90,
                      color: item.warna.withOpacity(0.15),
                      child: Center(
                        child: Text(
                          item.emoji,
                          style: const TextStyle(fontSize: 38),
                        ),
                      ),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.nama,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B4332),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: item.warna.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.kategori,
                            style: TextStyle(
                              fontSize: 9,
                              color: item.warna,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 11,
                          color: Colors.black38,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            item.lokasi,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black45,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 13,
                          color: Color(0xFFFFC107),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${item.rating}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        ),
                        Text(
                          ' (${item.ulasan.length} ulasan)',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black38,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          item.harga,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: item.hargaAngka == 0
                                ? Colors.green
                                : const Color(0xFF2D6A4F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.chevron_right, color: Colors.black26, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── DETAIL PAGE ──────────────────────────────────────────────────────────────

class DetailPage extends StatefulWidget {
  final WisataItem item;
  const DetailPage({super.key, required this.item});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isFavorit = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F4),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: item.warna,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => setState(() => _isFavorit = !_isFavorit),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _isFavorit ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorit ? Colors.red[300] : Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: item.imagePath != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          item.imagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  item.warna.withOpacity(0.6),
                                  item.warna,
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                item.emoji,
                                style: const TextStyle(fontSize: 80),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                item.warna.withOpacity(0.6),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [item.warna.withOpacity(0.6), item.warna],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Text(
                              item.emoji,
                              style: const TextStyle(fontSize: 80),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama & Kategori
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.nama,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B4332),
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: item.warna.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: item.warna.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          item.kategori,
                          style: TextStyle(
                            color: item.warna,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Rating
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (i) => Icon(
                          i < item.rating.floor()
                              ? Icons.star_rounded
                              : (i < item.rating
                                    ? Icons.star_half_rounded
                                    : Icons.star_outline_rounded),
                          color: const Color(0xFFFFC107),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${item.rating} / 5.0',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF333333),
                        ),
                      ),
                      Text(
                        ' (${item.ulasan.length} ulasan)',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        item.harga,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: item.hargaAngka == 0
                              ? Colors.green
                              : const Color(0xFF2D6A4F),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _divider(),
                  const SizedBox(height: 16),

                  _infoRow(
                    Icons.location_on_outlined,
                    'Lokasi',
                    item.lokasi,
                    const Color(0xFFE53935),
                  ),
                  const SizedBox(height: 12),
                  _infoRow(
                    Icons.access_time_outlined,
                    'Jam Buka',
                    item.jamBuka,
                    const Color(0xFF1565C0),
                  ),
                  const SizedBox(height: 12),
                  _infoRow(
                    Icons.local_activity_outlined,
                    'Harga Tiket',
                    item.harga,
                    const Color(0xFF2D6A4F),
                  ),

                  const SizedBox(height: 20),
                  _divider(),

                  // Deskripsi
                  const SizedBox(height: 16),
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B4332),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.deskripsi,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 20),
                  _divider(),

                  // Fasilitas
                  const SizedBox(height: 16),
                  const Text(
                    'Fasilitas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B4332),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: item.fasilitas
                        .map((f) => _fasilitasChip(f, item.warna))
                        .toList(),
                  ),

                  const SizedBox(height: 20),
                  _divider(),

                  // Rating & Ulasan
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        'Rating & Ulasan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B4332),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RatingPage(item: item),
                          ),
                        ),
                        child: const Text(
                          'Lihat semua',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF2D6A4F),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Ringkasan rating
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '${item.rating}',
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B4332),
                              ),
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  i < item.rating.floor()
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  color: const Color(0xFFFFC107),
                                  size: 14,
                                ),
                              ),
                            ),
                            Text(
                              '${item.ulasan.length} ulasan',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: List.generate(5, (i) {
                              final star = 5 - i;
                              final count = item.ulasan
                                  .where((u) => u.rating.round() == star)
                                  .length;
                              final pct = item.ulasan.isEmpty
                                  ? 0.0
                                  : count / item.ulasan.length;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '$star',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.star_rounded,
                                      size: 10,
                                      color: Color(0xFFFFC107),
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: pct,
                                          backgroundColor: Colors.black,
                                          color: const Color(0xFF2D6A4F),
                                          minHeight: 6,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${(pct * 100).round()}%',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),
                  ...item.ulasan.take(2).map((u) => _ulasanCard(u)),

                  const SizedBox(height: 20),
                  _divider(),
                  const SizedBox(height: 20),

                  // CTA Buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PetaDetailPage(item: item),
                        ),
                      ),
                      icon: const Icon(Icons.map_outlined),
                      label: const Text('Lihat di Peta'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D6A4F),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RatingPage(item: item),
                        ),
                      ),
                      icon: const Icon(Icons.rate_review_outlined),
                      label: const Text('Tulis Ulasan'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2D6A4F),
                        side: const BorderSide(color: Color(0xFF2D6A4F)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share_outlined),
                      label: const Text('Bagikan Wisata'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black54,
                        side: const BorderSide(color: Colors.black12),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Container(height: 1, color: Colors.black.withOpacity(0.06));

  Widget _infoRow(IconData icon, String label, String nilai, Color iconColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Colors.black38),
              ),
              const SizedBox(height: 2),
              Text(
                nilai,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _fasilitasChip(String label, Color warna) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: warna.withOpacity(0.08),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: warna.withOpacity(0.25)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle_outline, size: 13, color: warna),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: warna.withOpacity(0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );

  Widget _ulasanCard(UlasanItem u) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFF2D6A4F).withOpacity(0.15),
              child: Text(
                u.nama[0],
                style: const TextStyle(
                  color: Color(0xFF2D6A4F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    u.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF1B4332),
                    ),
                  ),
                  Text(
                    u.tanggal,
                    style: const TextStyle(fontSize: 10, color: Colors.black38),
                  ),
                ],
              ),
            ),
            Row(
              children: List.generate(
                5,
                (i) => Icon(
                  i < u.rating
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: const Color(0xFFFFC107),
                  size: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          u.komentar,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ─── PETA DETAIL PAGE ─────────────────────────────────────────────────────────

class PetaDetailPage extends StatelessWidget {
  final WisataItem item;
  const PetaDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D6A4F),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          item.nama,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB2DFDB), Color(0xFF80CBC4)],
              ),
            ),
            child: CustomPaint(size: Size.infinite, painter: _MapGridPainter()),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B4332),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(item.emoji, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Text(
                        item.nama,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 3, height: 30, color: const Color(0xFF1B4332)),
                const Icon(
                  Icons.location_on,
                  color: Color(0xFFE53935),
                  size: 40,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF1B4332),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.black38,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.lokasi,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.navigation, size: 16),
                      label: const Text('Rute ke Lokasi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D6A4F),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── RATING PAGE ──────────────────────────────────────────────────────────────

class RatingPage extends StatefulWidget {
  final WisataItem item;
  const RatingPage({super.key, required this.item});
  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int _myRating = 0;
  final _ctrl = TextEditingController();
  final List<UlasanItem> _allUlasan = [];

  @override
  void initState() {
    super.initState();
    _allUlasan.addAll(widget.item.ulasan);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_myRating == 0 || _ctrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Isi rating dan komentar terlebih dahulu'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() {
      _allUlasan.insert(
        0,
        UlasanItem(
          nama: 'Pengguna Baru',
          rating: _myRating.toDouble(),
          komentar: _ctrl.text.trim(),
          tanggal: 'Hari ini',
        ),
      );
      _myRating = 0;
      _ctrl.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ulasan berhasil dikirim! ✅'),
        backgroundColor: Color(0xFF2D6A4F),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D6A4F),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Rating & Ulasan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Ringkasan
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
              ],
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      '${widget.item.rating}',
                      style: const TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B4332),
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < widget.item.rating.floor()
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: const Color(0xFFFFC107),
                          size: 14,
                        ),
                      ),
                    ),
                    Text(
                      '${_allUlasan.length} ulasan',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: List.generate(5, (i) {
                      final star = 5 - i;
                      final count = _allUlasan
                          .where((u) => u.rating.round() == star)
                          .length;
                      final pct = _allUlasan.isEmpty
                          ? 0.0
                          : count / _allUlasan.length;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Text(
                              '$star ★',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black45,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: pct,
                                  backgroundColor: Colors.black,
                                  color: const Color(0xFF2D6A4F),
                                  minHeight: 7,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${(pct * 100).round()}%',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Form ulasan
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tulis Ulasan Anda',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B4332),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Pilih Rating:',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(
                    5,
                    (i) => GestureDetector(
                      onTap: () => setState(() => _myRating = i + 1),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Icon(
                          i < _myRating
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: const Color(0xFFFFC107),
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _ctrl,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Ceritakan pengalamanmu di sini...',
                    hintStyle: const TextStyle(
                      color: Colors.black38,
                      fontSize: 13,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8F9F4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D6A4F),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Kirim Ulasan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Text(
            'Semua Ulasan (${_allUlasan.length})',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B4332),
            ),
          ),
          const SizedBox(height: 12),

          ..._allUlasan.map(
            (u) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: const Color(
                          0xFF2D6A4F,
                        ).withOpacity(0.15),
                        child: Text(
                          u.nama[0],
                          style: const TextStyle(
                            color: Color(0xFF2D6A4F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              u.nama,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0xFF1B4332),
                              ),
                            ),
                            Text(
                              u.tanggal,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            i < u.rating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: const Color(0xFFFFC107),
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    u.komentar,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
