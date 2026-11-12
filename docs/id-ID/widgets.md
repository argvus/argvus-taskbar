---
title: Widget
description: Konfigurasikan widget telemetri sistem opsional.
---

argvus widget-telemetry menyediakan permukaan Waybar tambahan opsional untuk informasi sistem. Blok saat ini adalah **Sistem**, **CPU/GPU**, **Memori**, **Penyimpanan**, **Proses**, **Jaringan**, dan **Pintasan**. Blok Pintasan disimpan dengan kunci keys dalam file status.

Gunakan **Control Center → Appearance → Widget Telemetry** untuk mengaktifkan tampilan dan menyalakan atau mematikan blok individu. Menonaktifkan sebuah blok menyembunyikan modul telemetri tersebut dari profil Waybar; ini tidak mencopot pemasangan paket atau menghentikan sisa sesi. Saklar utama mengontrol tampilan telemetri secara keseluruhan.

Block selection is canonical in

, di `argvus widget-telemetry`, dan saklar utama adalah `keys`. `config.json` memproyeksikan pilihan tersebut ke dalam profil Waybar `control_panel.widget_telemetry_blocks` dengan menghapus komentar atau mengomentari baris di dalam blok `control_panel.widget_telemetry_enabled`/`argvus-config` yang dibatasi, membiarkan sisa file tidak tersentuh. File lama `data/waybar/argvus-widget-telemetry.jsonc` masih dibaca sebagai cadangan migrasi pada instalasi lama, namun tidak pernah ditulis. Perhatikan bahwa seluruh profil diganti dari paket default dengan perubahan tampilan, jadi penanda blok adalah cara pemilihan bertahan; teks di luarnya tidak disimpan di saklar tema.

Pengontrol mendukung:

```sh
argvus widget-telemetry-toggle status
argvus widget-telemetry-toggle on
argvus widget-telemetry-toggle off
argvus widget-telemetry-toggle blocks status
argvus widget-telemetry-toggle blocks set memory disabled
argvus widget-telemetry-toggle blocks apply
```

Pengontrol juga menerima  ~/.local/state/argvus/widget-telemetry-blocks  _END  `ARGVUS_TELEMETRY_<BLOCK>_BEGIN`  `_END`  `~/.local/state/argvus/widget-telemetry-blocks` `blocks set <block> <enabled|disabled>` untuk `system`, `cpu_gpu`, `memory`, `storage`, `processes`, `network`, dan `keys`. Preferensi bersifat persisten; ketika sebuah blok tidak memiliki preferensi eksplisit, ia mengikuti default yang diaktifkan. `blocks set` menulis ulang array kanonik dalam satu patch atomik, kemudian memproyeksikan kembali profil Waybar dan menyesuaikan siklus hidup layanan. `apply-state` adalah jalur Control Center: ia mengasumsikan pemanggil sudah menyimpan pilihan dan hanya memproyeksikannya, jadi jangan pernah memanggilnya dengan status yang belum disimpan.

Layanannya adalah `argvus-widget-telemetry.service` dan dikelola oleh `argvus-session`. Tidak ada tombol reset per-blok terpisah di halaman saat ini: aktifkan blok lagi, atau gunakan manajemen status yang didukung penyedia, bukannya mengedit output Waybar yang dihasilkan.

## Transparansi dan blur

Gunakan **Control Center → Appearance → Widget Telemetry** untuk mengonfigurasi saklar utama, sesi telemetri, Transparansi, dan Blur. Kedua efek memiliki saklar aktif yang independen dan nilai `0–100%`. Gunakan `+` dan `-` dalam langkah 5% dan pilih **[ Apply ]**; nilai hanya diterapkan setelah konfirmasi dan disimpan untuk tema yang aktif.
Gunakan `↑/↓` untuk berpindah antara baris enable dan value. Tekan `Tab` untuk **Tindakan**, kemudian aktifkan **[ Terapkan ]**.

Modul suhu GPU ditampilkan ketika DRM/sysfs mengekspos GPU NVIDIA, AMD, atau Intel yang didukung dan `btop` terpasang. Nilainya adalah suhu valid tertinggi yang dapat dikaitkan dengan salah satu GPU yang terdeteksi; ketika tidak ada sensor yang diekspos, itu menunjukkan `N/A`. Mengkliknya membuka panel btop khusus GPU di Kitty melalui `argvus tui-terminal` menggunakan profil `taskbar-monitor`. Tekan `q` atau `Esc` untuk menutup; tab bawah yang dilokalkan menampilkan `Press q to close`. btop 1.4.7 mendukung hingga enam kotak GPU. Metrik NVIDIA memerlukan dukungan GPU btop dan NVML; AMD memerlukan dukungan GPU btop dan ROCm SMI; Intel memerlukan antarmuka sysfs yang dapat dibaca. Suhu NVIDIA nouveau, AMD, dan Intel muncul hanya ketika sensor hwmon yang terhubung diekspos. ARGVUS tidak mengubah izin atau menambahkan pembantu dengan hak istimewa. Paket taskbar bergantung pada btop; penyedia produsen tetap opsional.


Ikon agen AI opsional di grup/kanan-2 membuka menu argvus-ai. Ikon ini diperiksa setiap lima detik dan disembunyikan ketika pembantu tidak ada atau tidak ada agen yang tersedia (argvus-ai status --check). Claude ditawarkan sebagai yang dapat diinstal ketika mise hadir. Memilihnya membuka terminal ARGVUS, menginstalnya di profil pengguna saat ini jika belum ada, lalu meluncurkannya dengan direktori biner di PATH proses. Tidak ada hook instalasi paket yang digunakan. Muat ulang bar untuk memuat konfigurasi sistem yang diperbarui; salinan pengguna tidak ditimpa.


