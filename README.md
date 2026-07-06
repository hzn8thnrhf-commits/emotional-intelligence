# Samatva

*Equanimity, from the Sanskrit — "samatvam yoga ucyate": evenness of mind is excellence in action (Bhagavad Gita 2.48).*

A private, native iPhone app for building emotional intelligence under real pressure — written for a young executive in London finance, raised in Singapore, managing a team on demanding hours.

## What it does

**Today** — a calm home screen: a 15-second mood check-in ("what's the weather in there?"), your next lesson, quick tools, and a daily line worth keeping (Gita, Marcus Aurelius, Frankl, Rumi).

**Reset** — the app's signature move: a 60-second guided circuit-breaker for hard moments. Pick what's here right now — anger, frustration, helplessness, overwhelm, anxiety — and get three timed steps tuned to that exact state (ride the 90-second wave, name the boundary, choose the next move).

**Learn** — five courses, 22 short lessons (2–4 minutes each), written for your actual life, not a generic wellness audience:

| Course | What it covers |
|---|---|
| **Foundations** | Emotions as data, naming to tame, the 90-second wave, body tells |
| **Heat** | Frustration and anger: the amygdala hijack, STOP protocol, the email rule, clean anger |
| **Ground** | Helplessness → agency: the control map, micro-moves, asking for help without losing face |
| **Presence** | Leading with EQ: emotional contagion, regulating in meetings, SBI feedback, stepping pressure down instead of passing it through |
| **Roots** | Code-switching between cultures, the Sunday call home, friendship on a banker's calendar, rest as a skill |

Many lessons end with an interactive scenario — a realistic moment (an MD dismissing your team's work, an analyst quietly slipping, restructuring rumours) where you choose a response and get honest feedback on it.

**Toolkit** — breathing exercises with a live animation (box, physiological sigh, 4-7-8, coherent 5.5), 5-4-3-2-1 grounding, a guided CBT thought record (situation → feeling + intensity → automatic thought → distortions → evidence for and against → balanced verdict → re-rate), and an end-of-day decompress ritual.

**Reflect** — your mood over the last 14 days, gentle pattern insights ("most of your harder moments land in the evening"), a private journal, and quiet milestones.

## Design principles

- **Frictionless** — a check-in takes 15 seconds; a Reset takes 60. Nothing demands daily attendance.
- **Gamified, lightly** — progress rings, milestones, calm minutes. Deliberately **no streaks** and no guilt mechanics.
- **Uncluttered** — a restrained palette (deep sea teal, warm sand, soft ink), serif headings, generous whitespace, full dark-mode support.
- **Private by design** — everything is stored on-device as local JSON. No account, no cloud, no analytics, no network access at all.

## Running it

### Web app (primary)

`index.html` at the repo root is the app — a single self-contained file with no frameworks, no build step and no server logic. Check-ins, the 60-second Reset, all 22 lessons with scenarios, breathing, grounding, the CBT thought record, decompress, mood chart, insights and milestones. Data persists in the browser's local storage. Day/night mode follows your device by default, with a manual toggle (moon button on Today, or Settings → Appearance).

- **Try it locally:** open `index.html` in any browser, or `python3 -m http.server` and visit `http://localhost:8000`.
- **On your iPhone:** host it anywhere static — enabling GitHub Pages on this repo is enough since it's one file at the root. Open the URL in Safari, then Share → **Add to Home Screen**. It runs full-screen like an app, works offline after first load, and keeps your data on the device.

### Native iOS app (secondary)

A full SwiftUI implementation lives in `Samatva/` for when you want a proper App Store-ready native build. Requirements: Xcode 16+ and iOS 17+.

1. Clone this repo and open `Samatva.xcodeproj` in Xcode.
2. Select your team under *Signing & Capabilities* (automatic signing is preconfigured; the bundle id is `com.devangkabra.samatva`).
3. Pick your iPhone (or a simulator) and press Run.

No dependencies, no package resolution — it's pure SwiftUI plus Apple's Charts framework.

## A note on limits

Samatva is an educational companion, not a medical or mental-health service. If low mood, anger or anxiety are seriously affecting your life, a professional is the right next step — in the UK you can self-refer to NHS Talking Therapies, or call Samaritans on 116 123 at any time.
