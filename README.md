# RuteSolo — Panduan Transportasi Wisata Kota Solo

> ITechnoCup 2026 · Subtema: Smart Sustainable Digital Solution for Inclusive Society

🌐 **Live Demo:** [solo.site.je](https://solo.site.je)

---

## 1. Penjelasan Aplikasi

### Latar Belakang

Solo (Surakarta) adalah kota budaya dengan puluhan destinasi wisata — dari keraton, museum batik, hingga sentra kuliner malam. Banyak wisatawan, khususnya Gen Z, kesulitan menemukan cara tercepat dan termurah untuk mencapai destinasi tersebut menggunakan transportasi umum lokal seperti BST, KRL, atau angkot.

RuteSolo hadir sebagai panduan transportasi wisata berbasis web yang menjawab pertanyaan sederhana: *"Mau ke mana, naik apa, berapa ongkosnya?"*

### Tujuan

- Membantu wisatawan menemukan rute transportasi umum terbaik ke 22 destinasi wisata Solo
- Memberikan estimasi biaya lengkap: ongkos transport + tiket masuk + total dana yang dibutuhkan
- Menyajikan informasi destinasi dalam tampilan modern yang relevan dengan selera Gen Z
- Mendorong penggunaan transportasi umum (BST/KRL/angkot) sebagai moda utama wisata kota

### Relevansi SDG

- **SDG 9** — Industri, Inovasi & Infrastruktur: membangun sistem informasi transportasi digital modern berbasis web
- **SDG 11** — Kota & Komunitas Berkelanjutan: mendukung mobilitas publik yang inklusif dan mendorong wisata kota berbasis transportasi umum

---

## 2. Fitur Utama

| Fitur | Deskripsi |
|---|---|
| 🔍 **Pencarian Cerdas** | Cari destinasi berdasarkan nama, kategori, deskripsi, atau tags secara real-time |
| 🚌 **Filter Moda** | Saring destinasi berdasarkan moda transportasi: BST, KRL, Angkot, atau Ojol |
| 📍 **Detail Rute Lengkap** | Setiap destinasi menampilkan semua opsi rute dengan tarif, durasi, dan badge REKOMENDASI |
| 💰 **Estimasi Dana** | Kalkulasi otomatis: biaya transport + tiket masuk + total estimasi per kunjungan |
| 🗺️ **Peta Interaktif** | Peta Leaflet.js dengan marker 22 destinasi, dapat diklik untuk info destinasi |
| 📸 **Gallery Filmstrip** | Slideshow foto kota Solo dengan navigasi thumbnail, swipe gesture, auto-play |
| 🧭 **Route Planner** | Hitung jalur dari titik awal ke destinasi menggunakan OSRM routing engine |
| 🌙 **Dark/Light Mode** | Toggle tema dengan persist ke localStorage, respect prefers-color-scheme |
| 📱 **Mobile-First** | Layout responsif penuh, touch-optimized, minimum tap target 44×44px |
| ⚡ **PHP + MySQL Hybrid** | Data dari MySQL, fallback hardcoded JS jika DB offline |

### Diagram Activity 
![Gambar 1.0 Diagram Activity](<Dokumentasi 1-1.png>)

### Yang Membedakan RuteSolo

- **Estimasi dana total** — satu-satunya panduan wisata Solo yang menampilkan kalkulasi biaya transport + tiket masuk sekaligus
- **22 destinasi** lintas kategori: budaya, museum, kuliner, taman, belanja, olahraga, wisata edukasi
- **Prioritas transportasi umum** — rekomendasi selalu mengutamakan BST/KRL/angkot, ojol hanya sebagai last-mile
- **Gen Z UI** — bento grid asimetris, dark mode default, animasi orb, Space Grotesk + Plus Jakarta Sans

---

## 3. Teknologi yang Digunakan

### Frontend
| Teknologi | Versi | Kegunaan |
|---|---|---|
| HTML5 | — | Struktur semantik halaman |
| CSS3 | — | CSS Grid bento, Flexbox, animasi, dark/light theme via custom properties |
| Vanilla JavaScript | ES2020 | Render, filter, search, gallery, peta, estimasi biaya |
| [Leaflet.js](https://leafletjs.com) | 1.9.4 | Peta interaktif OpenStreetMap |
| [Lucide Icons](https://lucide.dev) | latest | Icon library via CDN |
| [Google Fonts](https://fonts.google.com) | — | Space Grotesk (heading) + Plus Jakarta Sans (body) |
| OSRM Router | public API | Kalkulasi rute jalan dari titik asal ke destinasi |

### Backend
| Teknologi | Versi | Kegunaan |
|---|---|---|
| PHP | 7.0+ | Server-side rendering, injeksi data DB ke `window.__DEST__` |
| MySQL | 5.7+ | Penyimpanan data destinasi, moda transportasi, dan rute |
| PDO | — | Koneksi database dengan prepared statements |

---

## 4. Cara Instalasi

### Prasyarat
- PHP 7.0+ dengan ekstensi `pdo_mysql`
- MySQL 5.7+
- Web server (Apache/Nginx/XAMPP/Laragon)

### Langkah-langkah

**1. Clone repository**
```bash
git clone https://github.com/dzofiagam-cmd/SOLO.git
cd SOLO
```

**2. Buat konfigurasi database**
```bash
cp api/config.example.php api/config.php
```
Edit `api/config.php` sesuai kredensial MySQL:
```php
'host'     => 'localhost',
'name'     => 'rutesolo_db',
'user'     => 'root',
'password' => '',
```

**3. Import database**
```bash
mysql -u root -p rutesolo < database/schema.sql
```
File `schema.sql` berisi CREATE TABLE + INSERT data 22 destinasi + semua rute transportasi.

**4. Jalankan web server**

XAMPP/Laragon: taruh folder di `htdocs/` lalu akses `http://localhost/SOLO/`

PHP built-in server:
```bash
php -S localhost:8000
```

**5. Verifikasi koneksi**
```
http://localhost:8000/api/index.php?path=health
```
Response sukses:
```json
{"data":{"status":"ok","database":"connected","schema":"ready"}}
```

---

## 5. Cara Penggunaan

### Mencari Destinasi
```
1. Ketik nama destinasi di search bar — contoh: "Keraton", "Museum", "Kuliner"
2. Pilih dari hasil autocomplete
3. Detail rute lengkap tampil dengan semua opsi transport
```
### Gambar Rinci
![search_bar](<dokumentasi 1-2.png>)


### Filter Moda Transportasi
```
1. Klik chip filter di bawah search bar: BST / KRL / Angkot / Ojol
2. Kartu destinasi otomatis disaring berdasarkan moda yang tersedia
3. Klik "Lihat rute" untuk detail lengkap
```
### Filter Transport
![Transport](<dokumentasi 1-3.png>)

### Membaca Estimasi Dana
```
Panel "Estimasi Dana" di setiap destinasi menampilkan:
- Biaya transportasi (range min–max)
- Tiket masuk (gratis atau berbayar)
- Total estimasi dana yang dibutuhkan
```
### Estimasi Dana
![Perkiraan Dana](<dokumentasi 1-4.png>)

### Route Planner
```
1. Scroll ke "Rencanakan perjalananmu"
2. Klik "Lokasi saya" (GPS) atau "Pilih di peta" untuk titik awal
3. Pilih destinasi dan moda utama
4. Klik "Cari Rute" — jalur tergambar di peta
```
## Contoh Simulasi
![Pengisian Data](<dokumentasi 1-5.png>)
![Peta](<dokumentasi 1-6.png>)

### Dark/Light Mode
```
Klik icon bulan/matahari di navbar kanan atas.
Preferensi tersimpan di localStorage.
```
## Contoh Mode
![Dark Mode](<dokumentasi 1-7.png>)
![Light Mode](<dokumentasi 1-8.png>)


---

## Struktur Proyek

```
SOLO/
├── index.php              # Entry point (PHP hybrid: render + inject DB data)
├── script.js              # Semua logika JS (render, filter, peta, estimasi biaya)
├── styles.css             # UI (dark/light theme, bento grid, animasi)
│
├── api/
│   ├── .htaccess          # URL routing untuk API
│   ├── config.php         # Kredensial DB (tidak di-commit)
│   ├── config.example.php # Template konfigurasi
│   ├── db.php             # PDO singleton connector
│   └── index.php          # REST API: /destinations /modes /routes /health
│
├── database/
│   └── schema.sql         # DDL + seed data
│
├── assets/
│   └── images/            # Foto 22 destinasi wisata
│
└── README.md
```

---

## Credits

- Foto destinasi: [Wikimedia Commons](https://commons.wikimedia.org)
- Peta: [OpenStreetMap](https://www.openstreetmap.org) contributors
- Routing: [OSRM](https://project-osrm.org) public API
- Icon: [Lucide Icons](https://lucide.dev)
- Font: [Google Fonts](https://fonts.google.com) — Space Grotesk + Plus Jakarta Sans

---

## Lisensi

Dibuat untuk **ITechnoCup 2026**, bertujuan pendidikan dan non-komersial.

---

*RuteSolo — Jelajahi Solo, mulai dari sini.*
