---
documentclass: article
lang: "en"
title: "Consensus Mechanisms"
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

# Proof of Work (PoW)

Proof of Work (PoW) is a consensus mechanism used in blockchain systems to ensure that all participants agree on the state of the ledger. It requires participants (miners) to solve complex mathematical problems in order to add new blocks to the blockchain.

## Incentives

With the purpose to create a secure and decentralized network, PoW mechanisms provide economic incentives for miners to participate honestly. The main incentives include:

- **Block Rewards:** Miners receive a reward for successfully mining a block, which is typically a fixed amount of cryptocurrency.
- **Transaction Fees:** Miners can also collect fees from transactions included in the blocks they mine.

\vspace{0.5cm}

:::danger
**Selfish Mining:** A node can deviate from the protocol to increase its own rewards, potentially leading to a situation where it can earn more than its fair share of rewards.
:::

\vspace{0.5cm}

There are two main cases to consider regarding selfish mining:

- **Case with $\alpha > 0.5$:** Node $A$ can orphan honest blocks and earn approximately 100% of the rewards.
- **Case with $\alpha < 0.5$:** It is still possible to earn more than $\alpha$ of the total rewards through a strategy that: delays block announcements, selectively orphans blocks, and exploits tie-breaking in an adversarial manner.

In general, a selfish miner can obtain a share of rewards greater than their relative mining power $\alpha$ if $\alpha$ exceeds approximately _0.33_. This means that even with less than one-third of the total mining power, a selfish miner can outperform honest mining by strategically withholding and releasing blocks.

## Transaction Fees

Transaction fees are an essential part of PoW mechanisms, as they provide an additional incentive for miners to include transactions in the blocks they mine. The fees are typically paid by users who want their transactions to be processed quickly.

\vspace{0.5cm}

::: warning
**Block Size Problem:** The limited capacity of blocks leads to competition among transactions for inclusion, resulting in the need for transaction fees.
:::

# Proof of Stake (PoS)

...
