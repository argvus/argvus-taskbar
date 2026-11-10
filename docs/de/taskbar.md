---
title: Taskleiste
description: Verwenden Sie die ARGVUS Waybar-Taskleiste.
---
Die Taskleiste ist die persistenten Waybar-Oberfläche über den gesamten Desktop. `argvus-taskbar` besitzt seine ARGVUS-Konfiguration und Aktionen; `argvus-waybar` stellt die gepatchte Waybar-Binärdatei bereit, die sie rendert. `argvus-session` verwaltet den Service-Lifecycle.

Sie kommuniziert Arbeitsbereiche, Fokus-Fenster-Status, Uhr- und Kalenderzugriff, Netzwerk, Bluetooth, Audio/Medien, Benachrichtigungen, Speicher, Aufnahme, Aktiv-bleiben- und Strom-/Sitzungsaktionen. Die genauen Statusmodule können durch installierte Anbieter und Hardware beeinflusst werden.

Das linke Symbol öffnet `argvus launcher`. Es ist standardmäßig deaktiviert. Wenn es aktiviert ist, folgt es dem aktiven Thema: Der Theme-Build rendert es in der Highlight-Farbe des Themas (`taskbar/menu.svg`, aus der `taskbar-menu`-Vorlage dieses Pakets), während die integrierten ARGVUS Dark/ARGVUS Light-Themen `menu-default-dark.svg`/`menu-default-light.svg` verwenden (beide bereitgestellt von `argvus-branding`). Verwenden Sie **Systemsteuerung → Erscheinungsbild → Taskleiste → Symbole → Launcher**, um es zu aktivieren/deaktivieren oder ein benutzerdefiniertes Symbolbild auszuwählen, das das Themensymbol überschreibt.

Die Taskleiste ist nicht die Systemsteuerung. Die Leiste kommuniziert den persistenten Desktop-Zustand und -Status; die Systemsteuerung ist eine erweiterbare Oberfläche für Schnellaktionen. Kalender- und Wechseldatenträger-Popups sind Begleit-Anwendungen/-Oberflächen, keine separaten Taskleisten.

Wenn man auf **Speicher** oder **CPU** klickt, öffnet sich `btop` im thematischen ARGVUS-Monitor-Panel, mit einem `ARGVUS`-Kopfzeilenbereich und einem `Esc Close`-Fußbereich. Der untere Kitty-Tab zeigt den lokalisierten `Press q to close`-Hinweis. Drücken Sie `q` oder `Esc`, um zu schließen. Das CPU-Temperaturmodul öffnet die Live-`argvus sensors`-Übersicht, gruppiert nach Chip. Das GPU-Temperaturmodul erscheint, wenn eine unterstützte GPU und `btop` verfügbar sind; es zeigt die höchste zuordenbare GPU-Temperatur oder `N/A` an, und ein Klick darauf öffnet GPU-only-Btop-Panels im selben thematischen Rahmen. Btop unterstützt bis zu sechs GPU-Felder. NVIDIA-Metriken benötigen deren GPU-Unterstützung und NVML, AMD-Metriken benötigen ROCm SMI, und Intel-Metriken benötigen lesbare sysfs-Schnittstellen. Die GPU-Temperatur wird nur angezeigt, wenn das System eine ablesbare Messung zu diesem Gerät bereitstellt; die Intel-Temperatur ist von btop 1.4.7 nicht verfügbar. Wenn btop ein GPU-Feld nicht darstellen kann, weil Unterstützung oder ein Anbieter fehlt, meldet das ARGVUS-Panel, dass Metriken nicht verfügbar sind. nicht verfügbar. ARGVUS ändert keine Systemberechtigungen.

## Position und Abstand

Die Standardposition ist die obere Kante im Dock-Modus. Das Kontrollzentrum zeigt die Taskleistenposition und Taskleisten-/Shell-Ränder unter **Erscheinungsbild → Taskleiste → Position** und **Abstände** sowie die Dienstprogrammgruppe unter **Erscheinungsbild → Taskleiste → Symbole** an. Der Layoutzustand speichert unabhängige obere, linke, rechte und untere Ränder. Im Sticky-Modus wird der untere Rand standardmäßig auf `2` gesetzt und die Leiste nahe an der Kante gehalten; der Spaced-Modus verwendet einen Standard-Shell-Rand von `18`-Einheiten.

Taskleistenrand, äußerer Fensterabstand und Panelgeometrie sind verwandt, aber unterschiedlich. Eine Änderung eines Wertes ändert nicht automatisch alle anderen Werte. Wenn eine Leiste visuell von Fenstern getrennt erscheint, überprüfen Sie den Modus, die Taskleistenränder und den Fensterabstand zusammen; siehe [Windows und Layout](/docs/argvus-hyprland/windows-and-layout/).

