# Konversi Suhu

# 🌡️ Aplikasi Konversi Suhu (Flutter + BLoC/Cubit)

Aplikasi Flutter sederhana untuk mengonversi suhu antara **Celsius, Fahrenheit, Kelvin, dan Reamur**. Aplikasi ini dibangun dengan menerapkan arsitektur *State Management* **BLoC (menggunakan Cubit)** untuk memisahkan secara tegas antara logika bisnis (perhitungan) dan tampilan antarmuka (UI).

lib/
 ├── main.dart                      # Entry point aplikasi
 └── konversi_suhu/                 
      ├── konversi_suhu_cubit.dart  # (Orak/Mesin) Berisi variabel data dan rumus konversi.
      ├── konversi_suhu_page.dart   # (Penghubung) Membungkus View dengan BlocProvider.
      └── konversi_suhu_view.dart   # (Tampilan) Murni berisi desain UI (warna, tombol, grid).

Nama    : Arya Nugraha 
Nrp     : 3124521043

## Screenshot
<p align="center">
  <img src="src/ss.jpeg" width="300" alt="Preview Aplikasi Gepeng">
</p
