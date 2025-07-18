---
documentclass: article
lang: "en"
title: "Execution Layer"
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

# Execution Layer

The _Execution Layer_ is a critical component of blockchain systems, responsible for executing transactions and maintaining the state of the blockchain. It operates on top of the consensus layer, which ensures that all nodes agree on the order of transactions.

# UTXO (Unspent Transaction Output) Model

The _UTXO_ model is used in Bitcoin. It represents the state of the blockchain as a set of unspent transaction outputs, which can be used as inputs for new transactions.

\vspace{0.5cm}

**\boxed{DEFINITION}**

Given a UTXO block $U_i$ in the blockchain, and let $TX_i = \{tx_1, \ldots, tx_n\}$ be the set of transactions included in the block, organized in a Merkle tree with root hash $h_{\text{root}}$. The block $U_i$ can be defined as:

\begin{equation}
    U_i = (H_{i-1}, MT(h_{\text{root}}))
\end{equation}

## Merkle Tree

A _Merkle Tree_ is a data structure that allows efficient verification that a transaction is included in a block, without needing all the data.

\vspace{0.5cm}

**\boxed{SEARCHING}**

1. **Initialization:** Client stores the root hash of the Merkle tree $h_{\text{root}}$.
2. **Forwarding:** Prover sends to the client the transaction hash $TX_i$ and the Merkle proof:

    $$\Pi = \{h_1, h_2, ..., h_k\}$$

    Where each $h_i$ is a hash at some level of the tree.
3. **Verification:** Starting from $tx_i$, the client combines it with each $h_i$, following the tree path:

    $$h' = H(H(H(tx_i\ \|\ h_1)\ \|\ h_2)\ \| \ldots\ \|\ h_k)$$
4. **Termination:** The client accepts if the final hash equals the stored Merkle root:
    
    $$h' = h_{\text{root}}$$

# Account-based Model

The _Account-based Model_ is used in Ethereum. It represents the state of the blockchain as a set of accounts, each with its own metadata.

\vspace{0.5cm}

The two main types of accounts in the account-based model are:

- **Externally Owned Account (EOA):** Controlled by a private key, can send transactions.
- **Contract Account:** Contains code and storage, can execute smart contracts.
