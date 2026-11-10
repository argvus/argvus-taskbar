---
title: Widgets
description: Optionale System-Telemetrie-Widgets konfigurieren.
---
`argvus widget-telemetry` bietet eine optionale Hilfsfläche für die Waybar zur Systeminformation. Die aktuellen Blöcke sind **System**, **CPU/GPU**, **Speicher**, **Speicherplatz**, **Prozesse**, **Netzwerk** und **Verknüpfungen**. Der Block Verknüpfungen wird mit dem Schlüssel `keys` in der Statusdatei gespeichert.

Verwenden Sie **Systemsteuerung → Erscheinungsbild → Widget-Telemetrie**, um die Fläche zu aktivieren und einzelne Blöcke ein- oder auszuschalten. Wenn ein Block deaktiviert wird, wird dieses Telemetriemodul im Waybar-Profil ausgeblendet; es wird kein Paket deinstalliert und der Rest der Sitzung läuft weiter. Der Hauptschalter steuert die Telemetriefläche insgesamt.

Die Blockauswahl ist kanonisch in `config.json`, bei `control_panel.widget_telemetry_blocks`, und der Hauptschalter ist `control_panel.widget_telemetry_enabled`. `argvus-config` projiziert diese Auswahl in das Waybar-Profil `data/waybar/argvus-widget-telemetry.jsonc`, indem die Zeilen innerhalb seiner abgegrenzten `ARGVUS_TELEMETRY_<BLOCK>_BEGIN`/`_END`-Blöcke auskommentiert oder einkommentiert werden, während der Rest der Datei unberührt bleibt. Eine ältere `~/.local/state/argvus/widget-telemetry-blocks`-Datei wird weiterhin als Migrations-Rückfall bei älteren Installationen gelesen, aber sie wird nie geschrieben. Beachten Sie, dass das gesamte Profil bei einer Designänderung durch das standardmäßig ausgelieferte ersetzt wird, sodass die Blockmarkierungen dafür sorgen, dass die Auswahl erhalten bleibt; Text außerhalb davon wird bei einem Themenwechsel nicht beibehalten.

Der Controller unterstützt:

```sh
argvus widget-telemetry-toggle status
argvus widget-telemetry-toggle on
argvus widget-telemetry-toggle off
argvus widget-telemetry-toggle blocks status
argvus widget-telemetry-toggle blocks set memory disabled
argvus widget-telemetry-toggle blocks apply
```
Der Controller akzeptiert auch `blocks set <block> <enabled|disabled>` für `system`, `cpu_gpu`, `memory`, `storage`, `processes`, `network` und `keys`. Präferenzen sind persistent; wenn ein Block keine explizite Präferenz hat, folgt er dem aktivierten Standard. `blocks set` schreibt das kanonische Array in einem einzigen atomaren Patch neu, projiziert dann das Waybar-Profil und stimmt den Service-Lifecycle ab. `apply-state` ist der Pfad des Control Centers: Es geht davon aus, dass der Aufrufer die Auswahl bereits gespeichert hat, und projiziert sie nur, daher darf es niemals mit einem nicht gespeicherten Zustand aufgerufen werden.

Der Dienst ist `argvus-widget-telemetry.service` und wird von `argvus-session` verwaltet. Es gibt keinen separaten Reset-Button pro Block auf der aktuellen Seite: Den Block erneut aktivieren oder die vom Anbieter unterstützte Zustandsverwaltung verwenden, anstatt die generierte Waybar-Ausgabe zu bearbeiten.

## Transparenz und Unschärfe

Verwenden Sie **Systemsteuerung → Darstellung → Widget-Telemetrie**, um den Hauptschalter, Telemetriesitzungen, Transparenz und Unschärfe zu konfigurieren. Beide Effekte haben unabhängige Aktivierungsschalter und `0–100%`-Werte. Verwenden Sie `+` und `-` in 5%-Schritten und wählen Sie **[ Übernehmen ]**; die Werte werden erst nach der Bestätigung angewendet und für das aktive Thema gespeichert.  
Verwenden Sie `↑/↓`, um zwischen den Aktivierungs- und Wertreihen zu wechseln. Drücken Sie `Tab` für **Aktionen**, und aktivieren Sie dann **[ Übernehmen ]**.

