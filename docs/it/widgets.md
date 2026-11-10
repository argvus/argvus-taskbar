---
title: Widget
description: Configura i widget opzionali di telemetria del sistema.
---
`argvus widget-telemetry` fornisce una superficie Waybar ausiliaria opzionale per le informazioni di sistema. I suoi blocchi attuali sono **Sistema**, **CPU/GPU**, **Memoria**, **Archiviazione**, **Processi**, **Rete** e **Scorciatoie**. Il blocco Scorciatoie è memorizzato con la chiave `keys` nel file di stato.

Usa **Pannello di Controllo → Aspetto → Telemetria dei Widget** per abilitare la superficie e attivare o disattivare singoli blocchi. Disabilitare un blocco nasconde quel modulo di telemetria dal profilo Waybar; non disinstalla un pacchetto né interrompe il resto della sessione. L'interruttore principale controlla la superficie di telemetria nel suo insieme.

La selezione a blocchi è canonica in `config.json`, in `control_panel.widget_telemetry_blocks`, e l'interruttore principale è `control_panel.widget_telemetry_enabled`. `argvus-config` proietta quella selezione nel profilo Waybar `data/waybar/argvus-widget-telemetry.jsonc` decommentando o commentando le righe all'interno dei suoi blocchi delimitati `ARGVUS_TELEMETRY_<BLOCK>_BEGIN`/`_END`, lasciando intatto il resto del file. Un file legacy `~/.local/state/argvus/widget-telemetry-blocks` viene ancora letto come fallback di migrazione nelle installazioni più vecchie, ma non viene mai scritto. Nota che l'intero profilo viene sostituito dal default incluso nel pacchetto in caso di cambio di aspetto, quindi i marcatori dei blocchi sono il modo in cui la selezione sopravvive; il testo al di fuori di essi non viene preservato tra un cambio di tema e l'altro.

Il controller supporta:

```sh
argvus widget-telemetry-toggle status
argvus widget-telemetry-toggle on
argvus widget-telemetry-toggle off
argvus widget-telemetry-toggle blocks status
argvus widget-telemetry-toggle blocks set memory disabled
argvus widget-telemetry-toggle blocks apply
```
Il controller accetta anche `blocks set <block> <enabled|disabled>` per `system`, `cpu_gpu`, `memory`, `storage`, `processes`, `network` e `keys`. Le preferenze sono persistenti; quando un blocco non ha una preferenza esplicita segue il valore predefinito abilitato. `blocks set` riscrive l'array canonico in una singola patch atomica, poi riproietta il profilo Waybar e riconcilia il ciclo di vita del servizio. `apply-state` è il percorso del Centro di Controllo: presume che il chiamante abbia già salvato la selezione e la proietta solo, quindi non chiamarlo mai con uno stato non salvato.

Il servizio è `argvus-widget-telemetry.service` ed è gestito da `argvus-session`. Non esiste un pulsante di reset separato per blocco nella pagina attuale: riattiva il blocco, oppure utilizza la gestione dello stato supportata dal provider, invece di modificare l'output generato da Waybar.

## Trasparenza e sfocatura

Usa **Centro di Controllo → Aspetto → Telemetria Widget** per configurare l'interruttore principale, le sessioni di telemetria, Trasparenza e Sfocatura. Entrambi gli effetti hanno interruttori di attivazione indipendenti e valori `0–100%`. Usa `+` e `-` a passi del 5% e seleziona **[ Applica ]**; i valori vengono applicati solo dopo la conferma e sono salvati per il tema attivo.
Usa `↑/↓` per spostarti tra le righe di attivazione e valori. Premi `Tab` per **Azioni**, quindi attiva **[ Applica ]**.

Il modulo della temperatura GPU viene mostrato quando DRM/sysfs espone una GPU NVIDIA, AMD o Intel supportata e `btop` è installato. Il suo valore è la temperatura valida più alta che può essere attribuita a una delle GPU rilevate; quando nessun sensore è esposto, mostra `N/A`. Cliccando su di esso si aprono i pannelli GPU-only di btop in Kitty tramite `argvus tui-terminal` usando il profilo `taskbar-monitor`. Premere `q` o `Esc` per chiudere; la scheda inferiore localizzata dice `Press q to close`. btop 1.4.7 supporta fino a sei box GPU. Le metriche NVIDIA richiedono il supporto GPU di btop e NVML; AMD richiede il supporto GPU di btop e ROCm SMI; Intel richiede interfacce sysfs leggibili. Le temperature di NVIDIA nouveau, AMD e Intel appaiono solo quando è esposto un sensore hwmon collegato. ARGVUS non altera i permessi né aggiunge helper privilegiati. Il pacchetto della barra delle applicazioni dipende da btop; i fornitori del produttore restano opzionali.


L'icona opzionale degli agenti AI in gruppo/destra-2 apre il menu argvus-ai. Viene controllata ogni cinque secondi ed è nascosta quando l'assistente è assente o non ci sono agenti disponibili (argvus-ai status --check). Claude è offerto come installabile quando mise è presente. Selezionandolo si apre il terminale ARGVUS, lo installa nel profilo utente corrente se mancante, poi lo avvia con la sua directory binaria nel PATH del processo. Non viene utilizzato alcun hook di installazione del pacchetto. Ricaricare la barra per caricare la configurazione di sistema aggiornata; le copie dell'utente non vengono sovrascritte.

