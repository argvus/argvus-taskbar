---
title: Görev Çubuğu
description: ARGVUS Quickshell görev çubuğunu kullanın.
---

Görev çubuğu ve telemetri bileşeni, `argvus-bars.service` tarafından yönetilen Quickshell sürecindeki bağımsız yüzeylerdir. Her yüzeyi `argvus-taskbar.service` ve `argvus-widget-telemetry.service` ile denetleyin.

Çalışma alanlarını, odaklanmış pencere durumunu, saat ve takvim erişimini, ağ, Bluetooth, ses/medya, bildirimler, depolama, kayıt, uyanık kalma ve güç/oturum işlemlerini iletir. Kesin durum modülleri, kurulu sağlayıcılar ve donanımdan etkilenebilir.

En soldaki simge `argvus launcher`'yi açar. Varsayılan olarak devre dışıdır. Etkinleştirildiğinde aktif temayı takip eder: tema derlemesi bunu temanın vurgulama renginde (`taskbar/menu.svg`, bu paketin `taskbar-menu` şablonundan) render ederken, dahili ARGVUS Dark/ARGVUS Light temaları `menu-default-dark.svg`/`menu-default-light.svg` kullanır (her ikisi de `argvus-branding` tarafından sağlanır). Etkinleştirmek/devre dışı bırakmak veya tema simgesinin yerine geçecek özel bir simge görüntüsü seçmek için **Kontrol Merkezi → Görünüm → Görev Çubuğu → Simgeler → Başlatıcı**yı kullanın.

Görev çubuğu, Denetim Masası değildir. Çubuk, kalıcı masaüstü durumu ve durumunu iletir; Denetim Masası, genişletilebilir bir hızlı işlem yüzeyidir. Takvim ve çıkarılabilir aygıt açılır pencereleri, ayrı görev çubukları değil, yardımcı uygulamalar/yüzeylerdir.

Clicking **Memory** or **CPU** opens

 temalı ARGVUS monitör panelinin içinde, bir `btop` üstbilgisi ve bir `ARGVUS` altbilgisi bulunur. Alttaki Kitty sekmesi yerelleştirilmiş `Esc Close` ipucunu gösterir. Kapatmak için `Press q to close` veya `q` tuşuna basın. CPU sıcaklık modülü, çipe göre gruplandırılmış canlı `Esc` genel bakışını açar. GPU sıcaklık modülü, desteklenen bir GPU ve `argvus sensors` mevcut olduğunda görünür; atfedilebilen en yüksek GPU sıcaklığını veya `btop` `N/A`'yi gösterir ve tıklandığında aynı temalı çerçevede yalnızca GPU'ya ait btop paneller açılır. btop altı adede kadar GPU kutusunu destekler. NVIDIA metrikleri GPU desteğine ve NVML, AMD metrikleri ROCm SMI'ya ve Intel metrikleri okunabilir sysfs arayüzlerine ihtiyaç duyar. GPU sıcaklığı yalnızca sistem söz konusu cihaza bağlı bir okumayı ortaya çıkardığında gösterilir; Intel sıcaklık btop 1.4.7'de mevcut değil. Destek veya sağlayıcının eksik olması nedeniyle btop bir GPU kutusunu oluşturamadığında, ARGVUS paneli ölçümlerin kullanılamadığını bildirir. ARGVUS sistem izinlerini değiştirmez.

## Pozisyon ve boşluk

Varsayılan konum, yerleştirme modunda üst kenardır. Kontrol Merkezi, görev çubuğu konumunu ve görev çubuğu/shell kenar boşluklarını **Görünüm → Görev Çubuğu → Konum** ve **Alanlar** altında, yardımcı grup ise **Görünüm → Görev Çubuğu → Simgeler** altında sunar. Düzen durumu, bağımsız üst, sol, sağ ve alt kenar boşluklarını depolar. Yapışkan mod, alt kenarlığı `2` olarak varsayılan ayarlar ve çubuğu kenara yakın tutar; Aralıklı mod, varsayılan olarak `18` birim kullanıcı arayüz kenarlığı kullanır.


