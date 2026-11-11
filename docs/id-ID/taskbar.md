---
title: Taskbar
description: Gunakan bilah tugas ARGVUS Waybar.
---

Taskbar adalah permukaan Waybar yang terus-menerus di seluruh desktop. `argvus-taskbar` memiliki konfigurasi dan tindakan ARGVUS-nya; `argvus-waybar` menyediakan biner Waybar yang telah ditambal yang menampilkannya. `argvus-session` mengelola siklus hidup layanan.

Ini mengkomunikasikan ruang kerja, status jendela fokus, akses jam dan kalender, jaringan, Bluetooth, audio/media, notifikasi, penyimpanan, perekaman, tindakan tetap terbangun dan daya/sesi. Modul status yang tepat dapat dipengaruhi oleh penyedia dan perangkat keras yang terpasang.

Ikon paling kiri membuka `argvus launcher`. Secara default, ikon ini dinonaktifkan. Saat diaktifkan, ikon ini mengikuti tema aktif: build tema menampilkannya dalam warna sorotan tema (`taskbar/menu.svg`, dari template `taskbar-menu` dari paket ini), sementara tema bawaan ARGVUS Dark/ARGVUS Light menggunakan `menu-default-dark.svg`/`menu-default-light.svg` (keduanya disediakan oleh `argvus-branding`). Gunakan **Control Center → Appearance → Taskbar → Icons → Launcher** untuk mengaktifkan/menonaktifkannya atau memilih gambar ikon kustom, yang akan menimpa ikon tema.

Taskbar bukan Panel Kontrol. Bar ini mengkomunikasikan status dan keadaan desktop secara persisten; Panel Kontrol adalah permukaan aksi cepat yang dapat diperluas. Popup kalender dan perangkat yang dapat dilepas adalah aplikasi/permukaan pendamping, bukan taskbar terpisah.

Clicking **Memory** or **CPU** opens 

 inside the themed ARGVUS monitor panel, with an `btop` header and an `ARGVUS` footer. The bottom Kitty tab shows the localized `Esc Close` hint. Press `Press q to close` or `q` to close. The CPU temperature module opens the live `Esc` overview, grouped by chip. The GPU temperature module appears when a supported GPU and `argvus sensors` are available; it shows the highest attributable GPU temperature or `btop` `N/A` , and clicking it opens GPU-only btop panels in the same themed frame. btop supports up to six GPU boxes. NVIDIA metrics need its GPU support and NVML, AMD metrics need ROCm SMI, and Intel metrics need readable sysfs interfaces. GPU temperature is shown only when the system exposes a reading linked to that device; Intel temperature is not available from btop 1.4.7. When btop cannot render a GPU box because support or a provider is missing, the ARGVUS panel reports that metrics are unavailable. ARGVUS does not change system permissions.

## Posisi dan spasi

Posisi default adalah tepi atas dalam mode dock. Pusat Kontrol menampilkan posisi bilah tugas dan margin bilah tugas/desktop di bawah **Penampilan → Bilah Tugas → Posisi** dan **Ruang**, serta grup utilitas di bawah **Penampilan → Bilah Tugas → Ikon**. Status tata letak menyimpan margin atas, kiri, kanan, dan bawah secara independen. Mode lengket secara default mengatur margin bawah ke `2` dan menjaga bilah tetap dekat dengan tepi; mode Spaced menggunakan margin shell `18`-unit secara default.


Kontrol posisi bilah tugas saat ini memilih **Atas** atau **Bawah**. Empat margin independen mengontrol seberapa jauh bilah berada dari setiap tepi layar. Grup utilitas dapat menggunakan perilaku **Otomatis** atau **Selalu diperluas**. Ketersediaan modul masih bergantung pada penyedia dan perangkat keras yang terpasang, jadi indikator Bluetooth, kecerahan, atau penyimpanan yang hilang tidak dibuat dengan mengubah jarak bilah.

