---
title: Taskleiste
description: Verwenden Sie die ARGVUS Quickshell-Taskleiste.
---

Taskleiste und Telemetrie sind unabhängige Oberflächen im Quickshell-Prozess von `argvus-bars.service`. Die Dienste `argvus-taskbar.service` und `argvus-widget-telemetry.service` steuern die einzelnen Oberflächen.

Sie kommuniziert Arbeitsbereiche, Fokus-Fenster-Status, Uhr- und Kalenderzugriff, Netzwerk, Bluetooth, Audio/Medien, Benachrichtigungen, Speicher, Aufnahme, Aktiv-bleiben- und Strom-/Sitzungsaktionen. Die genauen Statusmodule können durch installierte Anbieter und Hardware beeinflusst werden.

Das linke Symbol öffnet `argvus launcher`. Es ist standardmäßig deaktiviert. Wenn es aktiviert ist, folgt es dem aktiven Thema: Der Theme-Build rendert es in der Highlight-Farbe des Themas (`taskbar/menu.svg`, aus der `taskbar-menu`-Vorlage dieses Pakets), während die integrierten ARGVUS Dark/ARGVUS Light-Themen `menu-default-dark.svg`/`menu-default-light.svg` verwenden (beide bereitgestellt von `argvus-branding`). Verwenden Sie **Systemsteuerung → Erscheinungsbild → Taskleiste → Symbole → Launcher**, um es zu aktivieren/deaktivieren oder ein benutzerdefiniertes Symbolbild auszuwählen, das das Themensymbol überschreibt.

Die Taskleiste ist nicht die Systemsteuerung. Die Leiste kommuniziert den persistenten Desktop-Zustand und -Status; die Systemsteuerung ist eine erweiterbare Oberfläche für Schnellaktionen. Kalender- und Wechseldatenträger-Popups sind Begleit-Anwendungen/-Oberflächen, keine separaten Taskleisten.

Wenn man auf **Speicher** oder **CPU** klickt, öffnet sich `btop` im thematischen ARGVUS-Monitor-Panel, mit einem `ARGVUS`-Kopfzeilenbereich und einem `Esc Close`-Fußbereich. Der untere Kitty-Tab zeigt den lokalisierten `Press q to close`-Hinweis. Drücken Sie `q` oder `Esc`, um zu schließen. Das CPU-Temperaturmodul öffnet die Live-`argvus sensors`-Übersicht, gruppiert nach Chip. Das GPU-Temperaturmodul erscheint, wenn eine unterstützte GPU und `btop` verfügbar sind; es zeigt die höchste zuordenbare GPU-Temperatur oder `N/A` an, und ein Klick darauf öffnet GPU-only-Btop-Panels im selben thematischen Rahmen. Btop unterstützt bis zu sechs GPU-Felder. NVIDIA-Metriken benötigen deren GPU-Unterstützung und NVML, AMD-Metriken benötigen ROCm SMI, und Intel-Metriken benötigen lesbare sysfs-Schnittstellen. Die GPU-Temperatur wird nur angezeigt, wenn das System eine ablesbare Messung zu diesem Gerät bereitstellt; die Intel-Temperatur ist von btop 1.4.7 nicht verfügbar. Wenn btop ein GPU-Feld nicht darstellen kann, weil Unterstützung oder ein Anbieter fehlt, meldet das ARGVUS-Panel, dass Metriken nicht verfügbar sind. nicht verfügbar. ARGVUS ändert keine Systemberechtigungen.

## Position und Abstand

Die Standardposition ist die obere Kante im Dock-Modus. Das Kontrollzentrum zeigt die Taskleistenposition und Taskleisten-/Shell-Ränder unter **Erscheinungsbild → Taskleiste → Position** und **Abstände** sowie die Dienstprogrammgruppe unter **Erscheinungsbild → Taskleiste → Symbole** an. Der Layoutzustand speichert unabhängige obere, linke, rechte und untere Ränder. Im Sticky-Modus wird der untere Rand standardmäßig auf `2` gesetzt und die Leiste nahe an der Kante gehalten; der Spaced-Modus verwendet einen Standard-Shell-Rand von `18`-Einheiten.

Taskleistenrand, äußerer Fensterabstand und Panelgeometrie sind verwandt, aber unterschiedlich. Eine Änderung eines Wertes ändert nicht automatisch alle anderen Werte. Wenn eine Leiste visuell von Fenstern getrennt erscheint, überprüfen Sie den Modus, die Taskleistenränder und den Fensterabstand zusammen; siehe [Windows und Layout](/docs/argvus-hyprland/windows-and-layout/).

