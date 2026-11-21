---
title: Widget
description: Configura i widget opzionali di telemetria del sistema.
---
`argvus widget-telemetry` fornisce una superficie Quickshell ausiliaria opzionale per le informazioni di sistema. I suoi blocchi attuali sono **Sistema**, **CPU/GPU**, **Memoria**, **Archiviazione**, **Processi**, **Rete** e **Scorciatoie**. Il blocco Scorciatoie è memorizzato con la chiave `keys` nel file di stato.

Usa **Pannello di Controllo → Aspetto → Telemetria dei Widget** per abilitare la superficie e attivare o disattivare singoli blocchi. Disabilitare un blocco nasconde quel modulo di telemetria dal profilo Quickshell; non disinstalla un pacchetto né interrompe il resto della sessione. L'interruttore principale controlla la superficie di telemetria nel suo insieme.

La barra delle applicazioni e la telemetria sono superfici indipendenti del processo Quickshell gestito da `argvus-bars.service`. Usa `argvus-taskbar.service` e `argvus-widget-telemetry.service` per controllare ogni superficie.

`/effects/widget_telemetry_enabled` · `widget-telemetry-blocks`

Il controller supporta:

`argvus widget-telemetry toggle blocks set <block> <enabled|disabled>` · `argvus widget-telemetry toggle apply-state`

Il servizio è `argvus-widget-telemetry.service` ed è gestito da `argvus-session`. Non esiste un pulsante di reset separato per blocco nella pagina attuale: riattiva il blocco, oppure utilizza la gestione dello stato supportata dal provider, invece di modificare l'output generato da Quickshell.

## Trasparenza e sfocatura

Usa **Centro di Controllo → Aspetto → Telemetria Widget** per configurare l'interruttore principale, le sessioni di telemetria, Trasparenza e Sfocatura. Entrambi gli effetti hanno interruttori di attivazione indipendenti e valori `0–100%`. Usa `+` e `-` a passi del 5% e seleziona **[ Applica ]**; i valori vengono applicati solo dopo la conferma e sono salvati per il tema attivo.
Usa `↑/↓` per spostarti tra le righe di attivazione e valori. Premi `Tab` per **Azioni**, quindi attiva **[ Applica ]**.

Il modulo della temperatura GPU viene mostrato quando DRM/sysfs espone una GPU NVIDIA, AMD o Intel supportata e `btop` è installato. Il suo valore è la temperatura valida più alta che può essere attribuita a una delle GPU rilevate; quando nessun sensore è esposto, mostra `N/A`. Cliccando su di esso si aprono i pannelli GPU-only di btop in Kitty tramite `argvus tui-terminal` usando il profilo `taskbar-monitor`. Premere `q` o `Esc` per chiudere; la scheda inferiore localizzata dice `Press q to close`. btop 1.4.7 supporta fino a sei box GPU. Le metriche NVIDIA richiedono il supporto GPU di btop e NVML; AMD richiede il supporto GPU di btop e ROCm SMI; Intel richiede interfacce sysfs leggibili. Le temperature di NVIDIA nouveau, AMD e Intel appaiono solo quando è esposto un sensore hwmon collegato. ARGVUS non altera i permessi né aggiunge helper privilegiati. Il pacchetto della barra delle applicazioni dipende da btop; i fornitori del produttore restano opzionali.


L'icona opzionale degli agenti AI in gruppo/destra-2 apre il menu argvus-ai. Viene controllata ogni cinque secondi ed è nascosta quando l'assistente è assente o non ci sono agenti disponibili (argvus-ai status --check). Claude è offerto come installabile quando mise è presente. Selezionandolo si apre il terminale ARGVUS, lo installa nel profilo utente corrente se mancante, poi lo avvia con la sua directory binaria nel PATH del processo. Non viene utilizzato alcun hook di installazione del pacchetto. Ricaricare la barra per caricare la configurazione di sistema aggiornata; le copie dell'utente non vengono sovrascritte.

Il launcher AI utilizza nf-md-robot (U+F06A9) con Symbols Nerd Font Mono. Il proiettore di aspetto lo preserva in gruppo/destra-2 insieme al microfono e ai controlli audio.

## Selettore della modalità finestra

L'icona della finestra in `group/right-2`, dopo l'espansore dell'utilità, apre un popup GTK con **Finestre a Piastrelle (Predefinito)** e **Finestre Fluttuanti**. La preferenza corrente è contrassegnata. Seleziona un'opzione per applicarla immediatamente; Esc o cliccare all'esterno chiude il popup. L'icona riflette la modalità effettiva, con uno stile in sospeso/errore quando l'applicazione non ha completato. Il popup segue la posizione della barra delle applicazioni e il tema attuale.

