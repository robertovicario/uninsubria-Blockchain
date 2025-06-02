---
documentclass: article
lang: "en"
title: "Byzantine Fault Tolerance (BFT) Consensus"
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

# Byzantine Fault Tolerance (BFT) Problem

In a distributed network, not every participant can be trusted. Some may fail, lie, or act maliciously. This leads to the _Byzantine Fault Tolerance Problem_:

\vspace{0.5cm}

:::warning
**Problem:** _If all the generals coordinate their attack and strike at the same time, the battle is won. However, if two generals falsely claim they will attack but instead retreat, the battle is lost. This failure in coordination undermines the entire strategy._
:::

## Fault Tolerance

Fault tolerance is the ability of a system to continue operating correctly even when some of its components fail:

- **Crash Faults:** Nodes may crash or become unresponsive.
- **Byzantine Faults:** Nodes may behave arbitrarily, including sending conflicting information to different nodes.

\vspace{0.5cm}

> **Theorem:** Let $n$ be the total number of nodes in a distributed system and $f$ be the maximum number of faulty nodes. To guarantee that honest nodes can reach consensus despite the presence of these faulty nodes, it is necessary that:

\begin{equation}
    n \geq 3f + 1
\end{equation}

# Byzantine Broadcast (BB)

> **_Synchronous_**

This method allows a source node to broadcast a message to all other nodes in the network, ensuring that even if some nodes are faulty, the remaining honest nodes can still reach consensus on the message.

\vspace{0.5cm}

**\boxed{ALGORITHM}**

1. **Initialization:** The source node sends the message to all nodes.
2. **Propagation:** Each node forwards the message received from the source node to all other nodes.
3. **Acknowledgment:** Each node applies a decision rule (e.g., majority voting) based on the messages received to agree on the final value.
4. **Termination:** The protocol terminates when all honest nodes agree on the same value.

\vspace{0.5cm}

:::error
**Vulnerability:** This protocol relies on a single source node to initiate the broadcast. If this node is compromised, it can send conflicting messages to different nodes, potentially disrupting consensus. This creates a _Single Point of Failure_, where the entire system never reaches consensus.
:::

## Dolev-Strong Protocol

> **_Synchronous_**

_Dolev-Strong_ protocol allows a source node to broadcast a message to all other nodes in the network, ensuring that even if some nodes are faulty, the remaining honest nodes can still reach consensus on the message.

\vspace{0.5cm}

**\boxed{ALGORITHM}**

1. **Initialization:** The sender sends a signed message $m$ to each node:

    $$
    M_0 = (m, \sigma_S(m))
    $$

2. **Propagation:** For rounds $r = 1, \ldots, f$, each node forwards the message to all other nodes, including its own signature $i$.

    $$
    M_{r-1} = (m, \sigma_{i_0}(m), \sigma_{i_1}(m), \ldots, \sigma_{i_{r-1}}(m))
    $$

3. **Acknowledgment:** Each node collects all received messages $M_r$. Messages with invalid values in the chain are discarded.

4. **Termination:** The consensus is reached when nodes reach the quorum of $2f + 1$ messages. The final value is the one with the highest number of votes.

\vspace{0.5cm}

> **FLM (Fischer-Lynch-Merritt) Impossibility Result:** In synchronous systems, the absence of a Public Key Infrastructure (PKI), makes impossible to achieve consensus.

# Byzantine Agreement (BA)

> **_Asynchronous_**

This method does not rely on a single source node to initiate the broadcast. Instead, it allows all nodes to participate in the consensus process, ensuring that even if some nodes are faulty, the remaining honest nodes can still reach consensus on the message.

\vspace{0.5cm}

**\boxed{ALGORITHM}**

1. **Initialization:** Each node starts with an initial private value.
2. **Agreement:** All honest nodes decide the same value.
3. **Validity:** If all honest nodes start with the same value, they will all decide on that value.
4. **Termination:** The protocol terminates when all honest nodes agree on the same value.

## FLP (Fischer-Lynch-Patterson) Impossibility Result

> **_Asynchronous_**

In asynchronous systems, does not exist a deterministic algorithm that can guarantee consensus in the presence of even a single faulty node. This could lead to a situation where the system never reaches consensus, as nodes may wait indefinitely for messages from other nodes.

\vspace{0.5cm}

**\boxed{PROOF}**

Let each node hold a private input value of either 0 or 1. Define a family of initial configurations $X_i$, where the first $i$ nodes have value 0 and the remaining $n - i$ nodes have value 1:

$$
X_i = (\underbrace{0, 0, \ldots, 0}_i, \underbrace{1, 1, \ldots, 1}_{n - i})
$$

