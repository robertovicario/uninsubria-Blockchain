---
documentclass: article
lang: "en"
title: "Byzantine Fault Tolerance (BFT)"
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

#  The Byzantine Fault Tolerance (BFT) Problem

In a distributed network, not every participant can be trusted. Some may fail, lie, or act maliciously. This leads to the _Byzantine Fault Tolerance Problem_:

> **Problem:** _If all the generals coordinate their attack and strike at the same time, the battle is won. However, if two generals falsely claim they will attack but instead retreat, the battle is lost. This failure in coordination undermines the entire strategy._

### Rotating Leaders

To reduce the risk of being stuck with a malicious leader:

1. The protocol uses rotating leaders.
2. Each round, a new node becomes the leader.
3. If one leader misbehaves, the system can recover in the next round under an honest leader.

But this only works well if each round achieves consensus, which brings us to the next point.

## Byzantine Broadcast

```txt
# FIXME

Properties:

1. Termination: Every honest node eventually decides on some output.
2. Agreement: All honest nodes decide on the same output.
3. Validity: If the sender is honest and sends a message, all honest nodes decide on that message.
```

### Example 1: $f = 1$

Let $f = 1$ be the function. Let’s say:

- There are 4 nodes, and $f = 1$ (one can be Byzantine).
- The sender sends a message to others.
- Each node echoes the message to everyone else.
- If a node sees enough matching echoes, it commits to the message.

This ensures that even if one node lies, the majority truth prevails.

### Example 2: $f = 2$

Let $f = 2$ be the function. Let’s say:

```txt
# TODO
```

## Dolev-Strong Protocol

```txt
# TODO
```

### Working

```txt
# TODO
```
