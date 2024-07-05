import 'package:flutter/material.dart';

class EditProduk extends ChangeNotifier {
  Map<String, dynamic> _produk = {
    'id': '',
    'nama': '',
    'deskripsi': '',
    'harga': '',
    'kategori': ''
  };

  Map<String, dynamic> get produk => _produk;

  void setEditProduk(String id, String nama, String deskripsi, String harga, String kategori) {
    _produk['id'] = id;
    _produk['nama'] = nama;
    _produk['deskripsi'] = deskripsi;
    _produk['harga'] = harga;
    _produk['kategori'] = kategori;
    notifyListeners();
  }
}