Since $X_0 = (0, 0, \dots, 0)$, by _Validity_, the output must be 0. Thus, $X_0$ is a 0-configuration. Similarly, $X_n = (1, 1, \dots, 1)$ must lead to output 1, and is a 1-configuration.

If we gradually flip the input bits from 0 to 1, moving from $X_0$ to $X_n$, there must exist a first index $i$ such that:

- $X_{i-1}$ is still a 0-configuration, but $X_i$ is not a 0-configuration, and is not yet a 1-configuration either.

\vspace{0.5cm}

> **Lemma 1:** There exists at least one _Ambiguous Configuration_, where the output is not determined and _Termination_ is not guaranteed.

\vspace{0.5cm}

Let $C$ be an ambiguous configuration, one from which both decision values 0 and 1 are still possible through different executions. Then, there exists at least one event $e$ (e.g., the delivery of a message to a process) such that executing $e$ from $C$ leads to another ambiguous configuration.

\vspace{0.5cm}

> **Lemma 2:** Even if an event is applied to an ambiguous configuration, it does not necessarily break the bivalence: the system can remain in a state where both outcomes (0 or 1) are still possible. This prevents the system from "forcing" a definitive decision in a finite number of steps.

\vspace{0.5cm}

Using Lemma 1 (existence of an ambiguous configuration) and Lemma 2 (persistence of ambiguity), one can construct an infinite, fair execution in which the system never reaches a decision, violating the _Termination_ property of consensus.

\vspace{0.5cm}

:::info
**Conclusion:** Therefore, deterministic consensus is impossible in an asynchronous system with even one possible faulty node.
:::

# Rotating Leaders

> **_Partially Synchronous_**

This method proposes a solution for _Single Point of Failure_ problems by allowing nodes to take turns being the leader, ensuring that no single node has control over the entire system.

\vspace{0.5cm}

**\boxed{ALGORITHM}**

1. **Initialization:** A leader is selected.
2. **Proposal:** The leader proposes a value to the other nodes.
3. **Voting:** Each node votes on the proposed value, and if a majority agrees, the value is committed.
4. **Rotation:** After a round, the leadership role rotates to the next node.

## DLS (Dwork-Lynch-Stockmeyer) Impossibility Result

> **_Partially Synchronous_**

In a partially synchronous system, where message delivery time becomes bounded only after some unknown Global Stabilization Time (GST), no deterministic algorithm can guarantee both safety and liveness in the presence of even one faulty process.

\vspace{0.5cm}

**\boxed{PROOF}**

Let $N_2$ be the faulty process, and let all other processes be honest:

- Let $N_1$ have input value $1$.
- Let $N_3$ have input value $0$.
- The faulty process $N_2$ behaves inconsistently:

  - It sends messages to $N_1$ claiming its input is $1$.
  - It sends messages to $N_3$ claiming its input is $0$.
  - The adversary delays all communication between $N_1$ and $N_3$ until after both have decided.

Since GST is unknown, and pre-GST message delays are unbounded, $N_1$ and $N_3$ cannot distinguish delayed messages from crashed processes. As a result:

- $N_1$ may decide value $1$, believing $N_2$ and itself are honest.
- $N_3$ may decide value $0$, believing $N_2$ and itself are honest.

This leads to:

$$
v_1 \neq v_3
$$

\vspace{0.5cm}

:::info
**Conclusion:** Therefore, no deterministic algorithm can achieve consensus in a partially synchronous system with even one faulty process.
:::

## Tendermint Protocol

> ***Partially Synchronous***

_Tendermint_ is a deterministic consensus protocol designed to work in the partially synchronous model, tolerating faulty nodes giving up safety during asynchronous periods.

\vspace{0.5cm}

**\boxed{ALGORITHM}**

Each round $r$ designates a leader at the moment $t$. Each round has four phases, lasting $\Delta$ each after GST, with a total duration of $4\Delta r$:

1. **Propose:** The leader proposes a block along with a Quorum Certificate (QC) justifying it. This happens at time $t = 4\Delta r$.
2. **Prevote:** Validators vote if the block is valid and consistent with the latest QC. This happens at time $t = 4\Delta r + \Delta$.
3. **Precommit:** If a validator sees $\geq \frac{2n}{3}$ prevotes for a block, it broadcasts a precommit. This happens at time $t = 4\Delta r + 2\Delta$.
4. **Commit:** If a validator sees $\geq \frac{2n}{3}$ precommits, it commits the block and advances height. This happens at time $t = 4\Delta r + 3\Delta$.