Görev çubuğu konumu kontrolü şu anda **Üst** veya **Alt** olarak seçiliyor. Dört bağımsız kenar boşluğu, çubuğun her ekran kenarından ne kadar uzakta duracağını kontrol eder. Yardımcı grup, **Otomatik** veya **Her zaman genişletilmiş** davranışını kullanabilir. Modül kullanılabilirliği hâlâ yüklü sağlayıcıya ve donanıma bağlıdır, bu nedenle eksik bir Bluetooth, parlaklık veya depolama göstergesi, çubuk boşluğunu değiştirerek oluşturulmaz.

**Height** çubuğun yüksekliğini 24 (varsayılan), 28, 32 veya 36 piksel olarak ayarlar. **Border** görev çubuğu kenarlığını açar veya kapatır ve kalınlığını 1, 2 veya 3 piksel olarak ayarlar. Kalınlık, görev çubuğu penceresi, `right-0`, `right-1`, `focus` ve `right-2` grupları ile MPRIS oynatıcı kenarlığı için geçerlidir. Etkin çalışma alanı, dikdörtgen bir arka plan üzerinde ters renklerle gösterilir. Araç ipuçları etkin temanın renklerini ve yazı tipini kullanır. Kenarlık kapalıyken, bu kenarlıklar `0px` olarak yazılır. Her ikisi de **Control Center → Appearance → Taskbar** altında taslak durumundadır, **[ Apply ]** seçilene kadar.

**Kontrol Merkezi → Görünüm → Görev Çubuğu → Simge → İsteğe Bağlı modüller** isteğe bağlı durum ve eylem modüllerinin görünürlüğünü kontrol eder. Çalışma alanları, odaklanılan pencere başlığı, Ayarlar ve Güç kullanılabilir durumda kalır. **Çalışma alanı sunumu** çalışma alanı etiketlerini (varsayılan) veya uygulama simgelerini seçer. MPRIS oynatıcıları araç ipuçlarında parça ayrıntılarını gösterir; oynatıcı artık sürekli renk pulsu kullanmaz.

## Şeffaflık ve bulanıklık

Yardımcı Simgeleri, Şeffaflık ve Bulanıklığı yapılandırmak için **Kontrol Merkezi → Görünüm → Görev Çubuğu** kullanın. Şeffaflık ve Bulanıklığın her birinin bir etkinleştirme anahtarı ve bir `0–100%` değeri vardır. Değerleri `+` ve `-` ile %5 adımlarla değiştirin; değişiklikler **[ Uygula ]** seçeneği seçilene kadar taslaktır. Yeni temalar, her iki efektin de varsayılan olarak `50%` değerinde etkin olduğu şekilde gelir.
Etkinleştirme ve değer satırları arasında geçiş yapmak için `↑/↓` kullanın. **Eylemler** için `Tab` tuşuna basın, ardından **[ Uygula ]** öğesini etkinleştirin.

## Yapılandırma ve geçersiz kılmalar

The taskbar configuration is owned by


## Pencereler ve paneller

`argvus config`: `/layout/taskbar`, `/taskbar`, `/fonts/targets/taskbar`.

`$XDG_RUNTIME_DIR/argvus/bars/presentation.json` ← `argvus sessionctl bars-presentation`.

## Saat ve Odak

Zaman modülü (`clock#time`), ARGVUS Saat açılır penceresini açar veya gizler ve tıklanan görev çubuğu ve monitörle hizalanabilmesi için kök tıklama koordinatlarını iletir. Odak göstergesinin, ağ/performans grubu ( `focus` `right-1`) ile tarih/saat (`right-0`) arasında kendi focus grubu vardır. GTK yüklemeden `argvus focus status --waybar --follow` çalıştırır: boşta iken zamanlayıcı simgesini gösterir, odak veya mola aşamasında kalan `MM:SS`’yi ekler; rengi aşamayı ve duraklatılmış durumu belirtir. Üzerine tıklamak, Odak açılır penceresini o tıklama konumunda açar veya gizler. Her iki açılır pencere de **Esc** tuşuna veya dışarıya tıklamayla kapanır.

## Yeniden yükleniyor

Ana hizmet `argvus-taskbar.service`'dir. Belgelenmiş bir yapılandırma değişikliği manuel bir yeniden yüklemeyi gerektirdiğinde, oturum denetleyicisini kullanın:

```sh
argvus sessionctl restart taskbar
```

 yüklü ve kullanıcı yolları için. yüklü ve kullanıcı yolları için.(/docs/argvus-waybar/) yolu.

