---
title: Widget'lar
description: İsteğe bağlı sistem telemetri bileşenlerini yapılandırın.
---

`argvus widget-telemetry`, sistem bilgileri için isteğe bağlı bir yardımcı Waybar yüzeyi sağlar. Mevcut blokları **Sistem**, **CPU/GPU**, **Bellek**, **Depolama**, **İşlemler**, **Ağ** ve **Kısayollar**dır. Kısayollar bloğu durum dosyasında `keys` anahtarı ile saklanır.

**Kontrol Merkezi → Görünüm → Widget Telemetri** kullanarak yüzeyi etkinleştirin ve tek tek blokları açıp kapatın. Bir bloğu devre dışı bırakmak, o telemetri modülünü Waybar profilinden gizler; bir paketi kaldırmaz veya oturumun geri kalanını durdurmaz. Ana geçiş, telemetri yüzeyini bir bütün olarak kontrol eder.

Blok seçimi `config.json`, `control_panel.widget_telemetry_blocks`'de kanoniktir ve ana anahtar `control_panel.widget_telemetry_enabled`'dir. `argvus-config`, seçimi Waybar profili `data/waybar/argvus-widget-telemetry.jsonc`'ye, sınırlı `ARGVUS_TELEMETRY_<BLOCK>_BEGIN`/`_END` blokları içindeki satırların yorum satırı yapılması veya yorum satırı kaldırılması yoluyla projekte eder ve dosyanın geri kalanını değiştirmez. Eski bir `~/.local/state/argvus/widget-telemetry-blocks` dosyası, eski kurulumlarda göç yedeği olarak hâlâ okunur, ancak hiç yazılmaz. Tüm profilin görünüm değişikliği sırasında paketlenmiş varsayılan sürümden değiştirildiğini, bu nedenle blok işaretleyicilerinin seçimin korunmasını sağladığını not edin; bunların dışındaki metin bir tema değişikliği sırasında korunmaz.

Denetleyici şunları destekler:

```sh
argvus widget-telemetry-toggle status
argvus widget-telemetry-toggle on
argvus widget-telemetry-toggle off
argvus widget-telemetry-toggle blocks status
argvus widget-telemetry-toggle blocks set memory disabled
argvus widget-telemetry-toggle blocks apply
```

Kontrolcü ayrıca  `blocks set <block> <enabled|disabled>` `system`, `cpu_gpu`, `memory`, `storage`, `processes`, `network` ve `keys` için blocks set <block> <enabled|disabled> kabul eder. Tercihler kalıcıdır; bir bloğun belirli bir tercihi yoksa etkinleştirilmiş varsayılanı takip eder. `blocks set`, kanonik diziyi tek bir atomik yama ile yeniden yazar, ardından Waybar profilini yeniden projeler ve servis yaşam döngüsünü uzlaştırır. `apply-state`, Kontrol Merkezi'nin yoludur: çağıranın seçimi zaten kalıcı hâle getirdiğini varsayar ve yalnızca projeler, bu nedenle hiç bir zaman kalıcı olmayan bir durum ile çağrılmamalıdır.

The service is

 ve `argvus-widget-telemetry.service` `argvus-session` tarafından yönetilmektedir. Geçerli sayfada ayrı bir blok başına sıfırlama düğmesi yoktur: oluşturulan Waybar çıktısını düzenlemek yerine bloğu tekrar etkinleştirin veya sağlayıcının desteklenen durum yönetimini kullanın.

## Şeffaflık ve bulanıklık

**Kontrol Merkezi → Görünüm → Widget Telemetri** kullanarak ana anahtarı, telemetri oturumlarını, Şeffaflık ve Bulanıklığı yapılandırın. Her iki etkinin de bağımsız açma kapama anahtarları ve `0–100%` değerleri vardır. `+` ve `-`'yi %5 adımlarla kullanın ve **[ Uygula ]** seçeneğini işaretleyin; değerler yalnızca onaylandıktan sonra uygulanır ve aktif tema için saklanır.
Etkinleştirme ve değer satırları arasında geçiş yapmak için `↑/↓` kullanın. **Eylemler** için `Tab` tuşuna basın, ardından **[ Uygula ]** öğesini etkinleştirin.

