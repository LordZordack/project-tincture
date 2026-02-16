# Game Design Document

## Overview

**Project Tincture** is a top-down hack-and-slash dungeon crawler built with LÖVE2D.

The player, **Apolest Opsis**, is haunted by the spirits of his two dead brothers. This haunting invests him with **Skia Aphalescence** — black magic that allows him to enter a dungeon saturated with dark energy. Anyone else who enters is disintegrated. Apolest enters completely naked; all items must be scavenged from within.

Deep inside, the last human king **Anaxarkas** is imprisoned, impaled by a soul-binding sword. Pulling the sword free is the win condition — but it comes at a terrible cost.

## Core Pillars
- **Everything is an item** — Weapons, furniture, corpses, scenery. If you can carry it, you can fight with it.
- **The Three-Point System** — Apolest and his two brothers each hold an item. All three attack and block in unison.
- **Faction-driven world** — Three fairy alliances (Arete, Eophyll, Skia) with their own aggression and inter-faction hostility.
- **Start with nothing** — No inventory carries over. Every run begins naked in a hostile dungeon.

## Table of Contents
- [Player](player.md) — Apolest Opsis, the brothers, narrative arc
- [Gameplay](gameplay.md) — Core loop, controls, carrying, camera
- [Items](items.md) — Item categories, qualities, interactions
- [Entities](entities.md) — Alliances, NPCs, aggression, key characters
- [Combat](combat.md) — Three-point system, actions, damage, blocking
- [Levels](levels.md) — Dungeon structure, rooms, progression
- [Art & Audio](art-and-audio.md) — Visual style, sprites, sound design
- [UI/UX](ui-ux.md) — HUD, menus, feedback systems
