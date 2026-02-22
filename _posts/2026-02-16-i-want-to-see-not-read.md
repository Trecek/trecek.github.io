---
title: "I Want to See, Not Read"
date: 2026-02-22 06:00:00 -0500
categories: [AI, Agentic Coding]
tags: [claude-code, skills, architecture, visualization, mermaid]
description: "13 Lenses for Visualizing Code to Keep Up with Your Agentic Coders"
toc: true
mermaid: true
image:
  path: /assets/img/posts/arch-lens-no-text-full-bg.png
  alt: "Agentic workflow with architecture lens visualization"
---

![KitKat](/assets/img/posts/cat-kitkat-sleeping.png){: .post-cat-sticker }

Agentic coding makes software development fast. Too fast, yet not fast enough. 
Your own software's development becomes a blur to you. 
You find yourself constantly querying agents about your own codebase as you approve the AI-generated plans. 
Recently, between improvements in agentic AI and my own experience using them, I have found very few errors or issues in my agentic workflows. 
The weak link used to be the agentic coder, now it's me. I am slogged with plans to review while trying to track & guide the development of my projects. 
I can't handle more walls of text.

### My workflow

Claude Code is a tool that lets AI explore, write, modify, and run code for you. 
It supports skills, which are plain text markdown files with specific instructions that tell the AI how to perform a task. 

My typical skill workflow:
```
                                       ┌──────────────────────────────────────────────────┐
(optional)          (optional)         │              Core Pipeline                       │
make-scenarios ──→ make-requirements─→ │ make-plan → dry-walkthrough → implement-worktree │
                        ↑              └──────────────────────────────────────────────────┘
                  or use directly
```

_I get dozens of plans like this every day that I have to review. My eyes are bleeding..._

![Scrolling through a lengthy implementation plan](/assets/img/posts/arch-lens-plan-scrollthrough.gif){: .shadow }

### I want to see, not read

When I review a plan before running the implementation skill, I don't need to know every detail. My role is to guide toward an outcome, not an implementation. Testing infrastructure, reviews, linting, CI/CD workflows, and specialized agents catch most of the riffraff.

If I could see a visualization of the proposed changes, even if I miss the details, as I review dozens of these plans a day, I will internalize the architectural progression of my project.

So how do we visualize code? There are many ways to visualize a codebase, each from a different perspective (security, networking, the user, interfaces, modular, etc.). I used Gemini's deep research to explore the different strategies and philosophies around software visualization, then had Claude generate a skill for each category it identified.

