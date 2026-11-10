---
title: Widgets
description: Configurar widgets opcionales de telemetría del sistema.
---
`argvus widget-telemetry` proporciona una superficie auxiliar opcional de Waybar para información del sistema. Sus bloques actuales son **Sistema**, **CPU/GPU**, **Memoria**, **Almacenamiento**, **Procesos**, **Red** y **Accesos directos**. El bloque de Accesos directos se guarda con la clave `keys` en el archivo de estado.

Use **Centro de Control → Apariencia → Telemetría de Widgets** para habilitar la superficie y activar o desactivar bloques individuales. Deshabilitar un bloque oculta ese módulo de telemetría del perfil de Waybar; no desinstala un paquete ni detiene el resto de la sesión. El interruptor principal controla la superficie de telemetría en su conjunto.

La selección de bloque es canónica en `config.json`, en `control_panel.widget_telemetry_blocks`, y el interruptor principal es `control_panel.widget_telemetry_enabled`. `argvus-config` proyecta esa selección en el perfil de Waybar `data/waybar/argvus-widget-telemetry.jsonc` descomentando o comentando las líneas dentro de sus bloques delimitados `ARGVUS_TELEMETRY_<BLOCK>_BEGIN`/`_END`, dejando intacto el resto del archivo. Un archivo legado `~/.local/state/argvus/widget-telemetry-blocks` todavía se lee como una alternativa de migración en instalaciones antiguas, pero nunca se escribe. Tenga en cuenta que todo el perfil se reemplaza con el predeterminado empaquetado al cambiar la apariencia, por lo que los marcadores de bloque son la forma en que la selección se conserva; el texto fuera de ellos no se conserva al cambiar de tema.

El controlador admite:

```sh
argvus widget-telemetry-toggle status
argvus widget-telemetry-toggle on
argvus widget-telemetry-toggle off
argvus widget-telemetry-toggle blocks status
argvus widget-telemetry-toggle blocks set memory disabled
argvus widget-telemetry-toggle blocks apply
```
El controlador también acepta `blocks set <block> <enabled|disabled>` para `system`, `cpu_gpu`, `memory`, `storage`, `processes`, `network` y `keys`. Las preferencias son persistentes; cuando un bloque no tiene una preferencia explícita, sigue el valor predeterminado habilitado. `blocks set` reescribe la matriz canónica en un solo parche atómico, luego reproyecta el perfil de Waybar y reconcilia el ciclo de vida del servicio. `apply-state` es la ruta del Centro de Control: asume que el llamador ya persistió la selección y solo la proyecta, por lo que nunca se llame con un estado no persistido.

El servicio es `argvus-widget-telemetry.service` y es gestionado por `argvus-session`. No hay un botón de reinicio separado por bloque en la página actual: habilite nuevamente el bloque, o use la gestión de estado soportada por el proveedor, en lugar de editar la salida generada de Waybar.

## Transparencia y desenfoque

Utilice **Centro de Control → Apariencia → Telemetría de Widget** para configurar el interruptor principal, las sesiones de telemetría, la Transparencia y el Desenfoque. Ambos efectos tienen interruptores de activación independientes y valores `0–100%`. Utilice `+` y `-` en pasos del 5% y seleccione **[ Aplicar ]**; los valores se aplican solo después de la confirmación y se almacenan para el tema activo. Utilice `↑/↓` para moverse entre las filas de activación y de valor. Presione `Tab` para **Acciones**, luego active **[ Aplicar ]**.

El módulo de temperatura de la GPU se muestra cuando DRM/sysfs detecta una GPU NVIDIA, AMD o Intel compatible y `btop` está instalado. Su valor es la temperatura válida más alta que se puede atribuir a una de las GPUs detectadas; cuando no se expone ningún sensor, muestra `N/A`. Hacer clic en él abre los paneles solo de GPU de btop en Kitty a través de `argvus tui-terminal` usando el perfil `taskbar-monitor`. Presione `q` o `Esc` para cerrar; la pestaña inferior localizada dice `Press q to close`. btop 1.4.7 admite hasta seis cajas de GPU. Las métricas de NVIDIA requieren soporte de GPU en btop y NVML; AMD requiere soporte de GPU en btop y ROCm SMI; Intel requiere interfaces sysfs legibles. Las temperaturas de NVIDIA nouveau, AMD e Intel aparecen solo cuando se expone un sensor hwmon vinculado. ARGVUS no altera permisos ni agrega ayudantes privilegiados. El paquete de la barra de tareas depende de btop; los proveedores del fabricante siguen siendo opcionales.


El icono opcional de agentes de IA en grupo/derecha-2 abre el menú argvus-ai. Se verifica cada cinco segundos y se oculta cuando el asistente no está presente o no hay agentes disponibles (argvus-ai status --check). Claude se ofrece como instalable cuando mise está presente. Seleccionarlo abre la terminal ARGVUS, lo instala en el perfil de usuario actual si falta, y luego lo lanza con su directorio binario en el PATH del proceso. No se utiliza ningún hook de instalación de paquetes. Recarga la barra para cargar la configuración del sistema actualizada; las copias del usuario no se sobrescriben.

