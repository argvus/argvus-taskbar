---
title: Widgets
description: Configure widgets opcionais de telemetria.
---

`argvus widget-telemetry` fornece uma superfície Waybar auxiliar opcional para informações do sistema. Seus blocos atuais são **Sistema**, **CPU/GPU**, **Memória**, **Armazenamento**, **Processos**, **Rede** e **Atalhos**. O bloco de atalhos usa a chave `keys` no arquivo de estado.

Use **Control Center → Aparência → Widgets de telemetria** para ativar a superfície e ligar ou desligar blocos individuais. Desativar um bloco oculta esse módulo do perfil Waybar; não desinstala pacotes nem interrompe o restante da sessão. O switch principal controla toda a superfície de telemetria.

A seleção de blocos é canônica no `config.json`, em `control_panel.widget_telemetry_blocks`, e o controle geral é `control_panel.widget_telemetry_enabled`. O `argvus-config` projeta essa seleção no perfil Waybar `data/waybar/argvus-widget-telemetry.jsonc` descomentando ou comentando as linhas dentro dos blocos delimitados `ARGVUS_TELEMETRY_<BLOCO>_BEGIN`/`_END`, sem tocar no resto do arquivo. O arquivo legado `~/.local/state/argvus/widget-telemetry-blocks` ainda é lido como fallback de migração em instalações antigas, mas nunca é escrito. Observe que o perfil inteiro é substituído pelo default empacotado em uma mudança de aparência, então são os marcadores de bloco que preservam a seleção; texto fora deles não é preservado na troca de tema.

## Transparência e blur

Use **Control Center → Aparência → Widget Telemetry** para configurar o controle geral, as sessões de telemetria, Transparência e Blur. Os dois efeitos têm controles de ativação independentes e valores de `0–100%`. Use `+` e `-` em passos de 5% e selecione **\[ Aplicar ]**; os valores só são aplicados após a confirmação e ficam salvos para o tema ativo.
Use `↑/↓` para mover entre as linhas de ativação e valor. Pressione `Tab` para **Ações** e ative **\[ Aplicar ]**.

O módulo de temperatura da GPU aparece quando DRM/sysfs expõe uma GPU NVIDIA, AMD ou Intel suportada e o `btop` está instalado. O valor é a maior temperatura válida atribuível a uma das GPUs detectadas; sem sensor exposto, aparece `Indisponível`. Clicar abre os painéis GPU-only do btop no Kitty por `argvus tui-terminal`, usando o perfil `taskbar-monitor`. Pressione `q` ou `Esc` para fechar; a aba inferior localizada mostra `Pressione q para fechar`. O btop 1.4.7 suporta até seis caixas de GPU. Métricas NVIDIA exigem suporte a GPU no btop e NVML; AMD exige suporte a GPU e ROCm SMI; Intel exige interfaces sysfs legíveis. Temperaturas de NVIDIA nouveau, AMD e Intel aparecem somente quando há sensor hwmon vinculado ao dispositivo. O ARGVUS não altera permissões nem adiciona helpers privilegiados. O pacote taskbar depende do btop; providers de fabricante continuam opcionais.

```sh
argvus widget-telemetry-toggle status
argvus widget-telemetry-toggle on
argvus widget-telemetry-toggle off
argvus widget-telemetry-toggle blocks status
argvus widget-telemetry-toggle blocks set memory disabled
argvus widget-telemetry-toggle blocks apply
```

O controlador também aceita `blocks set <block> <enabled|disabled>` para `system`, `cpu_gpu`, `memory`, `storage`, `processes`, `network` e `keys`. As preferências são persistentes; quando um bloco não possui preferência explícita, segue o padrão habilitado. `blocks set` reescreve o array canônico em um único patch atômico e então reprojeta o perfil Waybar e reconcilia o ciclo de vida do serviço. `apply-state` é o caminho do Control Center: ele pressupõe que quem chamou já persistiu a seleção e apenas a projeta, portanto nunca chame com um estado não persistido.

O serviço é `argvus-widget-telemetry.service` e é gerenciado pelo `argvus-session`. A página atual não possui um botão separado de restauração por bloco: habilite o bloco novamente ou use o gerenciamento de estado suportado pelo provider, em vez de editar a saída Waybar gerada.


O ícone opcional de agentes de IA em group/right-2 abre argvus-ai menu. A presença do helper é verificada a cada cinco segundos; sem ele ou sem agentes disponíveis, o ícone é ocultado (argvus-ai status --check). O Claude é oferecido para instalação quando o mise está presente. Selecioná-lo abre o terminal ARGVUS, instala-o no perfil do usuário atual se necessário e o inicia com o diretório do binário no PATH do processo. Não há hook de instalação do pacote. Recarregue a barra para carregar a configuração atualizada; cópias do usuário não são sobrescritas.


