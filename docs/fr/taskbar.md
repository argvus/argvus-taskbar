---
title: Barre des tâches
description: Utilisez la barre de tâches ARGVUS Waybar.
---
La barre des tâches est la surface Waybar persistante sur le bureau. `argvus-taskbar` possède sa configuration ARGVUS et ses actions ; `argvus-waybar` fournit le binaire Waybar patché qui la rend. `argvus-session` possède le cycle de vie du service.

Elle communique les espaces de travail, l'état de la fenêtre focalisée, l'accès à l'horloge et au calendrier, le réseau, le Bluetooth, l'audio/média, les notifications, le stockage, l'enregistrement, les actions de maintien d'activité et d'alimentation/session. Les modules de statut exacts peuvent être affectés par les fournisseurs installés et le matériel.

L'icône la plus à gauche ouvre `argvus launcher`. Elle est désactivée par défaut. Lorsqu'elle est activée, elle suit le thème actif : la construction du thème l'affiche dans la couleur de surlignage du thème (`taskbar/menu.svg`, provenant du modèle `taskbar-menu` de ce package), tandis que les thèmes intégrés ARGVUS Dark/ARGVUS Light utilisent `menu-default-dark.svg`/`menu-default-light.svg` (les deux fournis par `argvus-branding`). Utilisez **Panneau de contrôle → Apparence → Barre des tâches → Icônes → Lancement** pour l'activer/désactiver ou pour choisir une image d'icône personnalisée, qui remplace l'icône du thème.

La barre des tâches n'est pas le Panneau de configuration. La barre communique l'état et le statut permanents du bureau ; le Panneau de configuration est une surface d'actions rapides extensible. Les popups de calendrier et de périphériques amovibles sont des applications/surfaces complémentaires, pas des barres des tâches séparées.

Cliquer sur **Mémoire** ou **CPU** ouvre `btop` à l'intérieur du panneau de surveillance ARGVUS thématique, avec un en-tête `ARGVUS` et un pied de page `Esc Close`. L'onglet Kitty en bas affiche l'indice localisé `Press q to close`. Appuyez sur `q` ou `Esc` pour fermer. Le module de température CPU ouvre la vue d'ensemble en direct `argvus sensors`, regroupée par puce. Le module de température GPU apparaît lorsqu'un GPU pris en charge et `btop` sont disponibles ; il montre la température GPU attribuable la plus élevée ou `N/A`, et cliquer dessus ouvre des panneaux btop uniquement GPU dans le même cadre thématique. btop prend en charge jusqu'à six boîtes GPU. Les métriques NVIDIA nécessitent son support GPU et NVML, les métriques AMD nécessitent ROCm SMI, et les métriques Intel nécessitent des interfaces sysfs lisibles. La température GPU n'est affichée que lorsque le système expose une lecture liée à cet appareil ; la température Intel n'est pas disponible depuis btop 1.4.7. Lorsque btop ne peut pas afficher une boîte GPU parce que le support ou un fournisseur manque, le panneau ARGVUS indique que les métriques sont indisponible. ARGVUS ne modifie pas les autorisations du système.

## Position et espacement

La position par défaut est le bord supérieur en mode dock. Le Centre de contrôle expose la position de la barre des tâches et les marges de la barre des tâches/du shell sous **Apparence → Barre des tâches → Position** et **Espaces**, ainsi que le groupe d'utilitaires sous **Apparence → Barre des tâches → Icônes**. L'état de la disposition enregistre des marges indépendantes en haut, à gauche, à droite et en bas. Le mode collant définit par défaut la marge inférieure à `2` et maintient la barre proche du bord ; le mode Espacé utilise une marge de shell par défaut de `18` unités.

La marge de la barre des tâches, l'écart externe de la fenêtre et la géométrie du panneau sont liés mais distincts. Modifier l'un ne réécrit pas toutes les autres valeurs. Si une barre semble visuellement détachée des fenêtres, vérifiez ensemble le mode, les marges de la barre des tâches et l'espacement des fenêtres ; voir [Fenêtres et disposition](/docs/argvus-hyprland/windows-and-layout/).

