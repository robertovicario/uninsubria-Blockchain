---
documentclass: article
lang: "en"
title: "Introduction"
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

# Blockchain

_Blockchain_ is a special kind of database that stores information in a chain of blocks. Each block contains a list of transactions, and these blocks are linked together in the order they were added like a digital ledger.

## Key Components

| **Component** | **Description** |
|-|-|
| **Transaction** | A record of an action or event, like sending money. |
| **Block** | A container for a list of transactions. |
| **Chain** | A series of blocks linked together. |

> **Definition:** _Genesis Block_ is the first block in a blockchain and serves as the foundation of the chain. It is unique because it has no previous block, and its previous_hash is set to zero. This block is crucial for establishing the integrity and immutability of the blockchain.

> **Definition:** The process of creating a new block and adding it to the blockchain is called _Mining_. In a real-world blockchain, this process involves solving complex mathematical problems to validate transactions and secure the network.

# Decentralization

_Decentralization_ means that control and decision-making aren't held by a single entity, like a company or government. Instead, power is distributed across a network of independent participants.

## The Consensus Problem

In decentralized systems, no single person or computer is in charge, so how do all the independent nodes agree on what’s true? That’s the _Consensus Problem_:

> **Problem:** _How can a group of participants, who don't fully trust each other, agree on a single version of the truth?_

## State Machine Replication (SMR)

```txt
# TODO
```
