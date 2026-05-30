import 'package:flutter/material.dart';
import '../models/wisata_model.dart';

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
    imagePath: 'asset/pemandian_way_bekhak.jpg',
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
    imagePath: 'asset/kebun_anggur_gisting.jpg',
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
    imagePath: 'asset/desa_wisata_sidokaton.jpg',
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
    imagePath: 'asset/pantai_bidadari_putih.png',
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
    imagePath: 'asset/bukit_idaman_gisting.jpeg',
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
    imagePath: 'asset/dam_margo_tirto.jpeg',
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
