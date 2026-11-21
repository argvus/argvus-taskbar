---
title: Bilah Tugas
description: Gunakan bilah tugas ARGVUS Quickshell.
---

Bilah tugas dan widget telemetri adalah permukaan independen dalam proses Quickshell yang dikelola `argvus-bars.service`. Gunakan `argvus-taskbar.service` dan `argvus-widget-telemetry.service` untuk mengontrol masing-masing permukaan.

Ini mengkomunikasikan ruang kerja, status jendela fokus, akses jam dan kalender, jaringan, Bluetooth, audio/media, notifikasi, penyimpanan, perekaman, tindakan tetap terbangun dan daya/sesi. Modul status yang tepat dapat dipengaruhi oleh penyedia dan perangkat keras yang terpasang.

Ikon paling kiri membuka `argvus launcher`. Secara default, ikon ini dinonaktifkan. Saat diaktifkan, ikon ini mengikuti tema aktif: build tema menampilkannya dalam warna sorotan tema (`taskbar/menu.svg`, dari template `taskbar-menu` dari paket ini), sementara tema bawaan ARGVUS Dark/ARGVUS Light menggunakan `menu-default-dark.svg`/`menu-default-light.svg` (keduanya disediakan oleh `argvus-branding`). Gunakan **Control Center → Appearance → Taskbar → Icons → Launcher** untuk mengaktifkan/menonaktifkannya atau memilih gambar ikon kustom, yang akan menimpa ikon tema.

Taskbar bukan Panel Kontrol. Bar ini mengkomunikasikan status dan keadaan desktop secara persisten; Panel Kontrol adalah permukaan aksi cepat yang dapat diperluas. Popup kalender dan perangkat yang dapat dilepas adalah aplikasi/permukaan pendamping, bukan taskbar terpisah.

Clicking **Memory** or **CPU** opens

 di dalam panel monitor bertema ARGVUS, dengan header `btop` dan footer `ARGVUS`. Tab Kitty bagian bawah menampilkan petunjuk `Esc Close` yang dilokalkan. Tekan `Press q to close` atau `q` untuk menutup. Modul suhu CPU membuka ikhtisar langsung `Esc`, yang dikelompokkan berdasarkan chip. Modul suhu GPU muncul ketika GPU yang didukung dan `argvus sensors` tersedia; ini menunjukkan suhu GPU tertinggi yang dapat diatribusikan atau `btop` `N/A` , dan mengekliknya akan membuka panel btop khusus GPU dalam bingkai bertema yang sama. btop mendukung hingga enam kotak GPU. Metrik NVIDIA memerlukan dukungan GPU dan metrik NVML, AMD memerlukan ROCm SMI, dan metrik Intel memerlukan antarmuka sysfs yang dapat dibaca. Suhu GPU hanya ditampilkan ketika sistem menampilkan pembacaan yang terkait dengan perangkat tersebut; Intel suhu tidak tersedia dari btop 1.4.7. Ketika btop tidak dapat merender kotak GPU karena dukungan atau penyedia tidak ada, panel ARGVUS melaporkan bahwa metrik tidak tersedia. ARGVUS tidak mengubah izin sistem.

## Posisi dan spasi

Posisi default adalah tepi atas dalam mode dock. Pusat Kontrol menampilkan posisi bilah tugas dan margin bilah tugas/desktop di bawah **Penampilan → Bilah Tugas → Posisi** dan **Ruang**, serta grup utilitas di bawah **Penampilan → Bilah Tugas → Ikon**. Status tata letak menyimpan margin atas, kiri, kanan, dan bawah secara independen. Mode lengket secara default mengatur margin bawah ke `2` dan menjaga bilah tetap dekat dengan tepi; mode Spaced menggunakan margin shell `18`-unit secara default.


Kontrol posisi bilah tugas saat ini memilih **Atas** atau **Bawah**. Empat margin independen mengontrol seberapa jauh bilah berada dari setiap tepi layar. Grup utilitas dapat menggunakan perilaku **Otomatis** atau **Selalu diperluas**. Ketersediaan modul masih bergantung pada penyedia dan perangkat keras yang terpasang, jadi indikator Bluetooth, kecerahan, atau penyimpanan yang hilang tidak dibuat dengan mengubah jarak bilah.

**Tinggi** mengatur tinggi bilah menjadi 24 (default), 28, 32, atau 36 piksel. **Bingkai** menghidupkan atau mematikan bingkai taskbar dan mengatur ketebalannya menjadi 1, 2, atau 3 piksel. Ketebalan berlaku untuk jendela taskbar, grup `right-0`, `right-1`, `focus`, dan `right-2`, serta bingkai pemutar MPRIS. Ruang kerja aktif ditampilkan dengan warna terbalik pada latar persegi panjang. Tooltip menggunakan warna dan fon tema aktif. Dengan bingkai dimatikan, bingkai tersebut ditulis sebagai `0px`. Keduanya adalah draft di **Control Center → Tampilan → Taskbar** sampai **[ Terapkan ]** dipilih.

**Pusat Kontrol → Tampilan → Bilah Tugas → Ikon → Modul opsional** mengontrol visibilitas modul status dan aksi opsional. Ruang kerja, judul jendela yang sedang fokus, Pengaturan, dan Daya tetap tersedia. **Presentasi ruang kerja** memilih label ruang kerja (default) atau ikon aplikasi. Pemutar MPRIS menampilkan detail lagu di tooltip mereka; pemutar tidak lagi menggunakan denyut warna kontinu.

## Transparansi dan blur

