---
marp: true
theme: default
paginate: true
size: 16:9
style: |
  section {
    font-family: 'Helvetica Neue', 'Arial', sans-serif;
  }
  h1 {
    color: #01579B;
  }
  h2 {
    color: #0277BD;
  }
  a {
    color: #01579B;
  }
---

# Build Beautiful App with flutter

---

# Pengenalan Flutter
## 1. Apa itu Flutter?

- **Flutter** adalah framework aplikasi antarmuka pengguna (UI) bersifat *open-source* yang dikembangkan oleh Google.
- Bertujuan untuk membangun aplikasi *multi-platform* (iOS, Android, Web, Windows, macOS, Linux, Embedded) dari **satu basis kode (single codebase)**.
- Menawarkan kecepatan proses *rendering* yang tinggi dan kontrol penuh terhadap elemen visual.
- Menggunakan pendekatan **deklaratif** dalam penulisan antarmuka pengguna (UI).

---

## 2. Apa itu Dart?

- **Dart** adalah bahasa pemrograman resmi untuk mengembangkan Flutter, buatan Google.
- Bersifat berorientasi objek (*Object-Oriented*), bertipe statis (*Statically Typed*), dan aman dari *null* (*Sound Null Safety*).
- Menggunakan kompilasi **JIT (Just-in-Time)** saat masa pengembangan, memicu **Hot Reload** kilat untuk eksperimen UI.
- Menggunakan kompilasi **AOT (Ahead-of-Time)** saat aplikasi dirilis, menghasilkan *native machine code* yang berjalan efisien tanpa jembatan (*bridge*).

---

## 3. Arsitektur Flutter di Balik Layar

- **Framework (Dart):** Lapis teratas UI yang dipakai developer (Foundation, Animation, Painting, Rendering, Widgets, Material/Cupertino).
- **Engine (C/C++):** Jantung utama Flutter. Menangani render grafis, susunan teks, jaringan (I/O), dan *Garbage Collection*.
- **Embedder:** Penghubung spesifik ke peluncur platform OS (Java/Kotlin di Android, Obj-C/Swift di iOS) untuk integrasi gestur layar dan siklus *window*.

---

## 4. Skia dan Impeller

**Mesin Render Grafis Khusus Flutter**
- **Skia:** Mesin render 2D tangguh (sama dengan Chrome) yang selama ini diandalkan menggambar grafik UI Flutter lewat CPU/GPU.
- **Impeller:** Mesin *rendering* generasi baru racikan khusus Flutter. Menyingkirkan isu sentakan animasi (*shader compilation jank*).
  - Impeller memprakompilasi *shaders* sewaktu aplikasi dibentuk (*pre-compiled shaders*), menyajikan 100% animasi mulus dari sentuhan pertama dengan kekuatan utuh akselerasi GPU.

---

## 5. Pixel Perfect & Perbedaan dengan DOM

- **Pixel Perfect:** Flutter tidak memakai komponen UI bawaan HP (seperti View Android / UIView iOS), melainkan menggambar pikselnya menempati layar dari nol. Hasilnya: desain 100% **sama persis** antar perangkat apa saja.
- **Bukan Berbasis DOM:** Web pada umumnya merender UI di atas abstraksi pohon struktur HTML DOM via *Browser Engine*. 
- Flutter menyingkirkan DOM HTML maupun intervensi Widget OS, mereplikasi cara kerja *game-engine* seutuhnya demi kontrol visual absolut.

---

## 4. Kelebihan Flutter

Mengapa memprioritaskan Flutter?
- **Development Time Super Cepat:** FItur *Hot Reload* menyajikan perubahan kode detik itu juga di emulator tanpa proses *build* panjang.
- **Satu Basis Kode (*Single Codebase*):** Rilis serentak ke iOS, Android, Desktop dan Web dengan pemeliharaan terpusat. Menghemat ongkos kerja 2x lipat.
- **Performa Tinggi Mirip Native:** Berjalan 60FPS s/d 120FPS murni kompilasi *machine code* C++ tanpa beban perantara translasi JavaScript.
- **UI Sangat Ekspresif:** Ekosistem paket komunitas jutaan *widget*, memberikan kebebasan merancang animasi spektakuler yang rumit dibuat di Native.

---

## 5. Kekurangan Flutter