GPU sıcaklık modülü, DRM/sysfs desteklenen bir NVIDIA, AMD veya Intel GPU'yu açığa çıkardığında ve `btop` yüklü olduğunda gösterilir. Değeri, tespit edilen GPU'lardan birine atfedilebilecek en yüksek geçerli sıcaklıktır; sensör açığa çıkmadığında, `N/A` gösterir. Üzerine tıklamak, taskbar-monitor profili kullanılarak `argvus tui-terminal` üzerinden Kitty'de sadece GPU btop panellerini açar. Kapatmak için  `taskbar-monitor` `q` veya `Esc` tuşlayın; yerelleştirilmiş alt sekme `Press q to close` der. btop 1.4.7, altı GPU kutusuna kadar destekler. NVIDIA metrikleri btop GPU desteği ve NVML gerektirir; AMD btop GPU desteği ve ROCm SMI gerektirir; Intel okunabilir sysfs arayüzlerini gerektirir. NVIDIA nouveau, AMD ve Intel sıcaklıkları yalnızca bağlı bir hwmon sensörü açığa çıkarsa görünür. ARGVUS izinleri değiştirmez veya ayrıcalıklı yardımcı programlar eklemez. Görev çubuğu paketi btop'a bağımlıdır; üretici sağlayıcıları isteğe bağlıdır.


Grup/sağ-2’deki isteğe bağlı AI ajanlar simgesi argvus-ai menüsünü açar. Her beş saniyede bir kontrol edilir ve yardımcı mevcut olmadığında veya herhangi bir ajan bulunmadığında gizlenir (argvus-ai status --check). Claude, mise bulunduğunda kurulabilir olarak sunulur. Bunu seçmek ARGVUS terminalini açar, mevcut kullanıcı profiline eksikse kurar ve ardından ikili dizinini işlem PATH’ine ekleyerek başlatır. Herhangi bir paket kurulum kancası kullanılmaz. Güncellenmiş sistem yapılandırmasını yüklemek için çubuğu yeniden yükleyin; kullanıcı kopyaları üzerine yazılmaz.


AI başlatıcı, Symbols Nerd Font Mono ile nf-md-robot (U+F06A9) kullanır. Görünüm projektörü bunu mikrofon ve ses kontrollerinin yanında grup/sağ-2'de korur.

## Pencere modu seçici

`group/right-2`'deki pencere simgesi, yardımcı genişletici çalıştırıldıktan sonra, **Pencereyi Döşeme (Varsayılan)** ve **Yüzen Pencereler** ile bir GTK açılır penceresi açar. Mevcut tercih işaretlenmiştir. Bir seçeneği hemen uygulamak için seçin; Escape tuşuna basmak veya dışarıya tıklamak açılır pencereyi kapatır. Simge, uygulama tamamlanmadığında bekleyen/hata stilinde olmak üzere geçerli modu yansıtır. Açılır pencere, görev çubuğu konumunu ve mevcut temayı takip eder.

Ayar, **Kontrol Merkezi → Masaüstü ve Girdi → Hyprland → Pencereler → Mod** ile paylaşılır. Yüzen durum, monitörler ve çalışma alanlarındaki tüm uygulama pencerelerini etkiler. Tile durumuna geri dönmek, başlangıçta yüzen olan pencereleri korur. Seçim, girişler arasında devam eder.

Yardımcı `argvus window-mode-menu`; `argvus window-mode-menu --status` Waybar JSON yayar. Master `argvus` paketi ile birlikte gönderilir. Mevcut özelleştirilmiş görev çubuğu kopyaları korunur: katılmak için paketlenmiş şablondan `custom/window-mode` modül tanımını ve grup girişini ekleyin veya Kontrol Merkezi'ni kullanın. Görünüm projektörü, tanımı mevcut olduğunda modülü korur, diğer yardımcı simgeler devre dışı olsa bile.

## Pencere düğmeleri ve uygulama çubuğu

Yüzen mod, normal uygulama pencerelerine **Simge Durumuna Küçült**, **Büyüt / Geri Yükle** ve **Kapat** içeren bir ARGVUS başlık çubuğu ekler. Başlık çubuğuna çift tıklamak, pencereyi büyütme durumunu değiştirir. Ek dekorasyon, Döşeme ve tam ekran modunda gizlenir. Kendi kontrollerini çizen uygulamalar her iki çubuğu da gösterebilir; standart ARGVUS kontrolleri kasıtlıdır.