Il launcher AI utilizza nf-md-robot (U+F06A9) con Symbols Nerd Font Mono. Il proiettore di aspetto lo preserva in gruppo/destra-2 insieme al microfono e ai controlli audio.

## Selettore della modalità finestra

L'icona della finestra in `group/right-2`, dopo l'espansore dell'utilità, apre un popup GTK con **Finestre a Piastrelle (Predefinito)** e **Finestre Fluttuanti**. La preferenza corrente è contrassegnata. Seleziona un'opzione per applicarla immediatamente; Esc o cliccare all'esterno chiude il popup. L'icona riflette la modalità effettiva, con uno stile in sospeso/errore quando l'applicazione non ha completato. Il popup segue la posizione della barra delle applicazioni e il tema attuale.

L'impostazione è condivisa con **Centro di Controllo → Desktop & Input → Hyprland → Finestre → Modalità**. Fluttuante influenza tutte le finestre delle applicazioni attraverso monitor e spazi di lavoro. Tornare a Piastrelle preserva le finestre che erano originariamente fluttuanti. La selezione persiste tra i login.

L'assistente è `argvus window-mode-menu`; `argvus window-mode-menu --status` emette JSON per Waybar. È fornito dal pacchetto principale `argvus`. Le copie esistenti della barra delle applicazioni personalizzata sono preservate: aggiungere la definizione del modulo `custom/window-mode` e la voce di gruppo dal modello incluso per iscriversi, oppure utilizzare il Centro di Controllo. Il proiettore di aspetto preserva il modulo quando la sua definizione è presente, anche se altre icone di utilità sono disabilitate.

## Pulsanti delle finestre e barra delle applicazioni

La modalità flottante aggiunge una barra del titolo ARGVUS con **Minimizza**, **Massimizza / Ripristina** e **Chiudi** alle finestre delle applicazioni normali. Fare doppio clic sulla barra del titolo alterna la massimizzazione. La decorazione aggiuntiva è nascosta in Tile e a schermo intero. Le applicazioni che disegnano i propri controlli possono visualizzare entrambe le barre; i controlli ARGVUS uniformi sono intenzionali.

Una seconda Waybar appare su ogni monitor, sul bordo opposto alla barra delle applicazioni principale. Elenca solo le finestre del workspace corrente di quel monitor, includendo anche le finestre ridotte a icona. Le schede di gruppo nascoste non creano voci extra. Le voci ridotte a icona mantengono la loro associazione originale con monitor/workspace. Clicca su una finestra inattiva per attivarla, su una finestra attiva per ridurla a icona, o su una finestra ridotta a icona per ripristinarla; il suo menu contestuale offre ripristina, riduci a icona, ingrandisci/ripristina e chiudi. Le icone delle applicazioni sconosciute ricadono su un simbolo di finestra. Attivare o ripristinare una voce preserva la posizione del cursore. La barra secondaria utilizza il CSS primario effettivo (colori, font, bordo e arrotondamento), con la sua altezza e i margini speculari sul bordo opposto.

`SUPER + Alt + Up` posiziona la barra principale in alto e la barra della finestra in basso. `SUPER + Alt + Down` fa il contrario. Ripetere una direzione lascia le posizioni invariate. Tile ha solo la barra principale. Tornare a Tile ripristina tutte le finestre minimizzate prima di rimuovere la barra della finestra e poi conserva la politica originale a piastrelle/galleggiante.

La minimizzazione utilizza lo spazio di lavoro riservato `special:argvus-minimized`. Non utilizzare manualmente quello spazio di lavoro. Il processo `argvus windows service` registra l'identità, lo spazio di lavoro/monitor originale, la geometria, lo stato a schermo intero/massimizzazione e lo stato di ancoraggio in un registro runtime specifico per l'istanza del compositore sotto `$XDG_RUNTIME_DIR/argvus`. I record sopravvivono a un riavvio del servizio o a un ricaricamento della configurazione, ma non attraversano le sessioni del compositore. La chiusura di una finestra rimuove il suo record. Se un monitor scompare, il ripristino utilizza un output disponibile. Una barra di ripristino mancante o guasta impedisce nuove minimizzazioni; un ripristino fallito mantiene il record e la barra di ripristino.

La sessione possiede `argvus-windows.service` e `argvus-window-bar.service`. Quest'ultimo mantiene il suo child Waybar dormiente in Tile. Il plugin hyprbars è incluso da `argvus-hyprland`, costruito per l'ABI Hyprland 0.57.0 su x86_64; non è compilato nella directory home dell'utente. Ricompila il plugin con un aggiornamento dell'ABI del compositore.Comandi: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all` e `minimize|restore|activate|maximize|close ADDRESS`. Gli indirizzi delle finestre provengono dalla lista. `position top --persist` memorizza/proietta la preferenza senza riavviare la barra principale. I dettagli di configurazione e degli errori di runtime vengono scritti sul giornale; i fallimenti delle azioni visibili mostrano anche una notifica tradotta.

In **Spaced + Floating**, le finestre rispettano i margini esterni e le aree riservate da entrambe le barre. I confini includono il bordo e il titolo, che si trova all'interno dello stesso bordo della finestra. Il massimizzare tramite ARGVUS controlla riempie quest'area con margini; il ripristino recupera la geometria precedente, anche dopo il riavvio di un servizio. Lo schermo intero utilizza ancora l'intero output. Le finestre flottanti possono sovrapporsi; gli spazi interni del tiling non le separano.