Die Steuerung der Taskleistenposition wählt derzeit **Oben** oder **Unten**. Die vier unabhängigen Ränder steuern, wie weit die Leiste von jedem Bildschimrand entfernt sitzt. Die Dienstprogrammgruppe kann das Verhalten **Automatisch** oder **Immer erweitert** verwenden. Die Verfügbarkeit von Modulen hängt weiterhin vom installierten Anbieter und der Hardware ab, daher wird ein fehlender Bluetooth-, Helligkeits- oder Speicheranzeiger nicht durch Ändern des Leistenabstands erstellt.

**Höhe** legt die Leistenhöhe auf 24, 28 (Standard), 32 oder 36 Pixel fest. **Rahmen** schaltet den Taskleistenrahmen ein oder aus und legt seine Dicke auf 1, 2 oder 3 Pixel fest. Die Dicke gilt für das Taskleistenfenster, die Gruppen `right-0`, `right-1`, `focus` und `right-2` sowie für den Rand des MPRIS-Players. Das Schweben über interaktiven Modulen, einschließlich des Players, verringert deren Deckkraft leicht. Bei ausgeschaltetem Rahmen werden diese Rahmen als `0px` geschrieben. Beide sind Entwürfe in **Systemsteuerung → Erscheinungsbild → Taskleiste**, bis **[ Anwenden ]** ausgewählt wird.

**Systemsteuerung → Erscheinungsbild → Taskleiste → Symbole → Optionale Module** steuert die Sichtbarkeit optionaler Status- und Aktionsmodule. Arbeitsbereiche, der Titel des fokussierten Fensters, Einstellungen und Energie bleiben verfügbar. **Arbeitsbereichspräsentation** wählt Arbeitsbereichsbezeichnungen (Standard) oder Anwendungs-Symbole. MPRIS-Player zeigen Titeldetails in ihren Tooltips an; der Player verwendet keinen kontinuierlichen Farbverlauf mehr.

## Transparenz und Unschärfe

Verwenden Sie **Systemsteuerung → Erscheinungsbild → Taskleiste**, um Dienstprogramm-Symbole, Transparenz und Unschärfe zu konfigurieren. Transparenz und Unschärfe verfügen jeweils über einen Aktivierungsschalter und einen `0–100%`-Wert. Ändern Sie Werte mit `+` und `-` in Schritten von 5 %; Änderungen sind Entwürfe, bis **[ Anwenden ]** ausgewählt wird. Neue Designs aktivieren standardmäßig beide Effekte mit `50%`.
Verwenden Sie `↑/↓`, um zwischen der Aktivierungs- und der Wertezeile zu wechseln. Drücken Sie `Tab` für **Aktionen** und aktivieren Sie dann **[ Anwenden ]**.

## Konfiguration und Überschreibungen

Die Taskleisten-Konfiguration wird von `argvus-taskbar` verwaltet, von `argvus-waybar` dargestellt und von `argvus-session` gestartet. `argvus-config` ist die einzige Komponente, die die Taskleisten-Consumer-Dateien schreibt: Sie projiziert die aktive Ebene unter `~/.config/argvus/data/generated/waybar/` und wendet die Themenebene, Taskleisten-Ränder, `right-2` Utility-Gruppen-Modus, Randradius und den Schriftblock erneut an, wann immer sich Themen oder Layoutzustände ändern. Ein Themenwechsel stellt auch die vorhandenen Taskleisten-Dateien wieder her und schreibt dann die in der Systemsteuerung gewählte Höhe und den Rand zurück, die als `/taskbar/shape/height` und `/taskbar/shape/border_width` in `argvus config` gespeichert werden. Bis eine gewählt wird, ist sie `null` und folgt dem Thema: 28 px hoch, mit einem 1 px Rand (Slate Dark hat keinen). Da die erzeugte Kopie zuerst aufgelöst wird, wirkt ein nativer Waybar-Pfad unter `~/.config/waybar/` nur, solange die entsprechende erzeugte Datei fehlt. Siehe [Waybar und Taskleiste overrides](/docs/argvus-waybar/) für Vorrang, Beispiele und Fehlerbehebung.

## Windows und Bedienfelder

Die Taskleiste ist eine Shell-Oberfläche neben der Systemsteuerung und dem optionalen Telemetrie-Widget. Hyprland ordnet Fenster entsprechend dem aktiven Layoutzustand an, während diese Oberflächen eigene Anker und Ränder haben. `SUPER + SHIFT + Space` wechselt das fokussierte Fenster zwischen gekachelten und schwebenden Layouts.