### The 13 perspectives (lenses) of a codebase
[Architectural skills](https://github.com/Trecek/useful-claude-skills/tree/main/docs/arch-lens)

| Skill | Lens | Question It Answers |
| --- | --- | --- |
| [`arch-lens-c4-container`](https://github.com/Trecek/useful-claude-skills/tree/main/.claude/skills/arch-lens-c4-container/SKILL.md) | C4 Container | How is it built? |
| [`arch-lens-process-flow`](https://github.com/Trecek/useful-claude-skills/tree/main/.claude/skills/arch-lens-process-flow/SKILL.md) | Process Flow | How does it behave? |
| [`arch-lens-data-lineage`](https://github.com/Trecek/useful-claude-skills/tree/main/.claude/skills/arch-lens-data-lineage/SKILL.md) | Data Lineage | Where is the data? |
| [`arch-lens-module-dependency`](https://github.com/Trecek/useful-claude-skills/tree/main/.claude/skills/arch-lens-module-dependency/SKILL.md) | Module Dependency | How are modules coupled? |
| [`arch-lens-concurrency`](https://github.com/Trecek/useful-claude-skills/tree/main/.claude/skills/arch-lens-concurrency/SKILL.md) | Concurrency | How does parallelism work? |
| [`arch-lens-error-resilience`](https://github.com/Trecek/useful-claude-skills/tree/main/.claude/skills/arch-lens-error-resilience/SKILL.md) | Error/Resilience | How are failures handled? |
| [`arch-lens-repository-access`](https://github.com/Trecek/useful-claude-skills/tree/main/.claude/skills/arch-lens-repository-access/SKILL.md) | Repository Access | How is data accessed? |
| [`arch-lens-operational`](https://github.com/Trecek/useful-claude-skills/tree/main/.claude/skills/arch-lens-operational/SKILL.md) | Operational | How is it run and monitored? |
| [`arch-lens-security`](https://github.com/Trecek/useful-claude-skills/tree/main/.claude/skills/arch-lens-security/SKILL.md) | Security | Where are the trust boundaries? |
| [`arch-lens-development`](https://github.com/Trecek/useful-claude-skills/tree/main/.claude/skills/arch-lens-development/SKILL.md) | Development | How is it built and tested? |
| [`arch-lens-scenarios`](https://github.com/Trecek/useful-claude-skills/tree/main/.claude/skills/arch-lens-scenarios/SKILL.md) | Scenarios | Do the components work together? |
| [`arch-lens-state-lifecycle`](https://github.com/Trecek/useful-claude-skills/tree/main/.claude/skills/arch-lens-state-lifecycle/SKILL.md) | State Lifecycle | How is state corruption prevented? |
| [`arch-lens-deployment`](https://github.com/Trecek/useful-claude-skills/tree/main/.claude/skills/arch-lens-deployment) | Deployment | Where does it run? |

### Staying in the IDE

Okay so I have a bunch of lenses for visualizing code in various ways. What are we visualizing with? 
Well, I am not a fan of having to leave my code to work with my code. 
So I need my visualization to stay within my IDE (VSCode). 
I am not even a fan of having to leave the exact document I'm reviewing. 
So obviously we want a [Mermaid](https://mermaid.ai/) plot. Mermaid plots are a versatile plotting library you can embed directly into your markdown files and they will render with the markdown file.

### What it looks like

Here's an example. This diagram was produced by an agent running a skill I use for making plans. That planning skill loads a diagramming skill with the lens it thinks is most relevant to the proposed changes. If the agent thinks an additional lens view is needed it will add it too.

#### **The problematic architecture**

**Lens Used:** Module Dependency. 

```mermaid
%%{init: {'flowchart': {'nodeSpacing': 50, 'rankSpacing': 70, 'curve': 'basis'}}}%%
graph TB
    %% CLASS DEFINITIONS %%
    classDef cli fill:#1a237e,stroke:#7986cb,stroke-width:2px,color:#fff;
    classDef phase fill:#6a1b9a,stroke:#ba68c8,stroke-width:2px,color:#fff;
    classDef handler fill:#e65100,stroke:#ffb74d,stroke-width:2px,color:#fff;
    classDef stateNode fill:#004d40,stroke:#4db6ac,stroke-width:2px,color:#fff;
    classDef integration fill:#c62828,stroke:#ef9a9a,stroke-width:2px,color:#fff;
    classDef gap fill:#ff6f00,stroke:#ffa726,stroke-width:2px,color:#000;

    subgraph Layer3 ["LAYER 3 - APPLICATION"]
        direction LR
        CLI["apps/cli/<br/>━━━━━━━━━━<br/>Entry points<br/>planner, executor"]
        API["apps/api/<br/>━━━━━━━━━━<br/>FastAPI endpoints"]
    end

    subgraph Layer2 ["LAYER 2 - AGENTS"]
        direction LR
        PLANNER["agents/graph/planner/<br/>━━━━━━━━━━<br/>Planning agent<br/>98 files, 21.3K LOC"]
        EXECUTOR["agents/graph/executor/<br/>━━━━━━━━━━<br/>Execution agent<br/>163 files, 38.7K LOC"]
    end

    subgraph Layer1 ["LAYER 1 - INFRASTRUCTURE"]
        direction TB
        SDK["packages/sdk/<br/>━━━━━━━━━━<br/>Agent SDK<br/>134 files, 20.6K LOC"]
        SCHEMA["packages/schema/<br/>━━━━━━━━━━<br/>Data layer<br/>169 files, 29.3K LOC"]
    end

    subgraph Layer0 ["LAYER 0 - EXTERNAL"]
        direction LR
        EXT["External Dependencies<br/>━━━━━━━━━━<br/>langgraph, anthropic<br/>sqlmodel, tree-sitter"]
    end

    %% VALID DEPENDENCIES (Downward) %%
    CLI -->|"imports"| PLANNER
    CLI -->|"imports"| EXECUTOR
    API -->|"imports"| PLANNER
    PLANNER -->|"135 imports"| SDK
    PLANNER -->|"84 imports"| SCHEMA
    EXECUTOR -->|"124 imports"| SDK
    EXECUTOR -->|"135 imports"| SCHEMA
    SDK --> EXT
    SCHEMA --> EXT

    %% CIRCULAR DEPENDENCY (VIOLATION) %%
    SDK <-.->|"⚠ CIRCULAR<br/>14 files each"| SCHEMA

    %% CLASS ASSIGNMENTS %%
    class CLI,API cli;
    class PLANNER,EXECUTOR phase;
    class SDK,SCHEMA handler;
    class EXT integration;
```


**Color Legend:**

| Color | Category | Description |
|-------|----------|-------------|
| Dark Blue | Apps | Application layer entry points |
| Purple | Agents | Agent/service layer (planner, executor) |
| Orange | Infrastructure | Shared packages (sdk, schema) |
| Red | External | Third-party dependencies |
| Dashed Line | Violation | Circular dependency (BLOCKER) |


#### **The proposed architecture**

```mermaid
%%{init: {'flowchart': {'nodeSpacing': 50, 'rankSpacing': 70, 'curve': 'basis'}}}%%
graph TB
    %% CLASS DEFINITIONS %%
    classDef cli fill:#1a237e,stroke:#7986cb,stroke-width:2px,color:#fff;
    classDef phase fill:#6a1b9a,stroke:#ba68c8,stroke-width:2px,color:#fff;
    classDef handler fill:#e65100,stroke:#ffb74d,stroke-width:2px,color:#fff;
    classDef stateNode fill:#004d40,stroke:#4db6ac,stroke-width:2px,color:#fff;
    classDef newComponent fill:#2e7d32,stroke:#81c784,stroke-width:2px,color:#fff;
    classDef integration fill:#c62828,stroke:#ef9a9a,stroke-width:2px,color:#fff;

    subgraph Monorepo ["MONOREPO (GitHub)"]
        direction TB

        subgraph Apps ["Layer 3 - Apps"]
            CLI2["apps/cli/<br/>━━━━━━━━━━<br/>Entry points"]
        end

        subgraph Agents ["Layer 2 - Agents"]
            PLANNER2["agents/graph/planner/<br/>━━━━━━━━━━<br/>LangGraph planner"]
            EXECUTOR2["agents/graph/executor/<br/>━━━━━━━━━━<br/>LangGraph executor"]
        end
    end

    subgraph PyPI ["PyPI PACKAGES (Independent)"]
        direction TB

        subgraph Tier1 ["★ Tier 1 - Extract First"]
            AST["★ ast-extractor<br/>━━━━━━━━━━<br/>Tree-sitter extraction<br/>8 files, 1.4K LOC"]
            UTILS["★ agentic-planner-utils<br/>━━━━━━━━━━<br/>Pure utilities<br/>6 files, ~400 LOC"]
            MODELS["★ agentic-planner-models<br/>━━━━━━━━━━<br/>SQLModel definitions<br/>25 files"]
        end

        subgraph Tier3 ["★ Tier 3 - After Refactor"]
            CORE["★ agentic-planner-core<br/>━━━━━━━━━━<br/>Shared types/protocols<br/>Breaks circular dep"]
            SDK2["● agentic-planner-sdk<br/>━━━━━━━━━━<br/>Full SDK package"]
            SCHEMA2["● agentic-planner-schema<br/>━━━━━━━━━━<br/>Full schema package"]
        end
    end

    subgraph External ["EXTERNAL"]
        EXT2["tree-sitter<br/>sqlmodel<br/>langgraph"]
    end

    %% CLEAN DEPENDENCIES (No Cycles) %%
    CLI2 --> PLANNER2
    CLI2 --> EXECUTOR2
    PLANNER2 --> SDK2
    PLANNER2 --> SCHEMA2
    EXECUTOR2 --> SDK2
    EXECUTOR2 --> SCHEMA2

    SDK2 --> CORE
    SDK2 --> UTILS
    SDK2 --> AST
    SCHEMA2 --> CORE
    SCHEMA2 --> MODELS

    AST --> EXT2
    MODELS --> EXT2
    CORE --> EXT2

    %% CLASS ASSIGNMENTS %%
    class CLI2 cli;
    class PLANNER2,EXECUTOR2 phase;
    class SDK2,SCHEMA2 handler;
    class AST,UTILS,MODELS,CORE newComponent;
    class EXT2 integration;
```

**Color Legend:**

| Color | Category | Description |
|-------|----------|-------------|
| Dark Blue | Apps | Application layer (stays in monorepo) |
| Purple | Agents | Agent layer (stays in monorepo) |
| Orange | Refactored | SDK/Schema after circular fix |
| Green | New Package | Extracted PyPI packages |
| Red | External | Third-party dependencies |

The dot on the box means it is an existing component that will be modified by the proposed plan.  
A star on the box means it is a new component being created by the proposed plan.

### A better substrate

These architectural lenses help identify what parts of your architecture are being worked with.
For example, at a glance I can see the dashed bidirectional arrow between SDK and Schema in the current architecture. That's a circular dependency. 
In the proposed architecture I can see how the agent broke the cycle by extracting shared code into new packages that both sides depend on. Without the diagrams, the plan reads as a long list of file moves and import changes.

These skills are another example of decomposing processes into roles, and extending those roles into a reusable toolkit.

You can find more lens examples [here](https://github.com/Trecek/useful-claude-skills/tree/main/docs/arch-lens)

Next up, we'll see how we can take this a step further by analyzing git diffs and commit history to track the evolution of a project architecture.


### My current workflow

```mermaid
%%{init: {'flowchart': {'nodeSpacing': 30, 'rankSpacing': 50, 'curve': 'basis'}}}%%
graph LR
    classDef optional fill:#4a4a6a,stroke:#9999bb,stroke-width:1px,color:#ccc,stroke-dasharray: 5 5;
    classDef core fill:#1a237e,stroke:#7986cb,stroke-width:2px,color:#fff;
    classDef lens fill:#2e7d32,stroke:#81c784,stroke-width:2px,color:#fff;

    subgraph Optional ["Optional"]
        direction TB
        A["make-scenarios"] --> B["make-req"]
    end

    subgraph MCP ["automation-mcp"]
        direction LR
        C["make-plan"] --> D["arch-lens"]
        D --> E["dry-walkthrough"]
        E --> F["implement-worktree"]
    end

    Optional --> C

    class A,B optional;
    class C,E,F core;
    class D lens;
```
