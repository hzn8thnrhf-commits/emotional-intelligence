# Samatva

*Equanimity, from the Sanskrit — "samatvam yoga ucyate": evenness of mind is excellence in action (Bhagavad Gita 2.48).*

A private, native iPhone app for building emotional intelligence under real pressure — written for a young executive in London finance, raised in Singapore, managing a team on demanding hours.

## What it does

**Today** — a calm home screen: a 15-second mood check-in with a colour-coded emotion picker — 8 families (red for anger, amber for anxiety, blue for sadness…) expanding to ~70 named emotions, your next lesson, quick tools, and a daily line worth keeping (Gita, Marcus Aurelius, Frankl, Rumi).

**Reset** — the app's signature move: a 60-second guided circuit-breaker for hard moments. Pick what's here right now — anger, frustration, helplessness, overwhelm, anxiety — and get three timed steps tuned to that exact state (ride the 90-second wave, name the boundary, choose the next move).

**For right now** — after a difficult check-in, Today quietly surfaces the one or two tools built for that exact state (anger → Reset or thought record; anxiety → physiological sigh + worry parking; helplessness → the control map).

**Learn** — seven courses, 33 short lessons (2–4 minutes each), written for your actual life, not a generic wellness audience, with a "Suggested for you" path driven by your profile and check-ins, a **Scenario Gym** (15 interactive scenarios about the people who press your buttons — boss, peers, team, clients, family, partner — each revealing the psychological mechanism behind your reaction), and **Test your knowledge** quizzes per course with tracked best scores:

| Course | What it covers |
|---|---|
| **Foundations** | Emotions as data, naming to tame, the 90-second wave, body tells |
| **Heat** | Frustration and anger: the amygdala hijack, STOP protocol, the email rule, clean anger |
| **Ground** | Helplessness → agency: the control map, micro-moves, asking for help without losing face |
| **Presence** | Leading with EQ: emotional contagion, regulating in meetings, SBI feedback, stepping pressure down instead of passing it through |
| **Roots** | Code-switching between cultures, the Sunday call home, friendship on a banker's calendar, rest as a skill |
| **Kin** | The family relationships that hurt: seeing the narcissistic pattern clearly, refusing the unwinnable game, boundaries that don't need their agreement, guilt and grief, reclaiming your ambition |
| **Steel** | Endurance for the long game: stress-recovery cycles, sleep as an edge, the inner critic, defusion, values |

Many lessons end with an interactive scenario — a realistic moment (an MD dismissing your team's work, an analyst quietly slipping, restructuring rumours) where you choose a response and get honest feedback on it.

**Audio & voice** — spoken guidance throughout, using the device's built-in speech engine (free, on-device, private — no downloads, nothing sent anywhere): breathing exercises and Resets speak their cues, every lesson has a "Listen" button that reads it aloud, and four guided meditations (Arrive · Before the storm · Leaves on a stream · The evening line) play as timed, spoken scripts. Toggle in Settings → Voice guidance.

**Worth keeping** — light spaced repetition: one takeaway from your completed lessons resurfaces on Today each day, so lessons compound instead of fading.

**Toolkit** — organised around the moment: *before* (Prepare — a 90-second pre-meeting primer: outcome, likely spike, pre-decided response, one breath), *during* (animated breathing — box, physiological sigh, 4-7-8, coherent 5.5 — and 5-4-3-2-1 grounding), and *after* (a guided **CBT engine** — a seven-step thought-record wizard that detects likely cognitive distortions from your wording, asks targeted Socratic questions per distortion, and offers balanced-thought starters; Say it cleanly — a difficult-conversation script builder; Worry parking — park a worry, review it when the facts land, and let the ledger recalibrate your forecasting; and an end-of-day decompress).

**Reflect** — your mood over the last 14 days, a cross-tool insight engine (your most frequent cognitive distortion with the lesson aimed at it, average intensity drop across thought records, what percentage of parked worries never happened, which emotion travels with which trigger), a private journal, and quiet milestones.

## How it adapts to you

- **Profile** — at onboarding (and any time in Settings) you tell it your world: corporate finance, managing a team, long hours, high-stakes meetings, complicated family, distance from home. This drives the "Suggested for you" lessons on Learn.
- **Check-ins steer the day** — a difficult check-in surfaces a "For right now" card on Today pointing at the tools built for that state; a hard moment tagged *Family* routes to the Kin course.
- **The insight engine learns your patterns** — your most frequent cognitive distortion (with the lesson aimed at it), the average intensity drop across your thought records, how often your parked worries actually happened, your dominant Reset trigger, and which emotion travels with which context.

All of this is rule-based and runs entirely on-device — nothing is sent anywhere.

## Design principles

- **Frictionless** — a check-in takes 15 seconds; a Reset takes 60. Nothing demands daily attendance.
- **Gamified, lightly** — progress rings, milestones, calm minutes. Deliberately **no streaks** and no guilt mechanics.
- **Uncluttered** — a calm-tech design system — cool-mist neutrals with a deep-aqua accent, SF Pro display typography, layered soft shadows, a frosted-glass tab bar, staggered entrance animations and tactile press feedback, full dark-mode support.
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