El lanzador de IA usa nf-md-robot (U+F06A9) con Symbols Nerd Font Mono. El proyector de apariencia lo mantiene en grupo/derecha-2 junto al micrófono y los controles de audio.

## Selector de modo de ventana

El ícono de ventana en `group/right-2`, después del expansor de utilidades, abre un popup GTK con **Ventanas en Mosaico (Predeterminado)** y **Ventanas Flotantes**. La preferencia actual está marcada. Selecciona una opción para aplicarla inmediatamente; Escape o hacer clic fuera del popup lo cierra. El ícono refleja el modo efectivo, con un estilo de pendiente/error cuando la aplicación no ha terminado. El popup sigue la posición de la barra de tareas y el tema actual.

La configuración se comparte con **Centro de Control → Escritorio y Entrada → Hyprland → Ventanas → Modo**. Flotar afecta a todas las ventanas de la aplicación en todos los monitores y espacios de trabajo. Volver a Mosaico conserva las ventanas que eran originalmente flotantes. La selección persiste entre sesiones.

El asistente es `argvus window-mode-menu`; `argvus window-mode-menu --status` emite JSON de Waybar. Es enviado por el paquete maestro `argvus`. Se conservan las copias de la barra de tareas personalizadas existentes: agregue la definición del módulo `custom/window-mode` y la entrada de grupo desde la plantilla empaquetada para optar, o use el Centro de Control. El proyector de apariencia conserva el módulo cuando su definición está presente, incluso si otros íconos de utilidades están deshabilitados.

## Botones de ventana y barra de aplicaciones

El modo flotante agrega una barra de título ARGVUS con **Minimizar**, **Maximizar / Restaurar** y **Cerrar** a las ventanas de aplicaciones normales. Al hacer doble clic en la barra de título se alterna la maximización. La decoración adicional se oculta en Mosaico y pantalla completa. Las aplicaciones que dibujan sus propios controles pueden mostrar ambas barras; los controles uniformes de ARGVUS son intencionales.

Una segunda Waybar aparece en cada monitor, en el borde opuesto a la barra de tareas principal. Solo lista las ventanas del espacio de trabajo actual de ese monitor, incluyendo sus ventanas minimizadas. Las pestañas de grupo ocultas no crean entradas adicionales. Las entradas minimizadas mantienen su asociación original con el monitor/espacio de trabajo. Haz clic en una ventana inactiva para activarla, en una ventana activa para minimizarla, o en una ventana minimizada para restaurarla; su menú contextual ofrece restaurar, minimizar, maximizar/restaurar y cerrar. Los íconos de aplicaciones desconocidas se sustituyen por un símbolo de ventana. Activar o restaurar una entrada preserva la posición del puntero. La barra secundaria utiliza el CSS primario efectivo (colores, fuentes, bordes y redondeo), con su altura y márgenes reflejados en el borde opuesto.

`SUPER + Alt + Up` coloca la barra principal en la parte superior y la barra de ventana en la parte inferior. `SUPER + Alt + Down` hace lo contrario. Repetir una dirección deja las posiciones sin cambios. Tile solo tiene la barra principal. Volver a Tile restaura todas las ventanas minimizadas antes de quitar la barra de ventana y luego preserva la política original de mosaico/flotante.

La minimización utiliza el espacio de trabajo reservado `special:argvus-minimized`. No use ese espacio de trabajo manualmente. El proceso `argvus windows service` registra la identidad, el espacio de trabajo/monitor original, la geometría, el estado de pantalla completa/maximización y el estado de fijación en un registro de tiempo de ejecución específico de la instancia del compositor bajo `$XDG_RUNTIME_DIR/argvus`. Los registros sobreviven a un reinicio del servicio o recarga de configuración, pero no cruzan sesiones del compositor. Cerrar una ventana elimina su registro. Si un monitor desaparece, la restauración utiliza una salida disponible. Una barra de recuperación faltante o con fallo evita nuevas minimizaciones; la restauración fallida conserva el registro y la barra de recuperación.

La sesión posee `argvus-windows.service` y `argvus-window-bar.service`. Esta última mantiene su hijo de Waybar inactivo en Tile. El plugin hyprbars se incluye con `argvus-hyprland`, construido para la ABI de Hyprland 0.57.0 en x86_64; no se compila en el directorio personal del usuario. Reconstruya el plugin con una actualización de ABI del compositor.
Comandos: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all` y `minimize|restore|activate|maximize|close ADDRESS`. Las direcciones de las ventanas provienen de la lista. `position top --persist` almacena/proyecta la preferencia sin reiniciar la barra principal. Los detalles de errores de configuración y de ejecución se escriben en el diario; las fallas visibles de acción también muestran una notificación traducida.

En **Espaciado + Flotante**, las ventanas respetan los huecos exteriores y las áreas reservadas por ambas barras. Los límites incluyen el borde y el título, que se encuentra dentro del mismo borde de la ventana. Maximizar a través de los controles ARGVUS llena esta área con márgenes; restaurar recupera la geometría anterior, incluso después de reiniciar un servicio. Pantalla completa aún usa toda la salida. Las ventanas flotantes pueden superponerse; los huecos internos en mosaico no las separan.