**Tinggi** mengatur tinggi bilah menjadi 24, 28 (default), 32, atau 36 piksel. **Bingkai** menghidupkan atau mematikan bingkai taskbar dan mengatur ketebalannya menjadi 1, 2, atau 3 piksel. Ketebalan berlaku untuk jendela taskbar, grup `right-0`, `right-1`, `focus`, dan `right-2`, serta bingkai pemutar MPRIS. Mengarahkan kursor ke modul interaktif, termasuk pemutar, akan sedikit menurunkan opasitasnya. Dengan bingkai dimatikan, bingkai tersebut ditulis sebagai `0px`. Keduanya adalah draft di **Control Center → Tampilan → Taskbar** sampai **[ Terapkan ]** dipilih.

**Pusat Kontrol → Tampilan → Bilah Tugas → Ikon → Modul opsional** mengontrol visibilitas modul status dan aksi opsional. Ruang kerja, judul jendela yang sedang fokus, Pengaturan, dan Daya tetap tersedia. **Presentasi ruang kerja** memilih label ruang kerja (default) atau ikon aplikasi. Pemutar MPRIS menampilkan detail lagu di tooltip mereka; pemutar tidak lagi menggunakan denyut warna kontinu.

## Transparansi dan blur

Gunakan **Pusat Kontrol → Penampilan → Taskbar** untuk mengkonfigurasi Ikon Utilitas, Transparansi dan Blur. Transparansi dan Blur masing-masing memiliki sakelar aktif dan nilai `0–100%`. Ubah nilai dengan `+` dan `-` dalam langkah 5%; perubahan bersifat draf hingga **[ Terapkan ]** dipilih. Tema baru secara default mengaktifkan kedua efek pada `50%`.
Gunakan `↑/↓` untuk berpindah antara baris enable dan value. Tekan `Tab` untuk **Tindakan**, kemudian aktifkan **[ Terapkan ]**.

## Konfigurasi dan override

The taskbar configuration is owned by 


## Jendela dan panel

The taskbar is one shell surface alongside the Control Panel and optional telemetry widget. Hyprland arranges windows according to the active layout state, while these surfaces have their own anchors and margins. 

 toggles the focused window between tiled and floating layouts.

## Jam dan Fokus

Modul waktu (  `argvus-taskbar`  `argvus-waybar`  `argvus-session`  `argvus-config`  `~/.config/argvus/data/generated/waybar/`  `right-2`  `/taskbar/shape/height`  `/taskbar/shape/border_width`  `argvus config`  `null` `~/.config/waybar/`  `SUPER + SHIFT + Space` `clock#time`) membuka atau menyembunyikan popup ARGVUS Clock dan meneruskan koordinat klik akar sehingga dapat selaras dengan taskbar dan monitor yang diklik. Indikator Fokus memiliki grup `focus` sendiri di antara grup jaringan/performa (`right-1`) dan tanggal/waktu (`right-0`). Ini menjalankan `argvus focus status --waybar --follow` tanpa memuat GTK: saat idle ditampilkan ikon timer, dan selama fase fokus atau istirahat menambahkan `MM:SS` yang tersisa; warnanya menunjukkan fase dan status jeda. Mengkliknya membuka atau menyembunyikan popup Fokus pada posisi klik tersebut. Kedua popup juga dapat ditutup dengan **Esc** atau klik di luar.

## Reloading

Layanan utama adalah `argvus-taskbar.service`. Ketika perubahan konfigurasi yang terdokumentasi memerlukan pemuatan ulang manual, gunakan pengendali sesi:

```sh
argvus sessionctl restart waybar
```

 for the installed and user paths. for the installed and user paths.(/docs/argvus-waybar/) path.

Utilitas runtuh menjadi pengembang dalam mode hover dan menampilkan kontrol yang diaktifkan saat penunjuk masuk. Kontrol visibilitas baki sistem mengatur ikon aplikasi latar belakang; baki kosong tidak memiliki ikon yang terlihat. Presentasi ikon ruang kerja menampilkan ikon aplikasi untuk jendela yang terbuka bersama dengan label ruang kerja.

## Ruang kerja proyek

