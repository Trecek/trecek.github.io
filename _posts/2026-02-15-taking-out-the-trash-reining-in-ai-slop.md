---
title: "Taking Out the Trash: Reining in AI Slop"
date: 2026-02-15 12:00:00 -0500
categories: [AI, Agentic Coding]
tags: [claude-code, skills, code-quality, ai-slop]
toc: true
image:
  path: /assets/img/posts/id-slop-scan-summary.png
  alt: "Slop identification scan results showing 58 findings across 8 categories"
---

![KitKi](/assets/img/posts/cat-kitki-possessive.png){: .post-cat-sticker }

**Do you take the trash out every time you throw something away?**
**Or do you wait until it fills up?**

Agentic coding is incredibly empowering, but there are a lot of nuances you learn along the way. It's categorically worth it though. Even if AI stopped improving today, it is already good enough to transform coding forever.

There are frustrations you will initially run into when working with AI. AI, and each model, has a sort of personality you have to get used to and learn to work with.
One of the most common frustrations I faced was the slop agents would drop into my codebase. No matter how many rules I made about not using my codebase as a notepad or journal, it would still do it. It tended to happen more frequently when the task was complex and the codebase was large.

Agentic coders have a limited cognitive load. They will start dropping the small things once they've reached that maximum load. What could be smaller than non-functional commented out code? So that rule is the first to go for an over-worked agentic coder.

**Example slop:**
```python
# Phase 5: Migrate Checkpoint and Session Management
def migrate_session():  # Part of Phase 2 migration
```

```python
# NOTE: test-and-log removed in Phase 4. Use simple 'test' task.
# baseline_manager removed - now handled by executor
```

### The right question

So does this mean AI is dumb? Is AI not ready? These are the wrong questions. The question is, can you work with this? And how? Working with agentic coders is a skill just like working with people is a skill, albeit agents are a bit more locked in their ways.

### Decompose by role, not by rule

If you throw unrelated tasks at the agent, it will perform worse than giving it a set of conceptually or functionally related tasks. So when you give it a set of rules that aren't functionally or conceptually related to a complex set of tasks, those rules get forgotten.

We are telling the agent it needs to take the trash out every single time it throws a piece in. The agent should just not generate the trash comments in the first place, right? But agents have a sort of fixed state of mind. Different models have different quirks that are baked in. The agent can't help but want to leave useless comments all over your repo. It is an impulse, a tic, and to stop it means stopping it every time the impulse kicks in. You see this commonly with "You're absolutely right" and em dashes. You can't expect the agent to be perfect, and you don't want to waste time and your limited context window on suppressing an impulse that will never go away.

![The id-slop skill's investigation workflow launching parallel subagents to scan for different slop categories](/assets/img/posts/id-slop-skill-workflow.png){: .shadow }
_Step 1 of the id-slop skill: parallel subagents each targeting a specific slop category_

Instead of trying to get the agent to take the trash out for every piece of trash, make a new agent whose sole purpose is to identify AI slop. Then run that specialized agent when the trash fills up. It will save you tokens, time, and your limited context window. I like to do it when my weekly Claude Code limits are about to reset.

This is just a single obvious example of identifying parts of a task that need to be decomposed into a role. Of course, the complexity of the task at hand is the biggest influence on when and how much you need to decompose. But there are many examples of this in both the real world and AI, such as investigations, reviews, planning, testing, implementation, and verification.

### The toolkit

Claude Code is an agentic coding tool that supports skills. Skills are markdown files that give the agent specific instructions for a task. Think of them as reusable role definitions. You can find some example skills [here](https://github.com/Trecek/useful-claude-skills). You can see the slop removal skill used in this post here: [id-slop](https://github.com/Trecek/useful-claude-skills/blob/main/.claude/skills/id-slop/SKILL.md)

Example summary of a slop scan:

![Slop identification scan results showing 58 findings across 8 categories](/assets/img/posts/id-slop-scan-summary.png){: .shadow }
_Output from the id-slop skill after scanning a medium-sized codebase_

This is part of a larger shift in how software gets built. The focus is moving from perfect PRs to keeping code flowing like a production line, where specialized roles handle each stage and nothing blocks the flow. More on that in a future post.