Die Steuerung der Taskleistenposition wählt derzeit **Oben** oder **Unten**. Die vier unabhängigen Ränder steuern, wie weit die Leiste von jedem Bildschimrand entfernt sitzt. Die Dienstprogrammgruppe kann das Verhalten **Automatisch** oder **Immer erweitert** verwenden. Die Verfügbarkeit von Modulen hängt weiterhin vom installierten Anbieter und der Hardware ab, daher wird ein fehlender Bluetooth-, Helligkeits- oder Speicheranzeiger nicht durch Ändern des Leistenabstands erstellt.

**Höhe** legt die Leistenhöhe auf 24 (Standard), 28, 32 oder 36 Pixel fest. **Rahmen** schaltet den Taskleistenrahmen ein oder aus und legt seine Dicke auf 1, 2 oder 3 Pixel fest. Die Dicke gilt für das Taskleistenfenster, die Gruppen `right-0`, `right-1`, `focus` und `right-2` sowie für den Rand des MPRIS-Players. Der aktive Arbeitsbereich erscheint in invertierten Farben auf einer rechteckigen Fläche. Tooltips übernehmen dessen Farben und Schrift. Bei ausgeschaltetem Rahmen werden diese Rahmen als `0px` geschrieben. Beide sind Entwürfe in **Systemsteuerung → Erscheinungsbild → Taskleiste**, bis **[ Anwenden ]** ausgewählt wird.

**Systemsteuerung → Erscheinungsbild → Taskleiste → Symbole → Optionale Module** steuert die Sichtbarkeit optionaler Status- und Aktionsmodule. Arbeitsbereiche, der Titel des fokussierten Fensters, Einstellungen und Energie bleiben verfügbar. **Arbeitsbereichspräsentation** wählt Arbeitsbereichsbezeichnungen (Standard) oder Anwendungs-Symbole. MPRIS-Player zeigen Titeldetails in ihren Tooltips an; der Player verwendet keinen kontinuierlichen Farbverlauf mehr.

## Transparenz und Unschärfe

Verwenden Sie **Systemsteuerung → Erscheinungsbild → Taskleiste**, um Dienstprogramm-Symbole, Transparenz und Unschärfe zu konfigurieren. Transparenz und Unschärfe verfügen jeweils über einen Aktivierungsschalter und einen `0–100%`-Wert. Ändern Sie Werte mit `+` und `-` in Schritten von 5 %; Änderungen sind Entwürfe, bis **[ Anwenden ]** ausgewählt wird. Neue Designs aktivieren standardmäßig beide Effekte mit `50%`.
Verwenden Sie `↑/↓`, um zwischen der Aktivierungs- und der Wertezeile zu wechseln. Drücken Sie `Tab` für **Aktionen** und aktivieren Sie dann **[ Anwenden ]**.

## Konfiguration und Überschreibungen

`argvus config`: `/layout/taskbar`, `/taskbar`, `/fonts/targets/taskbar`.

`$XDG_RUNTIME_DIR/argvus/bars/presentation.json` ← `argvus sessionctl bars-presentation`.

## Windows und Bedienfelder

Die Taskleiste ist eine Shell-Oberfläche neben der Systemsteuerung und dem optionalen Telemetrie-Widget. Hyprland ordnet Fenster entsprechend dem aktiven Layoutzustand an, während diese Oberflächen eigene Anker und Ränder haben. `SUPER + SHIFT + Space` wechselt das fokussierte Fenster zwischen gekachelten und schwebenden Layouts.

## Uhr und Fokus

Das Zeitmodul (`clock#time`) öffnet oder versteckt das ARGVUS-Uhr-Popup und übergibt seine root-Klick-Koordinaten, damit es sich mit der angeklickten Taskleiste und dem Monitor ausrichten kann. Der Fokus-Indikator hat seine eigene `focus`-Gruppe zwischen der Netzwerk-/Leistungsgruppe (`right-1`) und Datum/Uhrzeit (`right-0`). Es läuft `argvus focus status --waybar --follow` ohne GTK zu laden: Während der Leerlaufzeit wird das Timer-Symbol angezeigt, und während einer Fokus- oder Pausenphase fügt es die verbleibende `MM:SS` hinzu; seine Farbe kennzeichnet die Phase und den pausierten Zustand. Ein Klick darauf öffnet oder versteckt das Fokus-Popup an dieser Klick-Position. Beide Popups schließen auch mit **Esc** oder einem Klick außerhalb.

## Neu Laden

Der Hauptdienst ist `argvus-taskbar.service`. Wenn eine dokumentierte Konfigurationsänderung ein manuelles Neuladen erfordert, verwenden Sie den Sitzungskontroller:

