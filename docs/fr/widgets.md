---
title: Widgets
description: Configurer des widgets de télémétrie système optionnels.
---
`argvus widget-telemetry` fournit une surface Quickshell auxiliaire optionnelle pour les informations système. Ses blocs actuels sont **Système**, **CPU/GPU**, **Mémoire**, **Stockage**, **Processus**, **Réseau** et **Raccourcis**. Le bloc Raccourcis est stocké avec la clé `keys` dans le fichier d'état.

Utilisez **Centre de contrôle → Apparence → Télémétrie des widgets** pour activer la surface et activer ou désactiver les blocs individuellement. La désactivation d'un bloc masque ce module de télémétrie dans le profil Quickshell ; cela n’a pas pour effet de désinstaller un paquet ou d’arrêter le reste de la session. L'interrupteur principal contrôle la surface de télémétrie dans son ensemble.

La barre des tâches et la télémétrie sont des surfaces indépendantes du processus Quickshell géré par `argvus-bars.service`. Utilisez `argvus-taskbar.service` et `argvus-widget-telemetry.service` pour contrôler chaque surface.

`/effects/widget_telemetry_enabled` · `widget-telemetry-blocks`

Le contrôleur prend en charge :

`argvus widget-telemetry toggle blocks set <block> <enabled|disabled>` · `argvus widget-telemetry toggle apply-state`

Le service est `argvus-widget-telemetry.service` et est géré par `argvus-session`. Il n'y a pas de bouton de réinitialisation séparé par bloc dans la page actuelle : activez de nouveau le bloc, ou utilisez la gestion d'état prise en charge par le fournisseur, au lieu de modifier la sortie Quickshell générée.

## Transparence et flou

Utilisez **Centre de contrôle → Apparence → Télémétrie des widgets** pour configurer l'interrupteur principal, les sessions de télémétrie, la transparence et le flou. Les deux effets disposent d'interrupteurs d'activation indépendants et de valeurs `0–100%`. Utilisez `+` et `-` par étapes de 5 % et sélectionnez **[ Appliquer ]** ; les valeurs ne sont appliquées qu'après confirmation et sont enregistrées pour le thème actif. Utilisez `↑/↓` pour passer entre les lignes d'activation et de valeur. Appuyez sur `Tab` pour **Actions**, puis activez **[ Appliquer ]**.

Le module de température GPU est affiché lorsque DRM/sysfs expose un GPU NVIDIA, AMD ou Intel pris en charge et que `btop` est installé. Sa valeur est la température valide la plus élevée pouvant être attribuée à l'un des GPU détectés ; lorsqu'aucun capteur n'est exposé, il affiche `N/A`. En cliquant dessus, il ouvre les panneaux btop uniquement pour GPU dans Kitty via `argvus tui-terminal` en utilisant le profil `taskbar-monitor`. Appuyez sur `q` ou `Esc` pour fermer ; l'onglet inférieur localisé affiche `Press q to close`. btop 1.4.7 prend en charge jusqu'à six boîtes GPU. Les métriques NVIDIA nécessitent le support GPU de btop et NVML ; AMD nécessite le support GPU de btop et ROCm SMI ; Intel nécessite des interfaces sysfs lisibles. Les températures NVIDIA nouveau, AMD et Intel apparaissent uniquement lorsqu'un capteur hwmon lié est exposé. ARGVUS ne modifie pas les permissions et n'ajoute pas d'aides privilégiés. Le paquet de la barre des tâches dépend de btop ; les fournisseurs du fabricant restent optionnels.


L'icône optionnelle des agents IA dans group/right-2 ouvre le menu argvus-ai. Elle est vérifiée toutes les cinq secondes et cachée lorsque l'assistant est absent ou qu'aucun agent n'est disponible (argvus-ai status --check). Claude est proposé comme installable lorsque mise est présent. La sélectionner ouvre le terminal ARGVUS, l'installe dans le profil utilisateur actuel si manquant, puis le lance avec son répertoire binaire dans le PATH du processus. Aucun hook d'installation de package n'est utilisé. Rechargez la barre pour charger la configuration système mise à jour ; les copies utilisateurs ne sont pas écrasées.

Le lanceur IA utilise nf-md-robot (U+F06A9) avec Symbols Nerd Font Mono. Le projecteur d'apparence le conserve dans group/right-2 aux côtés du microphone et des contrôles audio.

## Sélecteur de mode fenêtre

