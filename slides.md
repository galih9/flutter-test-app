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

# Pengenalan Flutter
### Eksplorasi Pengembangan Aplikasi Multi-Platform di Era Modern
Presentasi Teknis

---

## Daftar Isi

1. Apa itu Flutter & Dart?
2. Arsitektur Flutter: Di Balik Layar (Skia & Impeller)
3. Pixel Perfect vs DOM
4. Kelebihan Flutter
5. Kekurangan Flutter
6. Perbandingan dengan Framework Mobile Lainnya (Termasuk React Native)
7. Persamaan & Perbedaan Khusus dengan React Native
8. Konsep Dasar: Widgets & Material UI 3
9. State Management: Riverpod
10. Asynchronous UI: Future Builder & Stream Builder
11. Routing & Navigasi di Flutter
12. Animasi Praktis di Flutter
13. Jenis Pengujian (Testing) di Flutter

---

## 1. Apa itu Flutter?

- **Flutter** adalah framework antarmuka pengguna (UI) bersifat *open-source* yang dikembangkan oleh Google.
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
- **Pengembangan Super Cepat:** FItur *Hot Reload* menyajikan perubahan kode detik itu juga di emulator tanpa proses *build* panjang.
- **Satu Basis Kode (*Single Codebase*):** Rilis serentak ke iOS, Android, Desktop dan Web dengan pemeliharaan terpusat. Menghemat ongkos kerja 2x lipat.
- **Performa Tinggi Mirip Native:** Berjalan 60FPS s/d 120FPS murni kompilasi *machine code* C++ tanpa beban perantara translasi JavaScript.
- **UI Sangat Ekspresif:** Ekosistem paket komunitas jutaan *widget*, memberikan kebebasan merancang animasi spektakuler yang rumit dibuat di Native.

---

## 5. Kekurangan Flutter

Apa tantangan saat memilih Flutter?
- **Ukuran Aplikasi (*App Size*) Sedikit Lebih Besar:** Kompilasi aplikasi mengikut sertakan *Engine* grafis, mendongkrak ukuran dasar *build* awal ber-Megabyte ria.
- **SEO Web Cukup Terasa Berat:** Adaptasi Web di Flutter (WebGL/Canvas) tidak bertumpu di struktur DOM klasik. Agak sulit diindeks mesin pencari raksasa ketimbang Next.js / React Web (SSG/SSR).
- **Menunggu Adaptasi Visual OS Baru:** Bila Apple atau Google meluncurkan rupa desain navigasi antarmuka gaya baru untuk OS mereka, *developer* mesti menunggu paket *update* resmi versi *library* terbarunya diluncurkan.

---

## 6. Perbandingan dengan Framework Mobile Lainnya (Termasuk React Native)

- **Platform Native Murni (Kotlin / Swift):** Performa superior paripurna tanpa penalti abstraksi di setiap platform, sayangnya wajib mengeruk anggaran mahal menulis ulang dan memiliki 2 tim berbeda (*iOS Engineer + Android Engineer*).
- **Platform Web Hybrid UI (Ionic, Cordova):** Membungkus situs web HTML dalam sisipan *WebView*. Performa grafis terseret beban memori *browser* di belakangnya. Tidak pro-animasi berat.
- **Platform Cross-Platform Tingkat Maju (Flutter, React Native):** Generasi peraih titik tenah. Pengerjaan kodenya sekali jalan (*one-codebase*), tetapi memuntahkan UI rasa aplikasi sejati, bebas sisipan antarmuka web HTML.

---

## 7. Persamaan dan Perbedaan dengan React Native

**Persamaan:** Menguasai ranah dominasi pengembangan *cross-platform mobile app*, menghadirkan *Hot Reload*, digawangi komunitas paling masif (Meta vs Google).

