---
title: Taskbar
description: Use a taskbar Waybar do ARGVUS.
slug: pt/0.4.0/docs/user-guide/desktop/taskbar
---

A taskbar é a superfície Waybar persistente do desktop. `argvus-taskbar` possui sua configuração e ações do ARGVUS; `argvus-waybar` fornece o binário Waybar modificado que a renderiza. `argvus-session` possui o ciclo de vida do serviço.

Ela comunica workspaces, janela em foco, acesso ao relógio e calendário, rede, Bluetooth, áudio/mídia, notificações, armazenamento, gravação, manter acordado e ações de energia/sessão. Os módulos exatos podem depender dos providers instalados e do hardware.

A taskbar não é o Control Panel. A barra comunica o estado persistente do desktop e status; o Control Panel é uma superfície expansível de ações rápidas. Popups de calendário e dispositivos removíveis são superfícies complementares, não taskbars separadas.

## Transparência e blur

Use **Control Center → Aparência → Taskbar** para configurar Ícones de utilidade, Transparência e Blur. Transparência e Blur têm um controle de ativação e um valor de `0–100%`. Altere os valores com `+` e `-` em passos de 5%; as mudanças ficam em rascunho até selecionar **\[ Aplicar ]**. Temas novos começam com os dois efeitos ativados em `50%`.
Use `↑/↓` para mover entre as linhas de ativação e valor. Pressione `Tab` para **Ações** e ative **\[ Aplicar ]**.

## Posição e espaçamento

A posição padrão é a borda superior em modo dock. O Control Center expõe posição da taskbar, margens da taskbar/shell e grupo de utilitários em **Aparência → Espaços, bordas e posição**. O estado de layout salva margens independentes no topo, esquerda, direita e embaixo. Sticky mantém a barra próxima à borda; Float usa margem padrão de shell `18`.

Margem da taskbar, gap externo das janelas e geometria dos painéis são relacionados, mas distintos. Alterar um não reescreve todos os outros valores. Se a barra parecer visualmente afastada das janelas, revise modo, margens da taskbar e espaçamento das janelas juntos; veja [Janelas e layout](/pt/docs/argvus-hyprland/windows-and-layout/).

O controle de posição seleciona **Top** ou **Bottom**. As quatro margens independentes controlam a distância da barra de cada borda da tela. O grupo utilitário pode usar o comportamento **Auto** ou **Always expanded**. A disponibilidade de módulos ainda depende dos providers e do hardware instalados; mudar o espaçamento não cria um indicador de Bluetooth, brilho ou armazenamento ausente.

## Configuração e overrides

A configuração da taskbar pertence ao `argvus-taskbar`, é renderizada pelo `argvus-waybar` e iniciada pelo `argvus-session`. O `argvus-config` é o único componente que escreve os arquivos de consumo da taskbar: ele projeta a camada ativa em `~/.config/argvus/data/generated/waybar/` e reaplica a camada do tema, as margens da taskbar, o modo `right-2` do grupo utilitário, o raio das bordas e o bloco de fonte sempre que temas ou o estado de layout mudam. Como a cópia gerada é resolvida primeiro, um caminho nativo da Waybar em `~/.config/waybar/` só entra em vigor enquanto o arquivo gerado correspondente estiver ausente. Veja [Overrides da Waybar e da taskbar](/pt/docs/argvus-waybar/) para precedência, exemplos e diagnóstico.

## Janelas e painéis

A taskbar é uma superfície do shell junto ao Control Panel e ao widget opcional de telemetria. O Hyprland organiza janelas conforme o estado de layout ativo, enquanto essas superfícies possuem âncoras e margens próprias. `SUPER + SHIFT + Space` alterna a janela em foco entre layouts tileado e flutuante.

## Recarga

O serviço principal é `argvus-taskbar.service`. Quando uma alteração documentada exigir recarga manual, use o controlador de sessão:

```sh
argvus-sessionctl restart waybar
```

Popups de calendário e armazenamento removível usam o contrato de coordenadas raiz imutáveis fornecido pela compilação Waybar do ARGVUS para identificar o monitor. O calendário acompanha a superfície horizontal real da taskbar: abre 4 pixels abaixo de uma barra no topo ou 4 pixels acima de uma barra embaixo, independentemente do ponto clicado dentro do módulo de data. Não edite a configuração de runtime gerada para fazer alterações persistentes; use o Control Center ou o caminho documentado de [override da Waybar](/pt/docs/argvus-waybar/).