L'icône de la fenêtre dans `group/right-2`, après l'extension de l'utilitaire, ouvre une fenêtre contextuelle GTK avec **Fenêtres en Mosaïque (Par défaut)** et **Fenêtres Flottantes**. La préférence actuelle est indiquée. Sélectionnez une option pour l'appliquer immédiatement ; Échap ou un clic à l'extérieur ferme la fenêtre contextuelle. L'icône reflète le mode effectif, avec un style en attente/erreur lorsque l'application n'a pas terminé. La fenêtre contextuelle suit la position de la barre des tâches et le thème actuel.

Le réglage est partagé avec **Centre de Contrôle → Bureau & Entrée → Hyprland → Fenêtres → Mode**. Flotter affecte toutes les fenêtres des applications sur tous les moniteurs et espaces de travail. Revenir à Mosaïque préserve les fenêtres qui étaient à l'origine flottantes. La sélection persiste entre les connexions.

`argvus window-mode-menu` · `argvus window-mode-menu --status`

## Boutons de fenêtre et barre des applications

Le mode flottant ajoute une barre de titre ARGVUS avec **Réduire**, **Agrandir / Restaurer** et **Fermer** aux fenêtres d'application normales. Un double-clic sur la barre de titre bascule la maximisation. La décoration supplémentaire est masquée en mode Tuile et plein écran. Les applications qui dessinent leurs propres contrôles peuvent afficher les deux barres ; des contrôles ARGVUS uniformes sont intentionnels.

Une deuxième Quickshell apparaît sur chaque moniteur, du côté opposé à la barre des tâches principale. Elle liste uniquement les fenêtres de l’espace de travail actuel de ce moniteur, y compris ses fenêtres minimisées. Les onglets de groupe cachés ne créent pas d’entrées supplémentaires. Les entrées minimisées conservent leur association originale avec le moniteur/l’espace de travail. Cliquez sur une fenêtre inactive pour l’activer, sur une fenêtre active pour la minimiser, ou sur une fenêtre minimisée pour la restaurer ; son menu contextuel offre restaurer, minimiser, maximiser/restaurer et fermer. Les icônes d’applications inconnues sont remplacées par un symbole de fenêtre. Activer ou restaurer une entrée préserve la position du pointeur. La barre secondaire utilise le CSS principal effectif (couleurs, polices, bordure et arrondis), avec sa hauteur et des marges miroir sur le bord opposé.

`SUPER + Alt + Up` place la barre principale en haut et la barre de fenêtre en bas. `SUPER + Alt + Down` fait l'inverse. Répéter une direction laisse les positions inchangées. Le carrelage n'a que la barre principale. Revenir au carrelage restaure toutes les fenêtres minimisées avant de supprimer la barre de fenêtre, puis préserve la politique de carrelage/flottante originale.

La minimisation utilise l’espace de travail réservé `special:argvus-minimized`. N’utilisez pas cet espace de travail manuellement. Le processus `argvus windows service` enregistre l’identité, l’espace de travail/moniteur d’origine, la géométrie, l’état plein écran/maximisé et l’état d’épinglage dans un registre d’exécution spécifique à l’instance du compositeur sous `$XDG_RUNTIME_DIR/argvus`. Les enregistrements survivent à un redémarrage du service ou à un rechargement de configuration, mais ne traversent pas les sessions de compositeur. La fermeture d’une fenêtre supprime son enregistrement. Si un moniteur disparaît, la restauration utilise une sortie disponible. Une barre de récupération manquante ou défaillante empêche de nouvelles minimisations ; une restauration échouée conserve l’enregistrement et la barre de récupération.

La session possède `argvus-windows.service` et `argvus-window-bar.service`. Ce dernier garde son enfant Quickshell dormant dans Tile. Le plugin hyprbars est fourni par `argvus-hyprland`, construit pour l’ABI Hyprland 0.57.0 sur x86_64 ; il n’est pas compilé dans le répertoire personnel de l’utilisateur. Reconstruisez le plugin lors d’une mise à jour de l’ABI du compositeur.Commandes : `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all` et `minimize|restore|activate|maximize|close ADDRESS`. Les adresses des fenêtres proviennent de la liste. `position top --persist` stocke/projette la préférence sans redémarrer la barre principale. Les détails de configuration et d'erreurs d'exécution sont écrits dans le journal ; les échecs d'action visibles affichent également une notification traduite.

En **Espacé + Flottant**, les fenêtres respectent les marges extérieures et les zones réservées par les deux barres. Les limites incluent la bordure et le titre, qui se situe à l'intérieur de la même bordure de fenêtre. La maximisation via les contrôles ARGVUS remplit cette zone avec des marges ; la restauration récupère la géométrie précédente, y compris après le redémarrage d'un service. Le mode plein écran utilise toujours la sortie complète. Les fenêtres flottantes peuvent se chevaucher ; les marges internes du tiling ne les séparent pas.