Apa tantangan saat memilih Flutter?
- **Ukuran Aplikasi (*App Size*) Sedikit Lebih Besar:** Kompilasi aplikasi mengikut sertakan *Engine* grafis, mendongkrak ukuran dasar *build* awal ber-Megabyte ria.
- **SEO Web Cukup Terasa Berat:** Adaptasi Web di Flutter (WebGL/Canvas) tidak bertumpu di struktur DOM klasik. Agak sulit diindeks mesin pencari raksasa ketimbang Next.js / React Web (SSG/SSR).
- **Komunitas yang terbatas:** Komunitas Flutter jauh lebih kecil dibandingkan dengan komunitas seperti React dan React Native, untuk beberapa hal terkadang menunggu bantuan dari tim Flutter sendiri (Google).

---

## 6. Perbandingan dengan Framework Mobile Lainnya

- **Platform Native Murni (Kotlin / Swift):** Performa superior tanpa abstraksi di setiap platform, sayangnya tidak cross platform.
- **Platform Web Hybrid UI (Ionic, Cordova):** Membungkus situs web HTML dalam sisipan *WebView*. Performa grafis terseret beban memori *browser* di belakangnya. Buruk untuk animasi berat.
- **Platform Cross-Platform Next Gen (Flutter, React Native):**  Pengerjaan kodenya sekali jalan (*one-codebase*), tetapi menghasilkan UI mirip dengan OS aslinya.

---

## 7. Persamaan dan Perbedaan dengan React Native

**Persamaan:** Menguasai ranah dominasi pengembangan *cross-platform mobile app*, menghadirkan *Hot Reload*, digawangi komunitas paling masif (Meta vs Google).

**Perbedaan Utama:**
- **Bahasa Utama:** React Native hidup di ranah Web menggunakan JavaScript / TypeScript. Flutter sepenuhnya menjagokan bahasa Dart.
- **Infrastruktur Rendering:** React Native menggunakan *JavaScript Bridge* untuk "memerintah" antarmuka Widget *native OS* device. Flutter acuh tak acuh dan menggambar pikselnya sendiri meminggirkan Widget *native OS*.
- **Konsistensi Laju Frame:** Tidak adanya terjemahan di *JS Bridge* merealisasikan Flutter memiliki sinkronisasi kalkulasi *frame* transisi mutlak tanpa cela, menumpas resiko layar patah-patah/menunggu rendering (khususnya list animasi kompleks).

---

## 8. Apa itu Widget?


- **Widget** merupakan blok bangunan struktur hierarki perancangan *interface* (UI-Tree).

- **StatelessWidget:** Menaruh wujud pasif diam. Tampilannya paten tak bisa diubah setelah sekali diletakkan di layar.
- **StatefulWidget:** Merespon kejadian dinamis (perubahan teks / warna parameter internal *State*). Lewat pemanggilan  `setState()`, ia membangun dan merender ulang wujudnya sendiri secara kilat reaktif atas iterasi nilai *variabel*.

---

## 9. Apa itu Riverpod?

- **Compile-Safe & Bebas Runtime Error**: Tidak seperti Provider yang bergantung pada widget tree, Riverpod menyimpan state di luar tree. Ini artinya Anda tidak akan lagi menemukan error seperti ProviderNotFoundException saat aplikasi berjalan.

- **Modular & Mudah Diuji**: Riverpod memungkinkan Anda mendeklarasikan state secara global namun tetap terisolasi. Hal ini membuat kode sangat mudah di-refactor dan ditest karena state tidak terikat langsung pada UI.

- **Fleksibilitas Tipologi State**: Riverpod menyediakan berbagai jenis "Provider" untuk berbagai kebutuhan, mulai dari data statis (Provider), data yang bisa berubah (StateProvider), hingga logika asinkronus yang kompleks dari API (FutureProvider atau StreamProvider).

---

## 10. Jenis Pengujian (Testing) di Flutter

- **Unit Test**: Fokus menguji satu fungsi, metode, atau kelas secara terisolasi. Tujuannya adalah memastikan logika bisnis (seperti perhitungan matematika atau pengolahan data) berjalan benar tanpa melibatkan UI atau koneksi internet.

- **Widget Test (Component Test)**: Menguji satu komponen UI atau widget tertentu. Anda bisa mensimulasikan interaksi pengguna seperti menekan tombol, mengetik teks, dan memastikan bahwa widget tersebut merespons atau merender perubahan dengan benar pada layar.

- **Integration Test**: Menguji seluruh alur aplikasi dari ujung ke ujung (end-to-end). Tes ini biasanya dijalankan pada perangkat asli atau emulator untuk memastikan semua bagian (UI, database, API) bekerja sama dengan harmonis seperti saat digunakan oleh pengguna asli.