Das GPU-Temperaturmodul wird angezeigt, wenn DRM/sysfs eine unterstützte NVIDIA-, AMD- oder Intel-GPU freigibt und `btop` installiert ist. Sein Wert ist die höchste gültige Temperatur, die einer der erkannten GPUs zugeordnet werden kann; wenn kein Sensor freigegeben wird, zeigt es `N/A` an. Ein Klick darauf öffnet die GPU-Only-btop-Panels in Kitty über `argvus tui-terminal` unter Verwendung des `taskbar-monitor`-Profils. Drücken Sie `q` oder `Esc`, um zu schließen; die lokalisierte untere Registerkarte zeigt `Press q to close`. btop 1.4.7 unterstützt bis zu sechs GPU-Felder. NVIDIA-Metriken erfordern btop-GPU-Unterstützung und NVML; AMD erfordert btop-GPU-Unterstützung und ROCm SMI; Intel erfordert lesbare sysfs-Schnittstellen. NVIDIA nouveau-, AMD- und Intel-Temperaturen werden nur angezeigt, wenn ein verknüpfter hwmon-Sensor freigegeben ist. ARGVUS ändert keine Berechtigungen und fügt keine privilegierten Hilfsprogramme hinzu. Das Taskleistenpaket hängt von btop ab; Anbieter des Herstellers bleiben optional.


Das optionale AI-Agenten-Symbol in Gruppe/rechts-2 öffnet das argvus-ai-Menü. Es wird alle fünf Sekunden überprüft und ausgeblendet, wenn der Helfer nicht vorhanden ist oder keine Agenten verfügbar sind (argvus-ai status --check). Claude wird als installierbar angeboten, wenn mise vorhanden ist. Durch die Auswahl wird das ARGVUS-Terminal geöffnet, es wird im aktuellen Benutzerprofil installiert, falls es fehlt, und dann mit seinem Binärverzeichnis im Prozess-PATH gestartet. Es wird kein Paketinstallations-Hook verwendet. Lade die Leiste neu, um die aktualisierte Systemkonfiguration zu laden; Benutzerkopien werden nicht überschrieben. 

Der AI-Launcher verwendet nf-md-robot (U+F06A9) mit Symbols Nerd Font Mono. Der Appearance Projector bewahrt es in Gruppe/rechts-2 neben dem Mikrofon- und Audio-Steuerungen. 

## Fenster-Modus-Wähler

Das Fenster-Symbol in `group/right-2` öffnet nach dem Dienstprogramm-Erweiterer ein GTK-Popup mit **Kacheln-Fenster (Standard)** und **Schwebende Fenster**. Die aktuelle Präferenz ist markiert. Wählen Sie eine Option aus, um sie sofort anzuwenden; Escape oder ein Klick außerhalb schließt das Popup. Das Symbol zeigt den effektiven Modus an, mit einem ausstehenden/Fehler-Stil, wenn die Anwendung nicht abgeschlossen ist. Das Popup folgt der Taskleistenposition und dem aktuellen Thema.

Die Einstellung wird mit **Control Center → Desktop & Eingabe → Hyprland → Fenster → Modus** geteilt. Schwebende Fenster betreffen alle Anwendungsfenster über Monitore und Arbeitsbereiche hinweg. Die Rückkehr zu Kacheln behält Fenster bei, die ursprünglich schwebend waren. Die Auswahl bleibt zwischen den Anmeldungen erhalten.

Der Helfer ist `argvus window-mode-menu`; `argvus window-mode-menu --status` gibt Waybar-JSON aus. Er wird vom Master-Paket `argvus` bereitgestellt. Bestehende angepasste Taskbar-Kopien bleiben erhalten: Fügen Sie die `custom/window-mode`-Moduldefinition und den Gruppeneintrag aus der bereitgestellten Vorlage hinzu, um teilzunehmen, oder verwenden Sie das Kontrollzentrum. Der Darstellungsgenerator bewahrt das Modul, wenn seine Definition vorhanden ist, auch wenn andere Hilfssymbolleisten deaktiviert sind.

## Fensterknöpfe und Anwendungsleiste

Der Floating-Modus fügt normalen Anwendungsfenstern eine ARGVUS-Titelleiste mit **Minimieren**, **Maximieren / Wiederherstellen** und **Schließen** hinzu. Doppelklick auf die Titelleiste wechselt die Maximierung. Die zusätzliche Dekoration wird im Kachel- und Vollbildmodus ausgeblendet. Anwendungen, die ihre eigenen Steuerungen zeichnen, können beide Leisten anzeigen; einheitliche ARGVUS-Steuerungen sind beabsichtigt.

