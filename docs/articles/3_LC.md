---
documentclass: article
lang: "en"
title: "Longest Chain (LC) Consensus"
subtitle: "Blockchain @ uninsubria"
author: "Roberto Vicario"
date: "2024/2025"

titlepage: true
titlepage-color: "FFFFFF"
titlepage-text-color: "000000"
titlepage-rule-color: "9D44B5"
toc: true
toc-own-page: true
numbersections: true
colorlinks: true
linkcolor: "blue"
urlcolor: "blue"
---

# Longest Chain (LC)

...

\vspace{0.5cm}

> **Problem:** _Nodes may disagree on the current state because they have seen different versions of the chain. Is there a way to randomly sample the leader from an unknown set of participants?_

## Sybil Attacks

A _Sybil Attack_ occurs when a single entity creates multiple identities to gain disproportionate influence in a network.

\vspace{0.5cm}

> **Theorem:** Given a network of $n$ nodes, each with a distinct hashrate $\mu_1, \mu_2, \ldots, \mu_n$. In each round of leader selection, the probability that node $i$ is chosen as the leader is proportional to its hashrate and is given by:

$$
\frac{\mu_i}{\sum_{j=1}^{n} \mu_j}
$$

To prevent Sybil attacks, the system must ensure that creating multiple identities is costly or requires a significant investment of resources. For this reason, were implemented two main mechanisms: _Proof of Work (PoW)_ and _Proof of Stake (PoS)_.

### Proof of Stake (PoS)

The chance of being chosen to propose or validate a block generally depends on the amount committed. This approach helps limit the influence of any single participant and discourages the creation of many identities. PoS can be integrated into consensus mechanisms in these ways:

- **PoS + BFT:** The quorum is easily achieved by selecting the nodes with the highest stake.
- **PoS + LC:** The longest chain selects the leader by the depth of the chain, which is proportional to the stake held by the nodes.

### Proof of Work (PoW)

In this mechanism, the nodes called miners, compete to solve a cryptographic _Hard Puzzle_ by finding a nonce that, when combined with the block's data and hashed, produces a hash value below a specified target:

\vspace{0.5cm}

> **Hard Puzzle:** ... 19 / 20 / 21 !!

\vspace{0.5cm}

PoW can be integrated into consensus mechanisms in these ways:

- **PoW + BFT:** Integrating PoW with BFT consensus can introduce instability. Fluctuations in the network's total computational power may disrupt predictable leader selection, undermining the reliability and security guarantees of BFT protocols. As a result, combining PoW with BFT is generally discouraged.
- **PoW + LC:** Nodes compete to solve computational puzzles, and the chain with the most accumulated proof of work is considered the valid one. This combination forms the basis of _Nakamoto Consensus_.

# Nakamoto Consensus

> **Partially Synchronous**

...