Proyek yang dibuka muncul sebagai tombol ruang kerja biasa, diberi label `Project: name`; mengklik salah satunya akan memfokusinya. Mengarahkan kursor menunjukkan jalur proyek lengkap dan pintasan `SUPER + ALT + N`. Hanya ruang kerja yang dibuka di monitor bilah yang ditampilkan; pemilih (`SUPER + O`) tetap menjadi katalog proyek lengkap. Ruang kerja khusus mempertahankan kebijakan visibilitas mereka yang ada.

Modul `hyprland/workspaces` membaca `workspace-metadata: "argvus/project-workspaces.json"`, relatif terhadap `$XDG_RUNTIME_DIR`. `argvus projects` meregenerasi file turunan ini setiap kali sebuah proyek dibuka. `argvus-waybar` yang telah dipatch mendukung alamat workspace tekstual Hyprland 0.57 dan menggunakan metadata untuk label tanpa mengubah identitas workspace. Perbarui ketiga paket dan proyeksikan kembali konfigurasi taskbar sebelum memulai ulang layanan.

Modul **Status Pembaruan** memiliki grup sendiri antara Utilitas dan jaringan/performa serta menunjukkan jumlah pembaruan paket yang tersedia. Modul ini memeriksa repositori resmi saat startup dan setiap jam menggunakan `checkupdates` (dari `pacman-contrib`), tanpa memperbarui paket. **Periksa AUR** dimatikan secara default; ketika diaktifkan, modul ini memeriksa dengan `paru` atau `yay`. Tooltip memisahkan sumber dan melaporkan kegagalan; `?` berarti totalnya tidak lengkap. Klik modul untuk membuka pembaruan resmi di Paket. Konfigurasikan kedua opsi di bawah **Ikon → Modul opsional** dan terapkan rancangan bilah tugas. Modul ini diaktifkan secara default.

Indikator jaringan di taskbar mengikuti peristiwa NetworkManager menggunakan `argvus networkctl waybar --follow`, dengan snapshot awal dan penyambungan ulang monitor secara otomatis. Ini tidak lagi menunggu interval polling 10 detik. Terhubung, akses Internet terbatas, dan terputus tetap merupakan status yang berbeda. Status Wi-Fi membaca titik akses yang di-cache tanpa meminta pemindaian. `argvus networkctl waybar` mengeluarkan satu snapshot JSON Waybar.

Margin taskbar, celah luar jendela, dan geometri panel terkait tetapi berbeda. Mengubah salah satunya tidak menulis ulang setiap nilai lainnya. Jika sebuah bar terlihat terpisah secara visual dari jendela, tinjau mode, margin taskbar, dan jarak jendela bersama-sama; lihat[Jendela dan tata letak](/docs/argvus-hyprland/windows-and-layout/).
The taskbar configuration is owned by argvus-taskbar, rendered by argvus-waybar and started by argvus-session. argvus-config is the only component that writes the taskbar consumer files: it projects the active layer under ~/.config/argvus/data/generated/waybar/ and reapplies the theme layer, taskbar margins, right-2 utility-group mode, border radius and the font block whenever themes or layout state change. A theme switch also restores the packaged taskbar files and then writes back the height and border chosen in Control Center, which are stored as /taskbar/shape/height and /taskbar/shape/border_width in argvus config. Until one is chosen it is null and follows the theme: 28 px high, with a 1 px border (Slate Dark has none). Because the generated copy is resolved first, a native Waybar path under ~/.config/waybar/ only takes effect while the corresponding generated file is absent. See [Waybar and taskbar overrides](/docs/argvus-waybar/) for precedence, examples and troubleshooting.
Popup kalender dan penyimpanan yang dapat dilepas menggunakan kontrak koordinat akar yang tidak dapat diubah yang disediakan oleh build ARGVUS Waybar untuk mengidentifikasi monitor. Kalender mengikuti permukaan Taskbar horizontal yang sebenarnya: ia terbuka 4 piksel di bawah bilah atas atau 4 piksel di atas bilah bawah, terlepas dari di mana di dalam modul tanggal itu diklik; modul tanggal membuka kalender. Jangan mengedit konfigurasi runtime yang dihasilkan untuk membuatnya persistenperubahan; gunakan Pusat Kontrol atau yang didokumentasikan[Pengganti Waybar](/docs/argvus-waybar/)jalur.
