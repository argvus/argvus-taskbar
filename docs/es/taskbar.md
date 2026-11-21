---
title: Barra de tareas
description: Usa la barra de tareas ARGVUS Quickshell.
---

La barra de tareas y la telemetría son superficies independientes del proceso Quickshell que administra `argvus-bars.service`. Usa `argvus-taskbar.service` y `argvus-widget-telemetry.service` para controlar cada superficie.

Se comunica con los espacios de trabajo, el estado de la ventana enfocada, el reloj y el acceso al calendario, la red, Bluetooth, audio/medios, notificaciones, almacenamiento, grabación, acciones de mantención de actividad y de energía/sesión. Los módulos de estado exactos pueden verse afectados por los proveedores instalados y el hardware.

El ícono más a la izquierda abre `argvus launcher`. Está deshabilitado por defecto. Cuando se habilita, sigue el tema activo: la construcción del tema lo representa en el color de resaltado del tema (`taskbar/menu.svg`, de la plantilla `taskbar-menu` de este paquete), mientras que los temas integrados ARGVUS Dark/ARGVUS Light usan `menu-default-dark.svg`/`menu-default-light.svg` (ambos proporcionados por `argvus-branding`). Usa **Centro de Control → Apariencia → Barra de tareas → Iconos → Lanzador** para habilitar/deshabilitarlo o para seleccionar una imagen de ícono personalizada, la cual sobrescribe el ícono del tema.

La barra de tareas no es el Panel de Control. La barra comunica el estado y la información persistente del escritorio; el Panel de Control es una superficie de acción rápida expandible. Los pop-ups de calendario y de dispositivos extraíbles son aplicaciones/superficies complementarias, no barras de tareas separadas.

Hacer clic en **Memoria** o **CPU** abre `btop` dentro del panel del monitor temático ARGVUS, con un encabezado `ARGVUS` y un pie de página `Esc Close`. La pestaña inferior Kitty muestra la pista localizada `Press q to close`. Presione `q` o `Esc` para cerrar. El módulo de temperatura de la CPU abre la vista general en vivo `argvus sensors`, agrupada por chip. El módulo de temperatura de la GPU aparece cuando hay una GPU compatible y `btop` disponible; muestra la temperatura máxima atribuible a la GPU o `N/A`, y al hacer clic en él se abren paneles de btop solo de GPU en el mismo marco temático. btop admite hasta seis cajas de GPU. Las métricas de NVIDIA necesitan su soporte de GPU y NVML, las métricas de AMD necesitan ROCm SMI, y las métricas de Intel necesitan interfaces sysfs legibles. La temperatura de la GPU solo se muestra cuando el sistema expone una lectura vinculada a ese dispositivo; la temperatura de Intel no está disponible en btop 1.4.7. Cuando btop no puede mostrar una caja de GPU debido a que no hay soporte o un proveedor disponible faltante, el panel ARGVUS informa que las métricas no están disponibles. ARGVUS no cambia los permisos del sistema.

## Posición y espacio

La posición predeterminada es el borde superior en modo dock. El Centro de Control expone la posición de la barra de tareas y los márgenes de la barra de tareas/shell en **Apariencia → Barra de tareas → Posición** y **Espacios**, y el grupo de utilidades en **Apariencia → Barra de tareas → Iconos**. El estado del diseño almacena márgenes independientes superior, izquierdo, derecho e inferior. El modo pegajoso establece por defecto el margen inferior en `2` y mantiene la barra cerca del borde; el modo espaciado usa un margen de shell predeterminado de `18` unidades.

El margen de la barra de tareas, el espacio exterior de la ventana y la geometría del panel están relacionados pero son distintos. Cambiar uno no reescribe cada otro valor. Si una barra aparece visualmente separada de las ventanas, revise juntos el modo, los márgenes de la barra de tareas y el espaciado de las ventanas; vea [Windows and layout](/docs/argvus-hyprland/windows-and-layout/).