O lançador de IA usa nf-md-robot (U+F06A9) com Symbols Nerd Font Mono. O projetor de aparência o preserva em group/right-2, junto dos controles de microfone e áudio.

## Seletor de modo de janelas

O ícone de janelas em `group/right-2`, após o expansor de utilitários, abre um popup GTK com **Janelas em mosaico (padrão)** e **Janelas flutuantes**. A preferência atual aparece marcada. A seleção é aplicada imediatamente; Escape ou clique externo fecha o popup. O ícone reflete o modo efetivo, com estilo de pendência/erro quando a aplicação ainda não terminou. O popup acompanha a posição da barra e o tema atual.

A opção é compartilhada com **Control Center → Desktop e entrada → Hyprland → Janelas → Modo**. O modo flutuante afeta todas as janelas de aplicativos, em todos os monitores e workspaces. Voltar ao mosaico preserva as janelas que já eram flutuantes. A seleção persiste entre logins.

O helper é `argvus window-mode-menu`; `argvus window-mode-menu --status` emite JSON para Waybar. Ele é distribuído pelo pacote mestre `argvus`. Cópias personalizadas da taskbar são preservadas: para incluir o ícone, copie a definição do módulo `custom/window-mode` e sua entrada no grupo a partir do template do pacote, ou use o Control Center. O projetor de aparência preserva o módulo quando sua definição existe, mesmo com os demais ícones de utilitários desabilitados.

## Botões de janela e barra de aplicativos

O modo flutuante adiciona uma barra de título ARGVUS com **Minimizar**, **Maximizar / Restaurar** e **Fechar** às janelas normais de aplicativos. O clique duplo na barra alterna a maximização. A decoração adicional fica oculta em mosaico e tela cheia. Aplicativos que desenham seus próprios controles podem exibir as duas barras; os controles ARGVUS uniformes são intencionais.

Uma segunda Waybar aparece em cada monitor, na borda oposta à taskbar principal. Ela lista apenas as janelas do workspace atual daquele monitor, incluindo as minimizadas desse workspace. Abas ocultas de grupos não geram entradas extras. As minimizadas mantêm a associação ao monitor e workspace originais. Clique em uma janela sem foco para ativá-la, na janela ativa para minimizá-la ou em uma minimizada para restaurá-la; o menu de contexto oferece restaurar, minimizar, maximizar/restaurar e fechar. Ícones de aplicativos desconhecidos usam um símbolo de janela. A ativação e a restauração pela lista preservam a posição do ponteiro. A barra secundária usa o CSS efetivo da principal (cores, fontes, borda e arredondamento), com altura e margens espelhadas na borda oposta.

`SUPER + Alt + seta para cima` coloca a barra principal no topo e a barra de janelas no rodapé. `SUPER + Alt + seta para baixo` faz o inverso. Repetir a direção mantém as posições. Em mosaico existe apenas a barra principal. Voltar ao mosaico restaura todas as minimizadas antes de remover a barra de janelas e então preserva a política original de janelas tiled/flutuantes.

A minimização usa o workspace reservado `special:argvus-minimized`. Não use esse workspace manualmente. O processo `argvus windows service` registra identidade, workspace/monitor de origem, geometria, tela cheia/maximização e fixação em um registro de runtime separado por instância do compositor, em `$XDG_RUNTIME_DIR/argvus`. Os registros sobrevivem ao reinício do serviço ou reload da configuração, mas não atravessam sessões do compositor. Fechar uma janela remove seu registro. Se um monitor desaparecer, a restauração usa uma saída disponível. Uma barra de recuperação ausente ou com falha impede novas minimizações; falhas de restauração preservam o registro e a barra de recuperação.

A sessão gerencia `argvus-windows.service` e `argvus-window-bar.service`. O segundo mantém sua Waybar inativa em mosaico. O plugin hyprbars é distribuído por `argvus-hyprland`, compilado para a ABI do Hyprland 0.57.0 em x86_64; não é compilado no diretório pessoal do usuário. Recompile o plugin ao atualizar a ABI do compositor.

Comandos: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all` e `minimize|restore|activate|maximize|close ADDRESS`. Os endereços das janelas vêm da listagem. `position top --persist` salva/projeta a preferência sem reiniciar a barra principal. Detalhes de erros vão para o journal; falhas de ações visíveis também exibem uma notificação traduzida.

No modo **Spaced + Floating**, as janelas respeitam os espaços externos e as áreas reservadas pelas duas barras. O cálculo inclui a borda e o título, que fica dentro da mesma borda da janela. Maximizar pelos controles ARGVUS ocupa essa área com margens; restaurar recupera a geometria anterior, inclusive após reiniciar o serviço. Tela cheia continua usando o monitor inteiro. Janelas flutuantes podem se sobrepor; os espaços internos do mosaico não separam essas janelas.
