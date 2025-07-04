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

# Longest Chain (LC)

Longest chain is a data structure used in blockchain systems to maintain a single, agreed-upon history of transactions.

\vspace{0.5cm}

**\boxed{ASSUMPTIONS}**

An algorithm reaches consensus under the following assumptions:

1. **Unknown Genesis Block:** No node knows the genesis block, before the start of the consensus process.
2. **Leader Verification:** It is easy for all nodes to verify whether a given node is the leader.
3. **Leader Selection:** No node can influence the probability of being selected as the leader.
4. **Predecessor Requirement:** For each new proposal, must exists a predecessor block in the chain from the previous round.
5. **Chain Status:** At all times, all correct nodes know the same set of blocks and their predecessors.

\vspace{0.5cm}

:::warning
**Problem:** _Nodes may disagree on the current state because they have seen different versions of the chain. Is there a way to randomly sample the leader from an unknown set of participants?_
:::

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

**\boxed{PROOF}**

Given a cryptographic hash function $H$, find an input $x$ such that:

$$
H(x) \leq \tau
$$

where $\tau$ is the current difficulty target.

Since $H$ behaves like a random function, the only viable strategy is brute-force search. The difficulty of the puzzle is adjusted by changing $\tau$:

- Smaller $\tau \Rightarrow$ fewer hash outputs satisfy the condition $\Rightarrow$ harder puzzle
- Larger $\tau \Rightarrow$ more outputs satisfy the condition $\Rightarrow$ easier puzzle

\vspace{0.5cm}

PoW can be integrated into consensus mechanisms in these ways:

- **PoW + BFT:** Integrating PoW with BFT consensus can introduce instability. Fluctuations in the network's total computational power may disrupt predictable leader selection, undermining the reliability and security guarantees of BFT protocols. As a result, combining PoW with BFT is generally discouraged.
- **PoW + LC:** Nodes compete to solve computational puzzles, and the chain with the most accumulated proof of work is considered the valid one. This combination forms the basis of _Nakamoto Consensus_.

# Nakamoto Consensus

> **Partially Synchronous**

_Nakamoto Consensus_ is a consensus mechanism designed for PoW-based blockchains. It elects a leader in each round based on the computational effort expended by nodes, allowing them to agree on a single chain of blocks.

\vspace{0.5cm}

**\boxed{ALGORITHM}**

1. **Puzzle Solving:** Each node attempts to solve a cryptographic puzzle.
2. **Leader Election:** The first node to find such $x$ becomes the leader and broadcasts the block as its proposal for the next block in the chain.
3. **Chain Extension:** Honest nodes always extend the chain with the highest total work, the one requiring the most cumulative PoW effort.
4. **Difficulty Adjustment:** The protocol adjusts $\tau$ over time to maintain a stable block production rate and reduce accidental forks. A typical target is one block every fixed time interval.