## Uhr und Fokus

Das Zeitmodul (`clock#time`) öffnet oder versteckt das ARGVUS-Uhr-Popup und übergibt seine root-Klick-Koordinaten, damit es sich mit der angeklickten Taskleiste und dem Monitor ausrichten kann. Der Fokus-Indikator hat seine eigene `focus`-Gruppe zwischen der Netzwerk-/Leistungsgruppe (`right-1`) und Datum/Uhrzeit (`right-0`). Es läuft `argvus focus status --waybar --follow` ohne GTK zu laden: Während der Leerlaufzeit wird das Timer-Symbol angezeigt, und während einer Fokus- oder Pausenphase fügt es die verbleibende `MM:SS` hinzu; seine Farbe kennzeichnet die Phase und den pausierten Zustand. Ein Klick darauf öffnet oder versteckt das Fokus-Popup an dieser Klick-Position. Beide Popups schließen auch mit **Esc** oder einem Klick außerhalb.

## Neu Laden

Der Hauptdienst ist `argvus-taskbar.service`. Wenn eine dokumentierte Konfigurationsänderung ein manuelles Neuladen erfordert, verwenden Sie den Sitzungskontroller:

```sh
argvus sessionctl restart waybar
```
Kalender- und Wechselspeicher-Popups verwenden den unveränderlichen Root-Koordinaten-Vertrag, der vom ARGVUS Waybar-Build bereitgestellt wird, um den Monitor zu identifizieren. Der Kalender folgt der tatsächlichen horizontalen Taskleisten-Oberfläche: Er öffnet sich 4 Pixel unter einer oberen Leiste oder 4 Pixel über einer unteren Leiste, unabhängig davon, wo innerhalb des Datumsmoduls geklickt wurde; das Datumsmodul öffnet den Kalender. Bearbeiten Sie die generierte Laufzeitkonfiguration nicht, um dauerhafte Änderungen vorzunehmen; verwenden Sie das Control Center oder den dokumentierten [Waybar override](/docs/argvus-waybar/) Pfad].

Dienstprogramme reduzieren sich im Hover-Modus zu einem Expander und zeigen aktivierte Steuerungen beim Betreten mit dem Zeiger an. Die Sichtbarkeit der Systemleiste steuert Hintergrundanwendungs-Symbole; eine leere Leiste hat keine sichtbaren Symbole. Die Präsentation der Arbeitsbereichssymbole zeigt Anwendungs-Symbole für offene Fenster neben den Arbeitsbereichsbezeichnungen an.

## Projektarbeitsbereiche

Geöffnete Projekte erscheinen als gewöhnliche Arbeitsbereichs-Schaltflächen, beschriftet mit `Project: name`; ein Klick darauf fokussiert es. Beim Schweben wird der vollständige Projektpfad und die `SUPER + ALT + N`-Verknüpfung angezeigt. Es werden nur geöffnete Arbeitsbereiche auf dem Monitor der Leiste angezeigt; der Auswähler (`SUPER + O`) bleibt der vollständige Projektkatalog. Spezielle Arbeitsbereiche behalten ihre bestehende Sichtbarkeitspolitik bei.

Das `hyprland/workspaces`-Modul liest `workspace-metadata: "argvus/project-workspaces.json"` relativ zu `$XDG_RUNTIME_DIR`. `argvus projects` generiert diese abgeleitete Datei jedes Mal neu, wenn ein Projekt geöffnet wird. Das gepatchte `argvus-waybar` unterstützt Hyprland 0.57 Textarbeitsbereichsadressen und verwendet die Metadaten für Beschriftungen, ohne die Identität der Arbeitsbereiche zu ändern. Aktualisieren Sie alle drei Pakete und reprojizieren Sie die Taskleistenkonfiguration, bevor Sie den Dienst neu starten.

Das **Update-Status**-Modul hat eine eigene Gruppe zwischen Dienstprogrammen und Netzwerk/Leistung und zeigt die Anzahl verfügbarer Paketaktualisierungen an. Es überprüft die offiziellen Repositories beim Start und stündlich mit `checkupdates` (von `pacman-contrib`), ohne Pakete zu aktualisieren. **AUR überprüfen** ist standardmäßig deaktiviert; wenn aktiviert, wird mit `paru` oder `yay` geprüft. Der Tooltip trennt die Quellen und meldet Fehler; `?` bedeutet, dass die Gesamtsumme unvollständig ist. Klicken Sie auf das Modul, um die offiziellen Updates in Paketen zu öffnen. Konfigurieren Sie beide Optionen unter **Symbole → Optionale Module** und wenden Sie den Taskleisten-Entwurf an. Das Modul ist standardmäßig aktiviert.
