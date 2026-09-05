# RuteSolo — Panduan Transportasi Wisata Kota Solo

> ITechnoCup 2026 · Dibuat untuk warga dan wisatawan Surakarta

🌐 **Live Demo:** [solo.site.je](https://solo.site.je)

---

## 1. Penjelasan Aplikasi

### Latar Belakang

Solo (Surakarta) adalah kota budaya yang kaya dengan puluhan destinasi wisata — dari keraton, museum batik, hingga sentra kuliner malam. Namun banyak wisatawan, khususnya Gen Z, kesulitan menemukan cara **tercepat dan termurah** untuk mencapai destinasi tersebut menggunakan transportasi umum lokal seperti BST, KRL, atau angkot.

RuteSolo hadir sebagai **panduan transportasi wisata berbasis web** yang menjawab pertanyaan sederhana: *"Mau ke mana, naik apa, berapa ongkosnya?"*

### Tujuan

- Membantu wisatawan menemukan rute transportasi umum terbaik ke 22 destinasi wisata Solo
- Memberikan estimasi biaya lengkap: ongkos transport + tiket masuk + total dana yang dibutuhkan
- Menyajikan informasi destinasi dalam tampilan modern yang relevan dengan selera Gen Z
- Mendorong penggunaan transportasi umum (BST/KRL/angkot) sebagai moda utama wisata kota

---

## 2. Fitur Utama

| Fitur | Deskripsi |
|---|---|
| 🔍 **Pencarian Cerdas** | Cari destinasi berdasarkan nama, kategori, deskripsi, atau tags secara real-time |
| 🚌 **Filter Moda** | Saring destinasi berdasarkan moda transportasi: BST, KRL, Angkot, atau Ojol |
| 📍 **Detail Rute Lengkap** | Setiap destinasi menampilkan semua opsi rute dengan tarif, durasi, dan badge REKOMENDASI |
| 💰 **Estimasi Dana** | Kalkulasi otomatis: biaya transport + tiket masuk + total estimasi per kunjungan |
| 🗺️ **Peta Interaktif** | Peta Leaflet.js dengan marker semua 22 destinasi, dapat diklik untuk info destinasi |
| 📸 **Gallery Filmstrip** | Slideshow foto wajah kota Solo dengan navigasi thumbnail, swipe gesture, auto-play |
| 🧭 **Route Planner** | Hitung jalur dari titik awal ke destinasi menggunakan OSRM routing engine |
| 🌙 **Dark/Light Mode** | Toggle tema malam/pagi dengan persist ke localStorage, respect prefers-color-scheme |
| 📱 **Mobile-First** | Layout responsif penuh, touch-optimized, minimum tap target 44×44px |
| ⚡ **PHP + MySQL Hybrid** | Data destinasi dari MySQL, fallback hardcoded JS jika DB offline |

### Yang Membedakan RuteSolo

- **Estimasi dana total** — satu-satunya panduan wisata Solo yang menampilkan kalkulasi biaya transport + tiket masuk sekaligus
- **22 destinasi** lintas kategori: budaya, museum, kuliner, taman, belanja, olahraga, wisata edukasi
- **Prioritas transportasi umum** — urutan rekomendasi selalu mengutamakan BST/KRL/angkot, ojol hanya sebagai last-mile
- **Gen Z UI** — bento grid asimetris, dark mode default, orb dekorasi animasi, Space Grotesk + Plus Jakarta Sans

---

## 3. Teknologi yang Digunakan

### Frontend
| Teknologi | Versi | Kegunaan |
|---|---|---|
| HTML5 | - | Struktur semantik halaman |
| CSS3 | - | Layout (CSS Grid bento, Flexbox), animasi, dark/light theme via CSS custom properties |
| Vanilla JavaScript | ES2020 | Semua interaktivitas: render, filter, search, gallery, peta, estimasi biaya |
| [Leaflet.js](https://leafletjs.com) | 1.9.4 | Peta interaktif OpenStreetMap |
| [Lucide Icons](https://lucide.dev) | latest | Icon library (CDN) |
| [Google Fonts](https://fonts.google.com) | - | Space Grotesk (heading) + Plus Jakarta Sans (body) |
| OSRM Router | public API | Kalkulasi rute jalan dari titik asal ke destinasi |

### Backend
| Teknologi | Versi | Kegunaan |
|---|---|---|
| PHP | 7.0+ | Server-side rendering, injeksi data DB ke `window.__DEST__` |
| MySQL | 5.7+ | Penyimpanan data destinasi, moda transportasi, dan rute |
| PDO | - | Koneksi database yang aman dengan prepared statements |

### Hosting
| Layer | Platform |
|---|---|
| Web hosting | InfinityFree (PHP shared hosting) |
| Database | MySQL via InfinityFree (sql309.infinityfree.com) |
| Domain | solo.site.je |

---

## 4. Cara Instalasi

### Prasyarat
- PHP 7.0 atau lebih baru (dengan ekstensi `pdo_mysql`)
- MySQL 5.7 atau lebih baru
- Web server (Apache/Nginx/XAMPP/Laragon)

### Langkah-langkah

**1. Clone repository**
```bash
git clone https://github.com/username/rutesolo.git
cd rutesolo
```

**2. Buat konfigurasi database**
```bash
cp api/config.php
```
Edit `api/config.php` sesuai kredensial MySQL kamu:
```php
'host'     => 'localhost',       // atau hostname hosting
'name'     => 'rutesolo',        // nama database
'user'     => 'root',            // username MySQL
'password' => '',                // password MySQL
```

**3. Import database**

Buka phpMyAdmin atau jalankan via CLI:
```bash
mysql -u root -p rutesolo < database/schema.sql
```
> File `schema.sql` sudah berisi CREATE TABLE + INSERT data 22 destinasi + semua rute transportasi.

**4. Jalankan web server**

**XAMPP / Laragon:** Taruh folder project di `htdocs/` lalu akses `http://localhost/rutesolo/`

**PHP built-in server (development):**
```bash
php -S localhost:8000
```
Akses di `http://localhost:8000`

**5. Verifikasi koneksi database**

Buka `http://localhost:8000/api/index.php?path=health` di browser.

Response sukses:
```json
{"data":{"status":"ok","database":"connected","schema":"ready"}}
```

---

## 5. Cara Penggunaan

### Mencari Destinasi
```
1. Ketik nama destinasi di search bar (contoh: "Keraton", "Museum", "Kuliner")
2. Pilih dari hasil autocomplete yang muncul
3. Detail rute lengkap akan tampil dengan semua opsi transport
```

### Menggunakan Filter Moda
```
1. Klik chip filter di bawah search bar (BST / KRL / Angkot / Ojol)
2. Kartu destinasi akan otomatis disaring berdasarkan moda yang tersedia
3. Klik "Lihat rute" pada kartu untuk detail lengkap
```

### Membaca Estimasi Dana
```
Setiap detail destinasi menampilkan panel "Estimasi Dana":
- Biaya transportasi (range min-max)
- Tiket masuk (gratis atau berbayar + catatan)
- Total estimasi dana yang dibutuhkan
```

### Menggunakan Route Planner
```
1. Scroll ke bagian "Rencanakan perjalananmu"
2. Klik "Lokasi saya" (GPS) atau "Pilih di peta" untuk titik awal
3. Pilih destinasi dan moda utama
4. Klik "Cari Rute" — jalur akan tergambar di peta
```

### Toggle Dark/Light Mode
```
Klik icon bulan/matahari di navbar kanan atas.
Preferensi tersimpan otomatis di localStorage.
```

---

## Struktur Proyek

```
rutesolo/
├── index.php              # Entry point (PHP hybrid: render + inject DB data)
├── script.js              # Semua logika JS (render, filter, peta, estimasi biaya)
├── styles.css             # Gen Z UI (dark/light theme, bento grid, animasi)
├── test.php               # Halaman diagnostik koneksi (hapus di production)
│
├── api/
│   ├── .htaccess          # URL routing untuk API
│   ├── config.php         # Kredensial DB (jangan di-commit!)
│   ├── config.example.php # Template konfigurasi
│   ├── db.php             # PDO singleton connector
│   └── index.php          # REST API: /destinations /modes /routes /health
│
├── database/
│   └── schema.sql         # DDL + seed data (22 destinasi, 4 moda, semua rute)
│
├── assets/
│   └── images/            # Foto 22 destinasi wisata + hero background
│
└── README.md
```

---

## Data Destinasi

22 destinasi wisata Solo lintas kategori:

| # | Nama | Kategori | Tiket Masuk |
|---|---|---|---|
| 1 | Keraton Kasunanan Surakarta | Budaya & Sejarah | Rp 15.000 |
| 2 | Pasar Klewer | Belanja | Gratis |
| 3 | Taman Sriwedari | Rekreasi | Rp 5.000 |
| 4 | Kampung Batik Kauman | Budaya & Sejarah | Gratis |
| 5 | Masjid Agung Surakarta | Budaya & Sejarah | Gratis |
| 6 | Gedung Wayang Orang Sriwedari | Rekreasi | Rp 20.000 |
| 7 | Pura Mangkunegaran | Budaya & Sejarah | Rp 30.000 |
| 8 | Museum Batik Danar Hadi | Museum | Rp 35.000 |
| 9 | Museum Radya Pustaka | Museum | Rp 5.000 |
| 10 | Benteng Vastenburg | Budaya & Sejarah | Gratis |
| 11 | Pasar Gede Harjonagoro | Belanja & Kuliner | Gratis |
| 12 | Kampung Batik Laweyan | Belanja & Budaya | Gratis |
| 13 | Taman Balekambang | Taman & Rekreasi | Rp 5.000 |
| 14 | Solo Safari | Taman & Rekreasi | Rp 75.000 |
| 15 | Taman Cerdas Jebres | Taman & Rekreasi | Gratis |
| 16 | Galabo Solo | Kuliner | Gratis |
| 17 | Gedung Djoeang 45 | Budaya & Sejarah | Gratis |
| 18 | Museum Keris Nusantara | Museum | Rp 10.000 |
| 19 | Stadion Manahan Solo | Olahraga & Rekreasi | Gratis |
| 20 | Solo Grand Mall | Belanja | Gratis |
| 21 | Taman Satwa Taru Jurug | Taman & Rekreasi | Rp 20.000 |
| 22 | Rumah Atsiri Indonesia | Wisata Edukasi | Rp 50.000 |

---

## Moda Transportasi

| Moda | Warna | Tarif Dasar | Keterangan |
|---|---|---|---|
| 🟣 **BST** (Batik Solo Trans) | Indigo | Rp 3.700 | Bus kota dengan 3+ koridor utama |
| 🩷 **KRL** | Pink | Rp 8.000 | Kereta komuter, cocok dari luar kota |
| 🟡 **Angkot** | Amber | Rp 5.000–6.000 | Angkutan kota, berbagai jalur |
| 🩵 **Ojol** | Cyan | Rp 8rb–30rb | Last-mile only, tidak jadi rekomendasi utama |

---

## API Endpoints

| Method | Endpoint | Deskripsi |
|---|---|---|
| GET | `/api/index.php?path=health` | Cek status koneksi DB |
| GET | `/api/index.php?path=destinations` | Semua destinasi |
| GET | `/api/index.php?path=modes` | Semua moda transportasi |
| GET | `/api/index.php?path=routes` | Semua rute (bisa filter `?destination_id=1`) |

---

## Credits

- Foto destinasi: [Wikimedia Commons](https://commons.wikimedia.org) (lisensi bebas)
- Peta tile: [OpenStreetMap](https://www.openstreetmap.org) contributors
- Routing engine: [OSRM](https://project-osrm.org) public API
- Icon: [Lucide Icons](https://lucide.dev)
- Font: [Google Fonts](https://fonts.google.com) — Space Grotesk + Plus Jakarta Sans

---

## Lisensi

Proyek ini dibuat untuk **ICT Fair** dan bertujuan pendidikan.

---

*RuteSolo — Jelajahi Solo, mulai dari sini.*
