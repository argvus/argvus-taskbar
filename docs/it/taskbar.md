---
title: Barra delle applicazioni
description: Usa la barra delle applicazioni ARGVUS Quickshell.
---

La barra delle applicazioni e la telemetria sono superfici indipendenti del processo Quickshell gestito da `argvus-bars.service`. Usa `argvus-taskbar.service` e `argvus-widget-telemetry.service` per controllare ogni superficie.

Comunica gli spazi di lavoro, lo stato della finestra attiva, l'accesso a orologio e calendario, rete, Bluetooth, audio/media, notifiche, archiviazione, registrazione, azioni di mantenimento attivo e alimentazione/sessione. I moduli di stato esatti possono essere influenzati dai provider installati e dall'hardware.

L'icona più a sinistra apre `argvus launcher`. È disabilitata per impostazione predefinita. Quando abilitata, segue il tema attivo: la costruzione del tema la rende nel colore evidenziato del tema (`taskbar/menu.svg`, dal modello `taskbar-menu` di questo pacchetto), mentre i temi ARGVUS Dark/ARGVUS Light integrati usano `menu-default-dark.svg`/`menu-default-light.svg` (entrambi forniti da `argvus-branding`). Usa **Centro di Controllo → Aspetto → Barra delle applicazioni → Icone → Avviatore** per abilitarla/disabilitarla o per scegliere un'immagine icona personalizzata, che sostituisce l'icona del tema.

La barra delle applicazioni non è il Pannello di Controllo. La barra comunica lo stato persistente e le informazioni del desktop; il Pannello di Controllo è una superficie di azioni rapide espandibile. I popup del calendario e dei dispositivi rimovibili sono applicazioni/superfici complementari, non barre delle applicazioni separate.

Cliccando su **Memoria** o **CPU** si apre `btop` all'interno del pannello monitor a tema ARGVUS, con un'intestazione `ARGVUS` e un piè di pagina `Esc Close`. La scheda Kitty in basso mostra il suggerimento localizzato `Press q to close`. Premere `q` o `Esc` per chiudere. Il modulo della temperatura CPU apre la panoramica live `argvus sensors`, raggruppata per chip. Il modulo della temperatura GPU appare quando è disponibile una GPU supportata e `btop`; mostra la temperatura GPU più alta attribuibile o `N/A`, e cliccandoci si aprono pannelli btop specifici per GPU nello stesso frame a tema. btop supporta fino a sei box GPU. Le metriche NVIDIA richiedono il supporto GPU e NVML, le metriche AMD richiedono ROCm SMI, e le metriche Intel richiedono interfacce sysfs leggibili. La temperatura GPU è mostrata solo quando il sistema fornisce una lettura collegata a quel dispositivo; la temperatura Intel non è disponibile in btop 1.4.7. Quando btop non può rendere un box GPU perché manca il supporto o un fornitore, il pannello ARGVUS segnala che le metriche sono non disponibile. ARGVUS non modifica i permessi di sistema.

## Posizione e spaziatura

La posizione predefinita è il bordo superiore in modalità dock. Il Centro di Controllo espone la posizione della barra delle applicazioni e i margini della barra delle applicazioni/shell sotto **Aspetto → Barra delle applicazioni → Posizione** e **Spazi**, e il gruppo di utilità sotto **Aspetto → Barra delle applicazioni → Icone**. Lo stato del layout memorizza margini indipendenti superiori, sinistri, destri e inferiori. La modalità Sticky imposta per default il margine inferiore su `2` e mantiene la barra vicino al bordo; la modalità Spaced utilizza un margine di shell predefinito di `18` unità.

Il margine della barra delle applicazioni, il gap esterno della finestra e la geometria del pannello sono collegati ma distinti. Modificare uno non riscrive tutti gli altri valori. Se una barra appare visivamente staccata dalle finestre, rivedere insieme la modalità, i margini della barra delle applicazioni e la spaziatura delle finestre; vedere [Windows e layout](/docs/argvus-hyprland/windows-and-layout/).