Le contrôle de la position de la barre des tâches sélectionne actuellement **Haut** ou **Bas**. Les quatre marges indépendantes contrôlent la distance de la barre par rapport à chaque bord de l'écran. Le groupe d'utilitaires peut utiliser le comportement **Automatique** ou **Toujours étendu**. La disponibilité des modules dépend encore du fournisseur et du matériel installés, donc un indicateur Bluetooth, de luminosité ou de stockage manquant n'est pas créé en changeant l'espacement de la barre.

**Hauteur** définit la hauteur de la barre à 24, 28 (par défaut), 32 ou 36 pixels. **Bordure** active ou désactive la bordure de la barre des tâches et définit son épaisseur à 1, 2 ou 3 pixels. L'épaisseur s'applique à la fenêtre de la barre des tâches, aux groupes `right-0`, `right-1`, `focus` et `right-2`, et à la bordure du lecteur MPRIS. Lorsque vous survolez les modules interactifs, y compris le lecteur, leur opacité diminue légèrement. Avec la bordure désactivée, ces bordures sont écrites comme `0px`. Les deux sont des brouillons dans **Centre de Contrôle → Apparence → Barre des tâches** jusqu'à ce que **[ Appliquer ]** soit sélectionné.

**Centre de contrôle → Apparence → Barre des tâches → Icônes → Modules optionnels** contrôle la visibilité des modules d'état et d'action optionnels. Les espaces de travail, le titre de la fenêtre active, les Paramètres et l'Alimentation restent disponibles. **Présentation des espaces de travail** sélectionne les étiquettes des espaces de travail (par défaut) ou les icônes d'application. Les lecteurs MPRIS affichent les détails du morceau dans leurs info-bulles ; le lecteur n'utilise plus un clignotement de couleur continu.

## Transparence et flou

Utilisez **Centre de contrôle → Apparence → Barre des tâches** pour configurer les Icônes utilitaires, la Transparence et le Flou. La transparence et le flou disposent chacun d'un interrupteur d'activation et d'une valeur `0–100%`. Changez les valeurs avec `+` et `-` par paliers de 5 % ; les modifications sont provisoires jusqu'à ce que **[ Appliquer ]** soit sélectionné. Les nouveaux thèmes ont par défaut les deux effets activés à `50%`.  
Utilisez `↑/↓` pour naviguer entre les lignes d'activation et de valeur. Appuyez sur `Tab` pour **Actions**, puis activez **[ Appliquer ]**.

## Configuration et remplacements

La configuration de la barre des tâches est détenue par `argvus-taskbar`, rendue par `argvus-waybar` et démarrée par `argvus-session`. `argvus-config` est le seul composant qui écrit les fichiers consommateurs de la barre des tâches : il projette la couche active sous `~/.config/argvus/data/generated/waybar/` et réapplique la couche de thème, les marges de la barre des tâches, le mode de groupe utilitaire `right-2`, le rayon de bordure et le bloc de polices chaque fois que les thèmes ou l'état de la disposition changent. Un changement de thème restaure également les fichiers de la barre des tâches emballés, puis réécrit la hauteur et la bordure choisies dans le Centre de Contrôle, qui sont stockées en tant que `/taskbar/shape/height` et `/taskbar/shape/border_width` dans `argvus config`. Jusqu'à ce qu'un soit choisi, il est `null` et suit le thème : 28 px de hauteur, avec une bordure de 1 px (Slate Dark n'en a pas). Parce que la copie générée est résolue en premier, un chemin Waybar natif sous `~/.config/waybar/` n'a effet que tant que le fichier généré correspondant est absent. Voir [Waybar et barre des tâches overrides](/docs/argvus-waybar/) pour la priorité, les exemples et le dépannage.

## Windows et panneaux

La barre des tâches est une surface de shell aux côtés du Panneau de configuration et du widget de télémétrie optionnel. Hyprland organise les fenêtres selon l'état de disposition actif, tandis que ces surfaces ont leurs propres ancres et marges. `SUPER + SHIFT + Space` bascule la fenêtre focalisée entre les dispositions en mosaïque et flottantes.