El control de posición de la barra de tareas actualmente selecciona **Arriba** o **Abajo**. Los cuatro márgenes independientes controlan qué tan lejos se encuentra la barra de cada borde de la pantalla. El grupo de utilidades puede usar el comportamiento **Automático** o **Siempre expandido**. La disponibilidad del módulo aún depende del proveedor instalado y del hardware, por lo que un indicador de Bluetooth, brillo o almacenamiento que falte no se crea cambiando el espaciado de la barra.

**Altura** establece la altura de la barra en 24 (el predeterminado), 28, 32 o 36 píxeles. **Borde** activa o desactiva el borde de la barra de tareas y establece su grosor en 1, 2 o 3 píxeles. El grosor se aplica a la ventana de la barra de tareas, a los grupos `right-0`, `right-1`, `focus` y `right-2`, y al borde del reproductor MPRIS. El espacio de trabajo activo se muestra en colores invertidos sobre un fondo rectangular. Las ayudas emergentes usan los colores y la tipografía del tema activo. Con el borde desactivado, esos bordes se registran como `0px`. Ambos son borradores en **Centro de control → Apariencia → Barra de tareas** hasta que se seleccione **[ Aplicar ]**.**Centro de control → Apariencia → Barra de tareas → Iconos → Módulos opcionales** controla la visibilidad de los módulos de estado y acción opcionales. Espacios de trabajo, el título de la ventana enfocada, Configuración y Energía permanecen disponibles. **Presentación del espacio de trabajo** selecciona etiquetas de espacio de trabajo (por defecto) o iconos de aplicaciones. Los reproductores MPRIS muestran detalles de la pista en sus descripciones; el reproductor ya no utiliza un pulso continuo de color.

## Transparencia y desenfoque

Usa **Centro de control → Apariencia → Barra de tareas** para configurar los Iconos de utilidades, Transparencia y Desenfoque. Transparencia y Desenfoque tienen cada uno un interruptor de activación y un valor `0–100%`. Cambia los valores con `+` y `-` en pasos del 5 %; los cambios son borradores hasta que se seleccione **[ Aplicar ]**. Los temas nuevos tienen por defecto ambos efectos activados en `50%`.
Usa `↑/↓` para moverte entre las filas de habilitar y valor. Presiona `Tab` para **Acciones**, luego activa **[ Aplicar ]**.

## Configuración y reemplazos

`argvus config`: `/layout/taskbar`, `/taskbar`, `/fonts/targets/taskbar`.

`$XDG_RUNTIME_DIR/argvus/bars/presentation.json` ← `argvus sessionctl bars-presentation`.

## Ventanas y paneles

La barra de tareas es una superficie del shell junto con el Panel de control y el widget de telemetría opcional. Hyprland organiza las ventanas según el estado de diseño activo, mientras que estas superficies tienen sus propios anclajes y márgenes. `SUPER + SHIFT + Space` cambia la ventana enfocada entre los diseños en mosaico y flotante.

## Reloj y enfoque

El módulo de tiempo (`clock#time`) abre u oculta el popup del Reloj ARGVUS y pasa sus coordenadas raíz de clic para que pueda alinearse con la barra de tareas y el monitor en los que se hizo clic. El indicador de Enfoque tiene su propio grupo `focus` entre el grupo de red/rendimiento (`right-1`) y fecha/hora (`right-0`). Ejecuta `argvus focus status --waybar --follow` sin cargar GTK: mientras está inactivo, muestra el ícono del temporizador, y durante una fase de enfoque o descanso agrega el tiempo restante de `MM:SS`; su color identifica la fase y el estado de pausa. Hacer clic en él abre u oculta el popup de Enfoque en esa posición de clic. Ambos popups también se cierran con **Esc** o un clic fuera de ellos.

## Recarga

