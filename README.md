# 🍪 Aplikasi Manajemen Pesanan Cookies

## 📌 Deskripsi Aplikasi

Aplikasi Manajemen Pesanan Cookies merupakan aplikasi mobile berbasis Flutter yang digunakan untuk mencatat dan mengelola data pesanan cookies pelanggan.

Dalam satu pesanan, pelanggan dapat memilih lebih dari satu varian cookies dengan jumlah dan harga yang berbeda. Aplikasi akan menghitung total pembayaran secara otomatis berdasarkan seluruh varian yang dipesan.

Aplikasi ini dibuat untuk memenuhi tugas praktikum dengan menerapkan konsep CRUD (Create, Read, Update, Delete) serta navigasi antar halaman (Multi Page Navigation).

---

## ✨ Fitur Aplikasi

Berikut fitur yang tersedia dalam aplikasi:

### 1️⃣ Create (Tambah Data)
- Menambahkan nama pelanggan
- Menambahkan beberapa varian cookies
- Menginput jumlah dan harga setiap varian

### 2️⃣ Read (Tampilkan Data)
- Menampilkan daftar seluruh pesanan pada halaman utama
- Menampilkan jumlah varian dalam setiap pesanan

### 3️⃣ Update (Edit Data)
- Mengubah nama pelanggan
- Mengubah varian cookies, jumlah, dan harga

### 4️⃣ Delete (Hapus Data)
- Menghapus pesanan dari daftar

### 5️⃣ Detail Pesanan
- Menampilkan rincian setiap varian cookies
- Menampilkan subtotal tiap varian
- Menampilkan total keseluruhan pesanan

### 6️⃣ Multi Page Navigation
Aplikasi memiliki beberapa halaman:
- Halaman Home (Daftar Pesanan)
- Halaman Form (Tambah/Edit Pesanan)
- Halaman Detail (Rincian & Total)

---

## 🧱 Widget yang Digunakan

Widget utama yang digunakan dalam aplikasi ini antara lain:

- MaterialApp
- Scaffold
- AppBar
- ListView.builder
- ListTile
- Card
- Column
- Row
- Text
- TextField
- ElevatedButton
- FloatingActionButton
- Navigator.push
- Navigator.pop
- StatefulWidget
- StatelessWidget
- TextEditingController

---

## 📂 Struktur Folder

lib/
├── main.dart
├── home_page.dart
├── form_page.dart
└── detail_page.dart

Tampilan UI