## Horloge et Focus

Le module de temps (`clock#time`) ouvre ou masque le popup ARGVUS Clock et transmet ses coordonnées de clic racine afin qu'il puisse s'aligner avec la barre des tâches et l'écran cliqués. L'indicateur de focus possède son propre groupe `focus` entre le groupe réseau/performance (`right-1`) et la date/heure (`right-0`). Il exécute `argvus focus status --waybar --follow` sans charger GTK : lorsqu'il est inactif, il affiche l'icône du minuteur, et pendant une phase de focus ou de pause, il ajoute le `MM:SS` restant ; sa couleur identifie la phase et l'état en pause. Un clic dessus ouvre ou masque le popup Focus à la position de ce clic. Les deux popups se ferment également avec **Échap** ou un clic à l'extérieur.

## Rechargement

Le service principal est `argvus-taskbar.service`. Lorsqu'un changement de configuration documenté nécessite un rechargement manuel, utilisez le contrôleur de session :

```sh
argvus sessionctl restart waybar
```
Les pop-ups du calendrier et du stockage amovible utilisent le contrat de coordonnées racine immuable fourni par la build ARGVUS de Waybar pour identifier le moniteur. Le calendrier suit la surface réelle horizontale de la barre des tâches : il s'ouvre 4 pixels en dessous d'une barre supérieure ou 4 pixels au-dessus d'une barre inférieure, quel que soit l'endroit dans le module de date où il a été cliqué ; le module de date ouvre le calendrier. Ne modifiez pas la configuration d'exécution générée pour effectuer des changements permanents ; utilisez le Centre de Contrôle ou le chemin de remplacement documenté [Waybar](/docs/argvus-waybar/).

Les utilitaires se replient en un expanseur en mode survol et révèlent les commandes activées à l'entrée du pointeur. La visibilité de la barre système contrôle les icônes des applications en arrière-plan ; un plateau vide n’a aucune icône visible. La présentation des icônes des espaces de travail affiche les icônes des applications pour les fenêtres ouvertes à côté des étiquettes des espaces de travail.

## Espaces de travail du projet

Les projets ouverts apparaissent comme des boutons ordinaires de l'espace de travail, étiquetés `Project: name` ; cliquer dessus le sélectionne. Le survol affiche le chemin complet du projet et le raccourci `SUPER + ALT + N`. Seuls les espaces de travail ouverts sur le moniteur de la barre sont affichés ; le sélecteur (`SUPER + O`) reste le catalogue complet des projets. Les espaces de travail spéciaux conservent leur politique de visibilité existante.

Le module `hyprland/workspaces` lit `workspace-metadata: "argvus/project-workspaces.json"`, relatif à `$XDG_RUNTIME_DIR`. `argvus projects` régénère ce fichier dérivé chaque fois qu’un projet s’ouvre. Le `argvus-waybar` patché prend en charge les adresses textuelles des espaces de travail de Hyprland 0.57 et utilise les métadonnées pour les étiquettes sans changer l’identité des espaces de travail. Mettez à jour les trois packages et reprojetez la configuration de la barre des tâches avant de redémarrer le service.

Le module **État des mises à jour** a son propre groupe entre Utilitaires et réseau/performance et affiche le nombre de mises à jour de paquets disponibles. Il vérifie les dépôts officiels au démarrage et toutes les heures à l'aide de `checkupdates` (depuis `pacman-contrib`), sans mettre à jour les paquets. **Vérifier AUR** est désactivé par défaut ; lorsqu'il est activé, il vérifie avec `paru` ou `yay`. L'infobulle sépare les sources et signale les échecs ; `?` signifie que le total est incomplet. Cliquez sur le module pour ouvrir les mises à jour officielles dans Paquets. Configurez les deux options sous **Icônes → Modules optionnels** et appliquez l'ébauche de la barre des tâches. Le module est activé par défaut.