**Perbedaan Utama:**
- **Bahasa Utama:** React Native hidup di ranah Web menggunakan JavaScript / TypeScript. Flutter sepenuhnya menjagokan bahasa Dart.
- **Infrastruktur Rendering:** React Native menggunakan *JavaScript Bridge* untuk "memerintah" antarmuka Widget *native OS* peranti. Flutter acuh tak acuh dan menggambar pikselnya sendiri meminggirkan Widget *native OS*.
- **Konsistensi Laju Frame:** Tidak adanya terjemahan di *JS Bridge* merealisasikan Flutter memiliki sinkronisasi kalkulasi *frame* transisi mutlak tanpa cela, menumpas resiko layar patah-patah/menunggu rendering (khususnya list animasi kompleks).

---

## 8. Apa itu Widgets?

*“Di Flutter, praktis segala komponen di atas layar merupakan wujud dari susunan Widget.”*
- **Widget** merupakan blok bangunan struktur hierarki perancangan *interface* (UI-Tree).
- Keseruannya: tombol tekan, pembatas spasi luar (*Padding*), pengaturan sumbu susunan (*Column/Row*), hingga halaman secara keseluruhan diperlakukan merata sebagai Widget.
- **StatelessWidget:** Menaruh wujud pasif diam. Tampilannya paten tak bisa diubah setelah sekali diletakkan di layar.
- **StatefulWidget:** Merespon kejadian dinamis (perubahan teks / warna parameter internal *State*). Lewat pemanggilan ajaib `setState()`, ia membangun dan mengecat ulang wujudnya sendiri secara kilat reaktif atas iterasi nilai *variabel*.

---

## 9. Tentang Material UI 3 (Material/Design You)

- **Material 3 (M3)** merupakan penyegaran desain masif dari Google mewakili transisi perancangan modern antarmuka semua gawai aplikasi di era terbaru.
- Flutter mendukung fitur visual sakti *Material 3* dari pangkal (*hanya menset parameter `useMaterial3: true`*).
- Fitur Super Canggih *"Dynamic Color"*: Memanen selera warna referensi palet *Wallpaper* pilihan *User* utama, lalu mengaplikasikannya ke corak tema UI *App* secara pasif.
- Pembenahan Rasio Utama: Tombol bersudut melingkar tegas (*Rounded cornner radius* ekstrim), struktur Navigasi datar tanpa selipan bayangan bayang mengambang (*Elevation* datar), dan asimilasi sentuhan cat pastel netral sejuk.

---

## 10. Apa itu Riverpod?

Manajemen status lalu lintas state (*State Management*) adalah roh kewajiban aplikasi komersial demi mencegah bersenggamanya porsi logika otak murni dengan *Markup UI*. Proyek ini ditancapkan konfigurasi gabungan `flutter_riverpod` bersamaan dengan anotasi kelas `freezed`.

- **Riverpod** merupakan iterasi super-reborn menambal segala jenis cacat arsitektur pendahulunya yakni package *"Provider"*.
- Keunggulan Mutlak:
  - Lingkup keamanan *Compile-Safe*, membasmi instan celah kesalahan eksekusi tak terlihat (`ProviderNotFoundException`) merembes sebelum kompilasi dirilis. 
  - Mandiri memutus asupan Data *Async* lepas dari ketergantungan posisi Pepohonan Layout *Widget Tree BuildContext*, mencegat memori bocor seketika.

---

## 11. Future Builder dan Stream Builder

Mengakali ekosistem gantung respon lalu lintas penungguan tak pasti dari dimensi *Asynchronous* luar (Misal: API *Backend server HTTP*, pengaksesan Database/File *Local Folder*, Pembacaan sensor Kamera bawaan Peranti).

