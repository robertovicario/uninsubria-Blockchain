---
documentclass: article
lang: "en"
title: "Proof of Work (PoW) Mechanisms"
subtitle: "Blockchain @ uninsubria"
author: "Roberto Vicario"
date: "2024/2025"

titlepage: true
titlepage-color: "FFFFFF"
titlepage-text-color: "000000"
titlepage-rule-color: "007161"
toc: true
toc-own-page: true
numbersections: true
colorlinks: true
linkcolor: "blue"
urlcolor: "blue"

header-includes:
    - |
      ```{=latex}
      \usepackage{tcolorbox}
      \newtcolorbox{info-box}{colback=cyan!5!white,arc=0pt,outer arc=0pt,colframe=cyan!60!black}
      \newtcolorbox{warning-box}{colback=orange!5!white,arc=0pt,outer arc=0pt,colframe=orange!80!black}
      \newtcolorbox{error-box}{colback=red!5!white,arc=0pt,outer arc=0pt,colframe=red!75!black}
      ```

pandoc-latex-environment:
    info-box: [info]
    warning-box: [warning]
    error-box: [error]
---

# Proof of Work (PoW) Mechanisms

Proof of Work (PoW) is a consensus mechanism used in blockchain systems to ensure that all participants agree on the state of the ledger. It requires participants (miners) to solve complex mathematical problems in order to add new blocks to the blockchain.

## Incentives

With the purpose to create a secure and decentralized network, PoW mechanisms provide economic incentives for miners to participate honestly. The main incentives include:

- **Block Rewards:** Miners receive a reward for successfully mining a block, which is typically a fixed amount of cryptocurrency.
- **Transaction Fees:** Miners can also collect fees from transactions included in the blocks they mine.

\vspace{0.5cm}

:::danger
**Selfish Mining:** A node can deviate from the protocol to increase its own rewards, potentially leading to a situation where it can earn more than its fair share of rewards:

- **Case with $\alpha > 0.5$:** Node $A$ can orphan honest blocks and earn approximately 100% of the rewards.
- **Case with $\alpha < 0.5$:** It is still possible to earn more than $\alpha$ of the total rewards through a strategy that:
  - Delays block announcements.
  - Selectively orphans blocks.
  - Exploits tie-breaking in an adversarial manner.

Key finding:

\begin{equation}
\text{Reward share} > \alpha\  \text{if}\  \alpha > 0.33
\end{equation}
:::

## Transaction Fees

Transaction fees are an essential part of PoW mechanisms, as they provide an additional incentive for miners to include transactions in the blocks they mine. The fees are typically paid by users who want their transactions to be processed quickly.

### 2.1 Problema del block size
- Capacità limitata: es. `1MB`, \( \approx 1000 \) tx/block.
- Le transazioni competono per essere incluse: nasce il concetto di **transaction fee**.

### 2.2 Meccanismo di asta (First-Price Auction)
- Ogni transazione propone una fee.
- I miner selezionano le tx con la fee più alta.
- Problemi:
  - Strategia di bidding inefficiente.
  - Incentivi al selfish mining se `TxFees >> BlockReward`.

### 2.3 Meccanismo EIP-1559 (Ethereum)
- Introduce **base fee** deterministica `r`, calcolata dinamicamente:
  - Se `\text{block size} > c \Rightarrow r \uparrow`
  - Se `\text{block size} < c \Rightarrow r \downarrow`

- **Fee totale = base fee (bruciata) + tip (al miner).**

- Vantaggi:
  - Prevedibilità.
  - Mitigazione della collusione.
  - Riduzione dell’inflazione tramite burning.

???????????