Peluncur AI menggunakan nf-md-robot (U+F06A9) dengan Symbols Nerd Font Mono. Proyektor tampilan mempertahankannya di group/right-2 bersama dengan mikrofon dan kontrol audio.

## Pemilih mode jendela

Ikon jendela di `group/right-2`, setelah utilitas expander, membuka popup GTK dengan **Tile Windows (Default)** dan **Floating Windows**. Preferensi saat ini ditandai. Pilih opsi untuk menerapkannya segera; menekan Escape atau mengklik di luar akan menutup popup. Ikon mencerminkan mode yang berlaku, dengan gaya tertunda/eror ketika aplikasi belum selesai. Popup mengikuti posisi taskbar dan tema saat ini.

Pengaturan dibagikan dengan **Control Center → Desktop & Input → Hyprland → Windows → Mode**. Floating memengaruhi semua jendela aplikasi di semua monitor dan ruang kerja. Kembali ke Tile mempertahankan jendela yang awalnya dalam mode floating. Pilihan ini bertahan antara login.

Bantuan adalah `argvus window-mode-menu`; `argvus window-mode-menu --status` mengeluarkan JSON Waybar. Ini dikirimkan oleh paket master `argvus`. Salinan taskbar yang telah dikustomisasi sebelumnya dipertahankan: tambahkan definisi modul `custom/window-mode` dan entri grup dari template paket untuk berpartisipasi, atau gunakan Control Center. Proyektor tampilan mempertahankan modul ketika definisinya ada, bahkan jika ikon utilitas lain dinonaktifkan.

## Tombol jendela dan bilah aplikasi

Mode mengambang menambahkan bilah judul ARGVUS dengan **Perkecil**, **Perbesar / Pulihkan**, dan **Tutup** pada jendela aplikasi normal. Klik ganda pada bilah judul akan mengubah status perbesaran. Dekorasi tambahan ini disembunyikan pada mode Tile dan layar penuh. Aplikasi yang menampilkan kontrolnya sendiri mungkin menampilkan kedua bilah; kontrol ARGVUS yang seragam adalah sengaja.

Sebuah Waybar kedua muncul di setiap monitor, di sisi yang berlawanan dengan taskbar utama. Bar ini hanya menampilkan jendela dari workspace saat ini pada monitor tersebut, termasuk jendela yang diminimalkan. Tab grup yang disembunyikan tidak membuat entri tambahan. Entri yang diminimalkan tetap mempertahankan asosiasi monitor/workspace aslinya. Klik jendela yang tidak aktif untuk mengaktifkannya, jendela yang aktif untuk meminimalkannya, atau jendela yang diminimalkan untuk mengembalikannya; menu konteksnya menawarkan opsi kembalikan, minimalkan, maksimalkan/kembalikan dan tutup. Ikon aplikasi yang tidak dikenal digantikan dengan simbol jendela. Mengaktifkan atau mengembalikan sebuah entri mempertahankan posisi penunjuk. Bar sekunder menggunakan CSS utama yang efektif (warna, font, border, dan pembulatan), dengan tinggi dan margin yang tercermin di sisi yang berlawanan.

`SUPER + Alt + Up` menempatkan bilah utama di atas dan bilah jendela di bawah. `SUPER + Alt + Down` melakukan sebaliknya. Mengulangi suatu arah tidak mengubah posisi. Tile hanya memiliki bilah utama. Kembali ke Tile memulihkan semua jendela yang diminimalkan sebelum menghapus bilah jendela, dan kemudian mempertahankan kebijakan tile/floating asli.

Minimisasi menggunakan workspace cadangan `special:argvus-minimized`. Jangan gunakan workspace itu secara manual. Proses `argvus windows service` mencatat identitas, workspace/monitor asli, geometri, layar penuh/maksimalisasi, dan status pin dalam registry runtime spesifik-instansi compositor di bawah `$XDG_RUNTIME_DIR/argvus`. Catatan tetap ada saat layanan dimulai ulang atau konfigurasi dimuat ulang, tetapi tidak melintasi sesi compositor. Menutup jendela menghapus catatannya. Jika sebuah monitor hilang, pemulihan menggunakan output yang tersedia. Bar pemulihan yang hilang atau gagal mencegah minimisasi baru; pemulihan yang gagal mempertahankan catatan dan bar pemulihan.

Sesi memiliki `argvus-windows.service` dan `argvus-window-bar.service`. Yang terakhir menjaga child Waybar-nya tetap dorman di Tile. Plugin hyprbars dibundel oleh `argvus-hyprland`, dibuat untuk Hyprland 0.57.0 ABI di x86_64; itu tidak dikompilasi di direktori home pengguna. Bangun ulang plugin dengan pembaruan ABI compositor.

Commands: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all`, dan `minimize|restore|activate|maximize|close ADDRESS`. Alamat jendela berasal dari daftar. `position top --persist` menyimpan/memproyeksikan preferensi tanpa memulai ulang bilah utama. Detail konfigurasi dan kesalahan runtime dicatat di jurnal; kegagalan tindakan yang terlihat juga menampilkan notifikasi yang diterjemahkan.

Dalam **Spaced + Floating**, jendela menghormati celah luar dan area yang dicadangkan oleh kedua bilah. Batas mencakup border dan judul, yang berada di dalam border jendela yang sama. Memaksimalkan melalui kontrol ARGVUS mengisi area ini dengan margin; memulihkan mengembalikan geometri sebelumnya, termasuk setelah restart layanan. Layar penuh tetap menggunakan seluruh output. Jendela mengambang bisa saling tumpang tindih; celah dalam pada tiling tidak memisahkan mereka.