Eine zweite Waybar erscheint auf jedem Monitor, am gegenüberliegenden Rand der Haupttaskleiste. Sie listet nur die Fenster des aktuellen Arbeitsbereichs dieses Monitors, einschließlich der minimierten Fenster. Versteckte Gruppentabs erzeugen keine zusätzlichen Einträge. Minimierte Einträge behalten ihre ursprüngliche Monitor-/Arbeitsbereichszuordnung bei. Klicken Sie auf ein inaktives Fenster, um es zu aktivieren, auf ein aktives Fenster, um es zu minimieren, oder auf ein minimiertes Fenster, um es wiederherzustellen; sein Kontextmenü bietet Wiederherstellen, Minimieren, Maximieren/Wiederherstellen und Schließen. Symbole unbekannter Anwendungen werden durch ein Fenstersymbol ersetzt. Das Aktivieren oder Wiederherstellen eines Eintrags behält die Position des Zeigers bei. Die sekundäre Leiste verwendet die effektive primäre CSS (Farben, Schriftarten, Rahmen und Rundungen), mit ihrer Höhe und gespiegelten Abständen am gegenüberliegenden Rand.

`SUPER + Alt + Up` platziert die Hauptleiste oben und die Fensterleiste unten. `SUPER + Alt + Down` macht das Gegenteil. Wird eine Richtung wiederholt, bleiben die Positionen unverändert. Kachel hat nur die Hauptleiste. Die Rückkehr zur Kachel stellt alle minimierten Fenster wieder her, bevor die Fensterleiste entfernt wird, und bewahrt dann die ursprüngliche Kachel-/Schwebe-Strategie.

Die Minimierung verwendet den reservierten Arbeitsbereich `special:argvus-minimized`. Verwenden Sie diesen Arbeitsbereich nicht manuell. Der Prozess `argvus windows service` zeichnet Identität, ursprünglichen Arbeitsbereich/Monitor, Geometrie, Vollbild/Maximierung und Pinnstatus in einem compositorspezifischen Runtime-Registry unter `$XDG_RUNTIME_DIR/argvus` auf. Die Aufzeichnungen überleben einen Dienstneustart oder ein Konfigurations-Reload, überschreiten jedoch keine Compositor-Sitzungen. Das Schließen eines Fensters entfernt dessen Eintrag. Wenn ein Monitor verschwindet, erfolgt die Wiederherstellung über einen verfügbaren Ausgang. Eine fehlende oder ausgefallene Wiederherstellungsleiste verhindert neue Minimierungen; eine fehlgeschlagene Wiederherstellung behält den Eintrag und die Wiederherstellungsleiste bei.

Die Sitzung besitzt `argvus-windows.service` und `argvus-window-bar.service`. Letzteres hält sein Waybar-Kind in Tile inaktiv. Das Hyprbars-Plugin wird von `argvus-hyprland` bereitgestellt, gebaut für die Hyprland 0.57.0 ABI auf x86_64; es wird nicht im Home-Verzeichnis des Benutzers kompiliert. Bauen Sie das Plugin bei einem Compositor-ABI-Update neu.Befehle: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all` und `minimize|restore|activate|maximize|close ADDRESS`. Die Fensteradressen stammen aus der Liste. `position top --persist` speichert/projektiert die Voreinstellung, ohne die Hauptleiste neu zu starten. Konfigurations- und Laufzeitfehlerdetails werden im Journal geschrieben; sichtbare Aktionsfehler zeigen ebenfalls eine übersetzte Benachrichtigung an.

In **Spaced + Floating** respektieren Fenster äußere Abstände und die von beiden Leisten reservierten Bereiche. Die Begrenzungen beinhalten Rahmen und Titel, der innerhalb desselben Fensterrahmens sitzt. Maximieren über ARGVUS-Steuerungen füllt diesen Bereich mit Rand; Wiederherstellen stellt die vorherige Geometrie wieder her, einschließlich nach einem Dienstneustart. Der Vollbildmodus nutzt weiterhin den gesamten Ausgang. Schwebende Fenster können sich überlappen; Kachel-Innenabstände trennen sie nicht.