Yardımcı programlar, fareyle üzerine gelindiğinde bir genişleticiye çöker ve işaretçi girişiyle etkin kontrolleri ortaya çıkarır. Sistem tepsisi görünürlüğü, arka plandaki uygulama simgelerini kontrol eder; boş bir tepside görünür simge yoktur. Çalışma alanı simgesi sunumu, açık pencereler için uygulama simgelerini çalışma alanı etiketleriyle birlikte gösterir.

## Proje çalışma alanları

Açık projeler sıradan çalışma alanı düğmeleri olarak görünür, `Project: name` ile etiketlenmiştir; birine tıklamak onu odaklar. Üzerine gelmek, tam proje yolunu ve `SUPER + ALT + N` kısayolunu gösterir. Yalnızca çubuğun monitöründeki açık çalışma alanları görüntülenir; seçici (`SUPER + O`) tam proje kataloğu olarak kalır. Özel çalışma alanları mevcut görünürlük politikasını korur.

`$XDG_RUNTIME_DIR/argvus/project-workspaces.json` · `argvus projects`

**Güncelleme Durumu** modülünün, Araçlar ile ağ/performance arasındaki kendi grubu vardır ve mevcut paket güncellemelerinin sayısını gösterir. Başlangıçta ve saatte bir `checkupdates` (`pacman-contrib`'den) kullanarak resmi depoları kontrol eder, paketleri yükseltmez. **AUR'yi Kontrol Et** varsayılan olarak kapalıdır; etkinleştirildiğinde, `paru` veya `yay` ile kontrol eder. İpucu, kaynakları ayırır ve hataları rapor eder; `?` toplamın eksik olduğunu gösterir. Pakets'te resmi güncellemeleri açmak için modüle tıklayın. Her iki seçeneği de **Simgeler → Opsiyonel modüller** altında yapılandırın ve görev çubuğu taslağını uygulayın. Modül varsayılan olarak etkindir.

Görev çubuğu ağ göstergesi, `argvus networkctl waybar --follow` kullanarak NetworkManager olaylarını takip eder, başlangıçta bir anlık görüntü alır ve otomatik izleme yeniden bağlantısı yapar. Artık 10 saniyelik tarama aralığını beklemez. Bağlandı, sınırlı internet erişimi ve bağlantı kesildi durumları ayrı durumlar olarak kalır. Wi-Fi durumu, tarama talep etmeden önbelleğe alınmış erişim noktalarını okur. `argvus networkctl waybar` tek bir Waybar JSON anlık görüntüsü yayar.

`argvus config`: `/layout/taskbar`, `/taskbar`, `/fonts/targets/taskbar`.

`$XDG_RUNTIME_DIR/argvus/bars/presentation.json` ← `argvus sessionctl bars-presentation`.

Control Center paket işlemleri (resmî ve AUR yükseltmeleri dahil) bittiğinde görev çubuğu yeniden başlamadan kalan güncellemeleri otomatik denetler. Bazı paketler değişmiş olabileceğinden hatalardan sonra da denetler. Saatlik denetim etkin kalır ve Control Center dışındaki işlemleri algılar.

### Monitöre göre gezinme

Sonraki/önceki yalnızca odaklanılan monitördeki mevcut çalışma alanlarını döngüyle gezer: önce sayısal alanlar, ardından özgün ada göre adlandırılmış alanlar ve projeler. Görev çubuğunu kaydırmak işaretçinin altındaki monitörü kullanır. Özel alanlar dışlanır ve açıkken gezinmeyi durdurur. Sayısal kısayollar genel kimlikleri korur. Atamalar `/displays/workspaces` içinde kalır.

`argvus config workspace-cycle next|previous [--monitor focused|cursor]`

**Power → ARGVUS Lifecycle** (`argvus-lifecycle`)

Pano varsayılan olarak etkindir ve görev çubuğunun yardımcı araçlar grubundan açılır. Metin ve görüntü kaydını durdurmak için Control Center → Appearance → Taskbar → Icons → Optional modules bölümündeki seçeneğin işaretini kaldırıp Apply seçin. Simge gizlenir ve seçenek yeniden açılana kadar geçmişe erişilemez. Kayıtlı öğeler korunur.

Tarayıcıda oynatılan medya yalnızca oynatıcı kaynak olarak Spotify’ı bildirdiğinde görünür. Araç ipuçlarının kenarlığı yoktur.

Denetim başarısız olursa görev çubuğu 30 saniye sonra yeniden dener.
