---
title: Widgets
description: Configure widgets opcionais de telemetria.
slug: pt/0.4.0/docs/user-guide/desktop/widgets
---

`argvus-widget-telemetry` fornece uma superfície Waybar auxiliar opcional para informações do sistema. Seus blocos atuais são **Sistema**, **CPU/GPU**, **Memória**, **Armazenamento**, **Processos**, **Rede** e **Atalhos**. O bloco de atalhos usa a chave `keys` no arquivo de estado.

Use **Control Center → Aparência → Widgets de telemetria** para ativar a superfície e ligar ou desligar blocos individuais. Desativar um bloco oculta esse módulo do perfil Waybar; não desinstala pacotes nem interrompe o restante da sessão. O switch principal controla toda a superfície de telemetria.

A seleção de blocos é canônica no `config.json`, em `control_panel.widget_telemetry_blocks`, e o controle geral é `control_panel.widget_telemetry_enabled`. O `argvus-config` projeta essa seleção no perfil Waybar `data/waybar/argvus-widget-telemetry.jsonc` descomentando ou comentando as linhas dentro dos blocos delimitados `ARGVUS_TELEMETRY_<BLOCO>_BEGIN`/`_END`, sem tocar no resto do arquivo. O arquivo legado `~/.local/state/argvus/widget-telemetry-blocks` ainda é lido como fallback de migração em instalações antigas, mas nunca é escrito. Observe que o perfil inteiro é substituído pelo default empacotado em uma mudança de aparência, então são os marcadores de bloco que preservam a seleção; texto fora deles não é preservado na troca de tema.

## Transparência e blur

Use **Control Center → Aparência → Widget Telemetry** para configurar o controle geral, as sessões de telemetria, Transparência e Blur. Os dois efeitos têm controles de ativação independentes e valores de `0–100%`. Use `+` e `-` em passos de 5% e selecione **\[ Aplicar ]**; os valores só são aplicados após a confirmação e ficam salvos para o tema ativo.
Use `↑/↓` para mover entre as linhas de ativação e valor. Pressione `Tab` para **Ações** e ative **\[ Aplicar ]**.

```sh
argvus-widget-telemetry-toggle status
argvus-widget-telemetry-toggle on
argvus-widget-telemetry-toggle off
argvus-widget-telemetry-toggle blocks status
argvus-widget-telemetry-toggle blocks set memory disabled
argvus-widget-telemetry-toggle blocks apply
```

O controlador também aceita `blocks set <block> <enabled|disabled>` para `system`, `cpu_gpu`, `memory`, `storage`, `processes`, `network` e `keys`. As preferências são persistentes; quando um bloco não possui preferência explícita, segue o padrão habilitado. `blocks set` reescreve o array canônico em um único patch atômico e então reprojeta o perfil Waybar e reconcilia o ciclo de vida do serviço. `apply-state` é o caminho do Control Center: ele pressupõe que quem chamou já persistiu a seleção e apenas a projeta, portanto nunca chame com um estado não persistido.

O serviço é `argvus-widget-telemetry.service` e é gerenciado pelo `argvus-session`. A página atual não possui um botão separado de restauração por bloco: habilite o bloco novamente ou use o gerenciamento de estado suportado pelo provider, em vez de editar a saída Waybar gerada.
