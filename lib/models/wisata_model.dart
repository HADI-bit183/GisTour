import 'package:flutter/material.dart';

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