Il controllo della posizione della barra delle applicazioni seleziona attualmente **Top** o **Bottom**. I quattro margini indipendenti controllano quanto la barra sia distante da ciascun bordo dello schermo. Il gruppo delle utility può usare il comportamento **Auto** o **Sempre espanso**. La disponibilità dei moduli dipende ancora dal provider e dall'hardware installati, quindi un indicatore Bluetooth, della luminosità o dello spazio di archiviazione mancante non viene creato modificando la spaziatura della barra.

**Height** imposta l'altezza della barra a 24 (default), 28, 32 o 36 pixel. **Border** attiva o disattiva il bordo della barra delle applicazioni e ne imposta lo spessore a 1, 2 o 3 pixel. Lo spessore si applica alla finestra della barra delle applicazioni, ai gruppi `right-0`, `right-1`, `focus` e `right-2`, e al bordo del lettore MPRIS. L’area di lavoro attiva appare a colori invertiti su uno sfondo rettangolare. I suggerimenti riprendono i colori e il carattere del tema attivo. Con il bordo disattivato, quei bordi sono scritti come `0px`. Entrambi sono bozze in **Centro di Controllo → Aspetto → Barra delle Applicazioni** fino a quando non viene selezionato **[ Applica ]**.

**Centro di Controllo → Aspetto → Barra delle applicazioni → Icone → Moduli opzionali** controlla la visibilità dei moduli opzionali di stato e azione. Spazi di lavoro, il titolo della finestra attiva, Impostazioni e Alimentazione rimangono disponibili. **Presentazione degli spazi di lavoro** seleziona le etichette degli spazi di lavoro (predefinito) o le icone delle applicazioni. I lettori MPRIS mostrano i dettagli della traccia nei loro suggerimenti; il lettore non utilizza più un impulso di colore continuo.

## Trasparenza e sfocatura

Usa **Centro di Controllo → Aspetto → Barra delle applicazioni** per configurare Icone Utilità, Trasparenza e Sfocatura. Trasparenza e Sfocatura hanno ciascuno un interruttore di attivazione e un valore `0–100%`. Modifica i valori con `+` e `-` a passi del 5%; le modifiche sono bozze fino a quando non viene selezionato **[ Applica ]**. I nuovi temi predefiniti hanno entrambi gli effetti attivati a `50%`.  
Usa `↑/↓` per spostarti tra le righe di attivazione e i valori. Premi `Tab` per **Azioni**, quindi attiva **[ Applica ]**.

## Configurazione e sovrascritture

`argvus config`: `/layout/taskbar`, `/taskbar`, `/fonts/targets/taskbar`.

`$XDG_RUNTIME_DIR/argvus/bars/presentation.json` ← `argvus sessionctl bars-presentation`.

## Windows e pannelli

La barra delle applicazioni è una superficie della shell insieme al Pannello di Controllo e al widget di telemetria opzionale. Hyprland dispone le finestre in base allo stato attivo del layout, mentre queste superfici hanno i propri ancoraggi e margini. `SUPER + SHIFT + Space` alterna la finestra attiva tra layout a schede e flottante.

## Orologio e Focalizzazione

Il modulo time (`clock#time`) apre o nasconde il popup ARGVUS Clock e passa le coordinate di clic radice in modo che possa allinearsi con la barra delle applicazioni cliccata e il monitor. L'indicatore Focus ha il proprio gruppo `focus` tra il gruppo rete/performance (`right-1`) e data/ora (`right-0`). Esegue `argvus focus status --waybar --follow` senza caricare GTK: mentre è inattivo mostra l'icona del timer, e durante una fase di focus o pausa aggiunge il tempo rimanente `MM:SS`; il suo colore identifica la fase e lo stato di pausa. Cliccandolo si apre o si nasconde il popup Focus in quella posizione di clic. Entrambi i popup si chiudono anche con **Esc** o un clic all'esterno.

## Ricarica

Il servizio principale è `argvus-taskbar.service`. Quando una modifica alla configurazione documentata richiede un ricaricamento manuale, utilizzare il controller di sessione:

