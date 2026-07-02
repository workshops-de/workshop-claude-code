## Overview

Add an interactive map and learn to **state hard technical constraints up front** so the agent
doesn't head down a dead end. A map is a client-only, interactive component in a server-first app —
telling the agent that constraint first is context-engineering applied to implementation.

## Prerequisites

- Recommended: `agent-browser` (visually validate the interactive map), `frontend-design`
- No dedicated skill covers Leaflet — use the docs below.

## Background

The map uses Leaflet with OpenStreetMap tiles. Because Leaflet touches the browser's window and
DOM, it cannot be server-rendered; it must be loaded dynamically, client-side only, inside a client
component. If you don't tell the agent this constraint, it may attempt a server-rendered approach
and waste a loop discovering the problem.

## Steps

1. Before implementing, tell the agent the **constraint** clearly: the map is interactive and
   client-only, and must be loaded dynamically without server rendering. Ask it to plan within
   that constraint.
2. Implement a map with **distinct markers** for your two main entity types, and popups that link
   to the corresponding detail pages.
3. Add a **location picker**: when creating or editing an entity, let the user choose a point on
   the map and capture its coordinates.
4. Integrate the map into the relevant screens without breaking server-first reads elsewhere.
5. Verify interactively: markers appear, popups link correctly, and picking a location stores the
   right coordinates.
6. Reflect on how stating the constraint first changed the agent's approach.

## Success Criteria

- [ ] An interactive map renders with distinct markers for each entity type
- [ ] Marker popups link through to the relevant detail pages
- [ ] A location picker captures coordinates when creating/editing
- [ ] The map loads client-only (dynamic import, no SSR); `npm run build` passes

## References

- Leaflet — Documentation: https://leafletjs.com/reference.html
- React Leaflet — Getting started: https://react-leaflet.js.org/docs/start-introduction/
- Next.js — Lazy loading / dynamic import: https://nextjs.org/docs/app/building-your-application/optimizing/lazy-loading