```sh
argvus sessionctl restart waybar
```
Kalender- und Wechselspeicher-Popups verwenden den unveränderlichen Root-Koordinaten-Vertrag, der vom ARGVUS Quickshell-Build bereitgestellt wird, um den Monitor zu identifizieren. Der Kalender folgt der tatsächlichen horizontalen Taskleisten-Oberfläche: Er öffnet sich 4 Pixel unter einer oberen Leiste oder 4 Pixel über einer unteren Leiste, unabhängig davon, wo innerhalb des Datumsmoduls geklickt wurde; das Datumsmodul öffnet den Kalender. Bearbeiten Sie die generierte Laufzeitkonfiguration nicht, um dauerhafte Änderungen vorzunehmen; verwenden Sie das Control Center oder den dokumentierten Pfad].

Dienstprogramme reduzieren sich im Hover-Modus zu einem Expander und zeigen aktivierte Steuerungen beim Betreten mit dem Zeiger an. Die Sichtbarkeit der Systemleiste steuert Hintergrundanwendungs-Symbole; eine leere Leiste hat keine sichtbaren Symbole. Die Präsentation der Arbeitsbereichssymbole zeigt Anwendungs-Symbole für offene Fenster neben den Arbeitsbereichsbezeichnungen an.

## Projektarbeitsbereiche

Geöffnete Projekte erscheinen als gewöhnliche Arbeitsbereichs-Schaltflächen, beschriftet mit `Project: name`; ein Klick darauf fokussiert es. Beim Schweben wird der vollständige Projektpfad und die `SUPER + ALT + N`-Verknüpfung angezeigt. Es werden nur geöffnete Arbeitsbereiche auf dem Monitor der Leiste angezeigt; der Auswähler (`SUPER + O`) bleibt der vollständige Projektkatalog. Spezielle Arbeitsbereiche behalten ihre bestehende Sichtbarkeitspolitik bei.

`$XDG_RUNTIME_DIR/argvus/project-workspaces.json` · `argvus projects`

Das **Update-Status**-Modul hat eine eigene Gruppe zwischen Dienstprogrammen und Netzwerk/Leistung und zeigt die Anzahl verfügbarer Paketaktualisierungen an. Es überprüft die offiziellen Repositories beim Start und stündlich mit `checkupdates` (von `pacman-contrib`), ohne Pakete zu aktualisieren. **AUR überprüfen** ist standardmäßig deaktiviert; wenn aktiviert, wird mit `paru` oder `yay` geprüft. Der Tooltip trennt die Quellen und meldet Fehler; `?` bedeutet, dass die Gesamtsumme unvollständig ist. Klicken Sie auf das Modul, um die offiziellen Updates in Paketen zu öffnen. Konfigurieren Sie beide Optionen unter **Symbole → Optionale Module** und wenden Sie den Taskleisten-Entwurf an. Das Modul ist standardmäßig aktiviert.

Nach Paketoperationen im Control Center (einschließlich offizieller und AUR-Upgrades) prüft die Taskleiste die verbleibenden Aktualisierungen automatisch ohne Neustart. Dies geschieht auch nach Fehlern, da einige Pakete bereits geändert sein können. Die stündliche Prüfung bleibt aktiv und erkennt Operationen außerhalb des Control Centers.

### Arbeitsbereichswechsel pro Monitor

Vorwärts/rückwärts durchläuft nur vorhandene Arbeitsbereiche des fokussierten Monitors: zuerst numerische, dann benannte und Projekte nach nativem Namen, mit Umlauf. Scrollen auf der Taskleiste verwendet den Monitor unter dem Zeiger. Spezielle Arbeitsbereiche sind ausgeschlossen und unterbrechen den Wechsel, solange sie geöffnet sind. Ziffernkürzel behalten globale IDs. Zuordnungen bleiben in `/displays/workspaces`.

`argvus config workspace-cycle next|previous [--monitor focused|cursor]`

**Power → ARGVUS Lifecycle** (`argvus-lifecycle`)

Die Zwischenablage ist standardmäßig aktiv und lässt sich über die Dienstprogrammgruppe der Taskleiste öffnen. Um keine Texte und Bilder mehr zu erfassen, deaktivieren Sie die Option unter Control Center → Appearance → Taskbar → Icons → Optional modules und wählen Sie Apply. Das Symbol verschwindet und der Verlauf ist bis zur erneuten Aktivierung gesperrt. Gespeicherte Einträge bleiben erhalten.

Browsermedien erscheinen nur, wenn der Player Spotify als Quelle angibt. Tooltips haben einen rahmenlosen Hintergrund.

Schlägt die Prüfung fehl, versucht es die Leiste nach 30 Sekunden erneut.

Ein Klick auf das Symbol der Zwischenablage oder der KI-Agenten öffnet das jeweilige Fenster. Ein erneuter Klick auf dasselbe Symbol schließt es.