```sh
argvus sessionctl restart waybar
```
I popup del calendario e della memoria removibile utilizzano il contratto a coordinate radice immutabili fornito dalla build ARGVUS di Quickshell per identificare il monitor. Il calendario segue la reale superficie orizzontale della barra delle applicazioni: si apre 4 pixel sotto una barra superiore o 4 pixel sopra una barra inferiore, indipendentemente da dove all'interno del modulo della data sia stato cliccato; il modulo della data apre il calendario. Non modificare la configurazione runtime generata per apportare cambiamenti persistenti; utilizzare il Pannello di Controllo o il percorso documentato.

Le utility si comprimono in un espansore in modalità hover e rivelano i controlli abilitati al passaggio del puntatore. La visibilità del vassoio di sistema controlla le icone delle applicazioni in background; un vassoio vuoto non mostra icone visibili. La presentazione delle icone degli spazi di lavoro mostra le icone delle applicazioni per le finestre aperte accanto alle etichette degli spazi di lavoro.

## Spazi di lavoro del progetto

I progetti aperti appaiono come normali pulsanti della workspace, etichettati `Project: name`; cliccandone uno lo si focalizza. Passando con il mouse viene mostrato il percorso completo del progetto e il collegamento `SUPER + ALT + N`. Vengono visualizzate solo le workspace aperte sul monitor della barra; il selettore (`SUPER + O`) rimane il catalogo completo dei progetti. Le workspace speciali mantengono la loro politica di visibilità esistente.

`$XDG_RUNTIME_DIR/argvus/project-workspaces.json` · `argvus projects`

Il modulo **Stato Aggiornamenti** ha il proprio gruppo tra Utility e rete/performance e mostra il numero di aggiornamenti dei pacchetti disponibili. Controlla i repository ufficiali all'avvio e ogni ora usando `checkupdates` (da `pacman-contrib`), senza aggiornare i pacchetti. **Controlla AUR** è disattivato per impostazione predefinita; quando abilitato, controlla con `paru` o `yay`. Il tooltip separa le fonti e segnala i fallimenti; `?` significa che il totale è incompleto. Clicca sul modulo per aprire gli aggiornamenti ufficiali in Pacchetti. Configura entrambe le opzioni sotto **Icone → Moduli opzionali** e applica la bozza della barra delle applicazioni. Il modulo è abilitato per impostazione predefinita.

Al termine delle operazioni sui pacchetti nel Control Center (inclusi gli aggiornamenti ufficiali e AUR), la barra delle applicazioni controlla automaticamente gli aggiornamenti rimanenti senza riavviarsi. Il controllo avviene anche dopo un errore, poiché alcuni pacchetti potrebbero essere già cambiati. Il controllo orario resta attivo e rileva le operazioni esterne al Control Center.

### Navigazione per monitor

Successivo/precedente scorre solo gli spazi esistenti del monitor attivo: prima numerici, poi nomi e progetti ordinati per nome nativo, tornando all’inizio. Lo scorrimento sulla barra usa il monitor sotto il puntatore. Gli spazi speciali sono esclusi e sospendono il ciclo quando aperti. Le scorciatoie numeriche mantengono gli ID globali. Le assegnazioni restano in `/displays/workspaces`.

`argvus config workspace-cycle next|previous [--monitor focused|cursor]`

**Power → ARGVUS Lifecycle** (`argvus-lifecycle`)

Gli Appunti sono attivi per impostazione predefinita e si aprono dal gruppo delle utilità della barra delle applicazioni. Per interrompere la registrazione di testo e immagini, deseleziona la voce in Control Center → Appearance → Taskbar → Icons → Optional modules e scegli Apply. L’icona scompare e la cronologia resta inaccessibile fino alla riattivazione. Le voci salvate vengono conservate.

La riproduzione nel browser appare solo se il lettore identifica Spotify come sorgente. I suggerimenti hanno uno sfondo senza bordo.

Se il controllo fallisce, la barra riprova dopo 30 secondi.

Fai clic sull’icona degli appunti o degli agenti IA per aprire il pannello. Fai clic di nuovo sulla stessa icona per chiuderlo.