El servicio principal es `argvus-taskbar.service`. Cuando un cambio de configuración documentado requiere una recarga manual, use el controlador de sesión:

```sh
argvus sessionctl restart waybar
```
Los pop-ups del calendario y del almacenamiento extraíble usan el contrato inmutable de coordenadas raíz proporcionado por la compilación ARGVUS Quickshell para identificar el monitor. El calendario sigue la superficie horizontal real de la barra de tareas: se abre 4 píxeles debajo de una barra superior o 4 píxeles por encima de una barra inferior, independientemente de dónde se haya hecho clic dentro del módulo de fecha; el módulo de fecha abre el calendario. No edite la configuración de tiempo de ejecución generada para hacer cambios persistentes; use el Centro de Control o la ruta documentada.

Las utilidades se colapsan a un expansor en modo hover y revelan los controles habilitados al entrar el puntero. La visibilidad de la bandeja del sistema controla los íconos de aplicaciones en segundo plano; una bandeja vacía no tiene íconos visibles. La presentación de íconos del espacio de trabajo muestra íconos de aplicaciones de ventanas abiertas junto a las etiquetas de los espacios de trabajo.  

## Espacios de trabajo del proyecto

Los proyectos abiertos aparecen como botones ordinarios del espacio de trabajo, etiquetados `Project: name`; al hacer clic en uno se enfoca. Pasar el ratón muestra la ruta completa del proyecto y el atajo `SUPER + ALT + N`. Solo se muestran los espacios de trabajo abiertos en el monitor de la barra; el selector (`SUPER + O`) sigue siendo el catálogo completo de proyectos. Los espacios de trabajo especiales mantienen su política de visibilidad existente.

`$XDG_RUNTIME_DIR/argvus/project-workspaces.json` · `argvus projects`

El módulo **Estado de Actualización** tiene su propio grupo entre Utilidades y red/rendimiento y muestra el número de actualizaciones de paquetes disponibles. Verifica los repositorios oficiales al inicio y cada hora usando `checkupdates` (de `pacman-contrib`), sin actualizar paquetes. **Comprobar AUR** está desactivado por defecto; cuando se habilita, verifica con `paru` o `yay`. La información sobre herramientas separa las fuentes y reporta fallos; `?` significa que el total está incompleto. Haga clic en el módulo para abrir las actualizaciones oficiales en Paquetes. Configure ambas opciones en **Iconos → Módulos opcionales** y aplique el borrador de la barra de tareas. El módulo está habilitado por defecto.

Al terminar una operación de paquetes en Control Center (incluidas las actualizaciones oficiales y AUR), la barra de tareas comprueba automáticamente las actualizaciones restantes sin reiniciarse. También lo hace tras un fallo, pues algunos paquetes pueden haber cambiado. La comprobación horaria sigue activa y detecta las operaciones realizadas fuera de Control Center.

### Navegación por monitor

Siguiente/anterior recorre solo los espacios existentes del monitor enfocado: primero numéricos, después nombres y proyectos por nombre nativo, volviendo al inicio. La rueda sobre la barra usa el monitor bajo el puntero. Los espacios especiales se excluyen y detienen el ciclo mientras están abiertos. Los atajos numéricos conservan IDs globales. Las asignaciones siguen en `/displays/workspaces`.

`argvus config workspace-cycle next|previous [--monitor focused|cursor]`

**Power → ARGVUS Lifecycle** (`argvus-lifecycle`)

El Portapapeles está activado por defecto y se abre desde el grupo de utilidades de la barra de tareas. Para dejar de registrar texto e imágenes, desmarca la opción en Control Center → Appearance → Taskbar → Icons → Optional modules y selecciona Apply. El icono se oculta y el historial queda bloqueado hasta reactivar la opción. Se conservan las entradas guardadas.

La reproducción del navegador aparece solo cuando el reproductor identifica Spotify como origen. Las ayudas emergentes tienen un fondo sin borde.