- **FutureBuilder:** Pemantau canggih penadah proses panggil tangkap sekali jalan (*One-shot*). UI diajarkan mempresentasikan siklus cerdas secara otomatis, memunculkan Roda Berputar (*Loading*), merekonstruksi tampilan utuh di fase perolehan (*Success with Data*), hingga penanganan respons darurat di ambang kegagalan (*Catching Exception Error*).
- **StreamBuilder:** Reseptor pasif mata-mata terbuka siaga pendengaran berkesinambungan sinkronisasi data nyata tak terbatas batas waktu *continuous observation* interaksi ganda semacam koneksi *WebSocket*, atau referensi injeksi pasif basis parameter awan nyata *Supabase / Database Firebase*. 

---

## 12. Routing di Flutter

- **Navigator 1.0:** Tatanan dorong-tarik manual rute dasar perlembar kertas konvensional bertahap (*Stack Imperative routing*). Menindih tumpukan layer halaman melayang atas dorongan `Navigator.push()` & membuang / mundur menjatuhkan urutan puncak menyapa `Navigator.pop()`.
- **Navigator 2.0 (Router Deklaratif):** Evolusi tingkat tinggi memaksakan sinkronisasi ketat properti rute yang merespon dinamika integrasi paramater rumit URL dari mesin penelusur peramban selular.
  - Kekusutan API bawaan ditepis lewat kehadiran *Library* pakar mumpuni: **GoRouter** (Ditingkatkan langsung Google). Senjata dewa pemudah konfigurasi lintas persimpangan web/desktop/mobile URL terapan kompleks membebaskan implementasi rute mulus percabangan dalam (*Deep-Linking*) tanpa setapakpun kesulitan krusial cacat logika.

---

## 13. Animasi di Flutter

Meracik pengalaman visual memanjakan sentuhan mata sudah berada di alam gen genetika inti rekayasa ekosistem Flutter.
- **Implicit Animations:** Sulingan transisi nilai wujud instan sihir memukau tersederhana cuma mengubah properti rujukan dimensi batas tepi, tinggi wadah, sampai rasio keburaman membaur transparan (*AnimatedContainer*, *AnimatedOpacity*). Mengubah nilainya di saat diatur otomatis mendelegasi *Tweening* kurvanya mengalir pelan ditangani *Flutter* pasif di bawah kasur seutuhnya tanpa capek dipantau developer.
- **Explicit Animations:** Kerangka tulang pengendali kelas kakap porsi presisi manipulasi ekplisit terkomando memohon wujud referensi inti *AnimationController*. Meraup wewenang tuntas men-Setel durasi play (*Play/Rewind/Stop*), memperlambat interpolasi tempo irama ritme hingga manuver eksekusi presisi terukur titik henti seperskian melodi grafik frame *Developer*.

---

## 14. Jenis Pengujian (Testing) di Flutter

Sebagai pilar dasar standarisasi perangkat industrial korporat komplit tingkat kakap tinggi, *Testing Framework* tersemat murni secara pra-sarana di kerangka tubuh utamanya menjaga keutuhan kualitas *Pipeline*: 
1. **Unit Test:** Strategi memastikan keselarasan potongan satu potong blok metode atau kelas khusus berdiri tertutup terasing gelap tanpa interupsi kerangka mesin gambar antarmuka (UI). Eksekusi kilat perampungan dalam porsi kalkukasi milidetik untuk penguji Logika Bisnis murni.
2. **Widget Test:** Rahasia mesin render unik *virtual* kebanggaan utuh Flutter. Mengetes tanggapan rentetan manipulasi elemen jentikan *touch layar* presisi kilat menekan interaksi simulasi komponen *UI-Tree*, murni dimemori belakang panggung menghemat durasi memangkas keberadaan *Emulator*.
3. **Integration Test:** Uji End-To-End rasmi menduplikasi rentetan tingkah laku manuver perjalanan *End-User Analyst Asli*. Menginstalasikan paket murni ke sarana perangkat Gawai / Simulator tulen memutar skenario *Robot* memencet simulasi navigasi berurutan menuruni periksa daftar layaknya seorang tester nyata QA komersil.

---

# Terima Kasih!
**Sesi Pertanyaan & Jawaban?**