Her monitörde, ana görev çubuğunun karşı tarafındaki kenarda ikinci bir Waybar görünür. Sadece o monitörün mevcut çalışma alanındaki pencereleri listeler, küçültülmüş pencereler dahil. Gizli grup sekmeleri ekstra giriş oluşturmaz. Küçültülmüş girişler, orijinal monitör/çalışma alanı ilişkisini korur. Etkin olmayan bir pencereye tıklayarak etkinleştirebilir, etkin bir pencereye tıklayarak küçültebilir veya küçültülmüş bir pencereye tıklayarak geri getirebilirsiniz; bağlam menüsü geri yükle, küçült, büyüt/gönder ve kapat seçeneklerini sunar. Bilinmeyen uygulama simgeleri pencere simgesi ile varsayılan olarak gösterilir. Bir girişi etkinleştirmek veya geri yüklemek, imleç pozisyonunu korur. İkincil çubuk, etkili birincil CSS'i (renkler, yazı tipleri, kenarlık ve yuvarlama) kullanır; yüksekliği ve ters kenardaki yansıtılmış kenar boşlukları ile birlikte.

`SUPER + Alt + Up` ana çubuğu üstte, pencere çubuğunu altta yerleştirir. `SUPER + Alt + Down` ise tersini yapar. Bir yönü tekrar etmek, konumları değiştirmez. Tile’da sadece ana çubuk vardır. Tile’a geri dönmek, pencere çubuğu kaldırılmadan önce tüm simge durumuna küçültülmüş pencereleri geri getirir ve ardından orijinal döşeme/serbest politika korunur.

Minimize etme, rezerve edilmiş `special:argvus-minimized` çalışma alanını kullanır. Bu çalışma alanını manuel olarak kullanmayın. `argvus windows service` işlemi, kimliği, orijinal çalışma alanını/monitörü, geometrisini, tam ekran/masimleştirme ve sabitleme durumunu `$XDG_RUNTIME_DIR/argvus` altında her kompozitör örneğine özgü bir çalışma zamanı kaydında kaydeder. Kayıtlar bir servis yeniden başlatması veya yapılandırma yeniden yüklemesini geçirir, ancak kompozitör oturumlarını geçmez. Bir pencere kapatıldığında kaydı silinir. Bir monitör kaybolursa, geri yükleme mevcut bir çıktı kullanır. Eksik veya başarısız bir geri kazanım çubuğu, yeni minimize işlemlerini engeller; başarısız geri yükleme kaydı ve geri kazanım çubuğunu korur.

Oturum `argvus-windows.service` ve `argvus-window-bar.service` adlı öğelere sahiptir. İkincisi Waybar alt öğesini Tile içinde pasif tutar. hyprbars eklentisi `argvus-hyprland` tarafından paketlenmiştir, Hyprland 0.57.0 ABI için x86_64 üzerinde oluşturulmuştur; kullanıcı ev dizininde derlenmemiştir. Eklentiyi bir compositor ABI güncellemesi ile yeniden derleyin.

Commands: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all` ve `minimize|restore|activate|maximize|close ADDRESS`. Pencere adresleri listeden gelir. `position top --persist` tercihi ana çubuğu yeniden başlatmadan kaydeder/projeler. Yapılandırma ve çalışma zamanı hata detayları günlük dosyasına yazılır; görülebilen işlem hataları ayrıca çevrilmiş bir bildirim gösterir.

**Spaced + Floating** modunda, pencereler dış boşluklara ve her iki çubuğun ayırdığı alanlara saygı gösterir. Sınırlar, aynı pencere sınırının içinde yer alan kenarlık ve başlığı içerir. ARGVUS kontrolleri ile tam ekran yapıldığında bu alan kenar boşluklarıyla doldurulur; geri yükleme, hizmet yeniden başlatıldıktan sonra bile önceki geometrinin geri getirilmesini sağlar. Tam ekran hâlâ tüm çıktıyı kullanır. Pencereler serbest şekilde hareket edebilir; döşeme iç boşlukları onları ayırmaz.