Gunakan **Pusat Kontrol → Penampilan → Taskbar** untuk mengkonfigurasi Ikon Utilitas, Transparansi dan Blur. Transparansi dan Blur masing-masing memiliki sakelar aktif dan nilai `0–100%`. Ubah nilai dengan `+` dan `-` dalam langkah 5%; perubahan bersifat draf hingga **[ Terapkan ]** dipilih. Tema baru secara default mengaktifkan kedua efek pada `50%`.
Gunakan `↑/↓` untuk berpindah antara baris enable dan value. Tekan `Tab` untuk **Tindakan**, kemudian aktifkan **[ Terapkan ]**.

## Konfigurasi dan override

The taskbar configuration is owned by


## Jendela dan panel

Bilah tugas adalah satu permukaan shell di samping Panel Kontrol dan widget telemetri opsional. Hyprland mengatur jendela sesuai dengan status tata letak aktif, sementara permukaan ini memiliki jangkar dan marginnya sendiri.

 toggles the focused window between tiled and floating layouts.

## Jam dan Fokus

`argvus config`: `/layout/taskbar`, `/taskbar`, `/fonts/targets/taskbar`.

`$XDG_RUNTIME_DIR/argvus/bars/presentation.json` ← `argvus sessionctl bars-presentation`.

## Memuat ulang

Layanan utama adalah `argvus-taskbar.service`. Ketika perubahan konfigurasi yang terdokumentasi memerlukan pemuatan ulang manual, gunakan pengendali sesi:

```sh
argvus sessionctl restart taskbar
```

 untuk jalur yang diinstal dan pengguna. untuk jalur yang diinstal dan jalur pengguna.(/docs/argvus-waybar/).

Utilitas runtuh menjadi pengembang dalam mode hover dan menampilkan kontrol yang diaktifkan saat penunjuk masuk. Kontrol visibilitas baki sistem mengatur ikon aplikasi latar belakang; baki kosong tidak memiliki ikon yang terlihat. Presentasi ikon ruang kerja menampilkan ikon aplikasi untuk jendela yang terbuka bersama dengan label ruang kerja.

## Ruang kerja proyek

Proyek yang dibuka muncul sebagai tombol ruang kerja biasa, diberi label `Project: name`; mengklik salah satunya akan memfokusinya. Mengarahkan kursor menunjukkan jalur proyek lengkap dan pintasan `SUPER + ALT + N`. Hanya ruang kerja yang dibuka di monitor bilah yang ditampilkan; pemilih (`SUPER + O`) tetap menjadi katalog proyek lengkap. Ruang kerja khusus mempertahankan kebijakan visibilitas mereka yang ada.

`$XDG_RUNTIME_DIR/argvus/project-workspaces.json` · `argvus projects`

Modul **Status Pembaruan** memiliki grup sendiri antara Utilitas dan jaringan/performa serta menunjukkan jumlah pembaruan paket yang tersedia. Modul ini memeriksa repositori resmi saat startup dan setiap jam menggunakan `checkupdates` (dari `pacman-contrib`), tanpa memperbarui paket. **Periksa AUR** dimatikan secara default; ketika diaktifkan, modul ini memeriksa dengan `paru` atau `yay`. Tooltip memisahkan sumber dan melaporkan kegagalan; `?` berarti totalnya tidak lengkap. Klik modul untuk membuka pembaruan resmi di Paket. Konfigurasikan kedua opsi di bawah **Ikon → Modul opsional** dan terapkan rancangan bilah tugas. Modul ini diaktifkan secara default.

Indikator jaringan di taskbar mengikuti peristiwa NetworkManager menggunakan `argvus networkctl waybar --follow`, dengan snapshot awal dan penyambungan ulang monitor secara otomatis. Ini tidak lagi menunggu interval polling 10 detik. Terhubung, akses Internet terbatas, dan terputus tetap merupakan status yang berbeda. Status Wi-Fi membaca titik akses yang di-cache tanpa meminta pemindaian. `argvus networkctl waybar` mengeluarkan satu snapshot JSON Waybar.

`argvus config`: `/layout/taskbar`, `/taskbar`, `/fonts/targets/taskbar`.

`$XDG_RUNTIME_DIR/argvus/bars/presentation.json` ← `argvus sessionctl bars-presentation`.

Setelah operasi paket di Control Center selesai (termasuk peningkatan resmi dan AUR), bilah tugas otomatis memeriksa pembaruan tersisa tanpa memulai ulang. Pemeriksaan juga dilakukan setelah kegagalan karena beberapa paket mungkin sudah berubah. Pemeriksaan setiap jam tetap aktif dan mendeteksi operasi di luar Control Center.

### Navigasi per monitor

Berikutnya/sebelumnya berputar hanya pada ruang kerja yang ada di monitor terfokus: numerik dahulu, lalu nama dan proyek menurut nama asli. Gulir bilah memakai monitor di bawah penunjuk. Ruang khusus dikecualikan dan menghentikan siklus saat terbuka. Pintasan angka tetap memakai ID global. Penetapan tetap di `/displays/workspaces`.

`argvus config workspace-cycle next|previous [--monitor focused|cursor]`

**Power → ARGVUS Lifecycle** (`argvus-lifecycle`)

Papan klip aktif secara default dan dapat dibuka dari grup utilitas di bilah tugas. Untuk berhenti merekam teks dan gambar, hapus centang pada opsi di Control Center → Appearance → Taskbar → Icons → Optional modules lalu pilih Apply. Ikon akan disembunyikan dan riwayat tidak bisa dibuka hingga opsi diaktifkan kembali. Entri yang tersimpan tetap tersedia.

Pemutaran dari peramban muncul hanya jika pemutar mengidentifikasi Spotify sebagai sumber. Tooltip memakai latar tanpa bingkai.

Jika pemeriksaan gagal, bilah tugas mencoba lagi setelah 30 detik.