L'impostazione è condivisa con **Centro di Controllo → Desktop & Input → Hyprland → Finestre → Modalità**. Fluttuante influenza tutte le finestre delle applicazioni attraverso monitor e spazi di lavoro. Tornare a Piastrelle preserva le finestre che erano originariamente fluttuanti. La selezione persiste tra i login.

`argvus window-mode-menu` · `argvus window-mode-menu --status`

## Pulsanti delle finestre e barra delle applicazioni

La modalità flottante aggiunge una barra del titolo ARGVUS con **Minimizza**, **Massimizza / Ripristina** e **Chiudi** alle finestre delle applicazioni normali. Fare doppio clic sulla barra del titolo alterna la massimizzazione. La decorazione aggiuntiva è nascosta in Tile e a schermo intero. Le applicazioni che disegnano i propri controlli possono visualizzare entrambe le barre; i controlli ARGVUS uniformi sono intenzionali.

Una seconda Quickshell appare su ogni monitor, sul bordo opposto alla barra delle applicazioni principale. Elenca solo le finestre del workspace corrente di quel monitor, includendo anche le finestre ridotte a icona. Le schede di gruppo nascoste non creano voci extra. Le voci ridotte a icona mantengono la loro associazione originale con monitor/workspace. Clicca su una finestra inattiva per attivarla, su una finestra attiva per ridurla a icona, o su una finestra ridotta a icona per ripristinarla; il suo menu contestuale offre ripristina, riduci a icona, ingrandisci/ripristina e chiudi. Le icone delle applicazioni sconosciute ricadono su un simbolo di finestra. Attivare o ripristinare una voce preserva la posizione del cursore. La barra secondaria utilizza il CSS primario effettivo (colori, font, bordo e arrotondamento), con la sua altezza e i margini speculari sul bordo opposto.

`SUPER + Alt + Up` posiziona la barra principale in alto e la barra della finestra in basso. `SUPER + Alt + Down` fa il contrario. Ripetere una direzione lascia le posizioni invariate. Tile ha solo la barra principale. Tornare a Tile ripristina tutte le finestre minimizzate prima di rimuovere la barra della finestra e poi conserva la politica originale a piastrelle/galleggiante.

La minimizzazione utilizza lo spazio di lavoro riservato `special:argvus-minimized`. Non utilizzare manualmente quello spazio di lavoro. Il processo `argvus windows service` registra l'identità, lo spazio di lavoro/monitor originale, la geometria, lo stato a schermo intero/massimizzazione e lo stato di ancoraggio in un registro runtime specifico per l'istanza del compositore sotto `$XDG_RUNTIME_DIR/argvus`. I record sopravvivono a un riavvio del servizio o a un ricaricamento della configurazione, ma non attraversano le sessioni del compositore. La chiusura di una finestra rimuove il suo record. Se un monitor scompare, il ripristino utilizza un output disponibile. Una barra di ripristino mancante o guasta impedisce nuove minimizzazioni; un ripristino fallito mantiene il record e la barra di ripristino.

La sessione possiede `argvus-windows.service` e `argvus-window-bar.service`. Quest'ultimo mantiene il suo child Quickshell dormiente in Tile. Il plugin hyprbars è incluso da `argvus-hyprland`, costruito per l'ABI Hyprland 0.57.0 su x86_64; non è compilato nella directory home dell'utente. Ricompila il plugin con un aggiornamento dell'ABI del compositore.Comandi: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all` e `minimize|restore|activate|maximize|close ADDRESS`. Gli indirizzi delle finestre provengono dalla lista. `position top --persist` memorizza/proietta la preferenza senza riavviare la barra principale. I dettagli di configurazione e degli errori di runtime vengono scritti sul giornale; i fallimenti delle azioni visibili mostrano anche una notifica tradotta.

In **Spaced + Floating**, le finestre rispettano i margini esterni e le aree riservate da entrambe le barre. I confini includono il bordo e il titolo, che si trova all'interno dello stesso bordo della finestra. Il massimizzare tramite ARGVUS controlla riempie quest'area con margini; il ripristino recupera la geometria precedente, anche dopo il riavvio di un servizio. Lo schermo intero utilizza ancora l'intero output. Le finestre flottanti possono sovrapporsi; gli spazi interni del tiling non le separano.

La sezione dei processi si aggiorna ogni secondo e mostra i cinque processi con la somma più alta delle percentuali di CPU recente e memoria residente.
