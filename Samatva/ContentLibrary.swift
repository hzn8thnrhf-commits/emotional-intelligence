import SwiftUI

// The full curriculum. Written for a young executive in London finance,
// raised in Singapore — the examples deliberately live in that world.
enum ContentLibrary {

    static let quotes: [(text: String, source: String)] = [
        ("Samatvam yoga ucyate — equanimity is excellence in action.", "Bhagavad Gita 2.48"),
        ("You have power over your mind, not outside events. Realise this, and you will find strength.", "Marcus Aurelius"),
        ("Between stimulus and response there is a space. In that space is our power to choose.", "Viktor Frankl"),
        ("The quieter you become, the more you are able to hear.", "Rumi"),
        ("Feelings come and go like clouds in a windy sky. Conscious breathing is my anchor.", "Thich Nhat Hanh"),
        ("He who angers you conquers you.", "Elizabeth Kenny"),
        ("Nothing gives one person so much advantage over another as to remain always cool and unruffled.", "Thomas Jefferson"),
        ("You can't stop the waves, but you can learn to surf.", "Jon Kabat-Zinn"),
        ("The obstacle is the way.", "Marcus Aurelius"),
        ("Slow is smooth, smooth is fast.", "Old operator's maxim"),
    ]

    static let courses: [Course] = [foundations, heat, ground, presence, roots]

    // MARK: - Course 1 · Foundations

    static let foundations = Course(
        id: "foundations",
        title: "Foundations",
        subtitle: "Learn to read your own weather",
        symbol: "cloud.sun",
        tint: Theme.teal,
        lessons: [
            Lesson(
                id: "f1",
                title: "The sharpest people feel more, not less",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "The myth of the ice-cold operator",
                        body: "Finance culture prizes the unflappable. But \u{201C}unflappable\u{201D} done badly is just suppression — and suppression is expensive. Studies of traders show that those who ignore their emotions don't trade better; they blow up more spectacularly. The best performers feel everything and use it as information."
                    ),
                    LessonSection(
                        heading: "Emotions are data, not noise",
                        body: "Every emotion is your brain's fast summary of a situation: anger flags a violated boundary, anxiety flags an unpriced risk, helplessness flags a control problem. You already read markets for signal. This course teaches you to read yourself the same way — quickly, without drama, and then decide what to do."
                    ),
                    LessonSection(
                        heading: "What this app will and won't do",
                        body: "Samatva won't make you feel nothing. It will shorten the time between feeling something and understanding it, and widen the gap between feeling and reacting. That gap — Viktor Frankl's \u{201C}space between stimulus and response\u{201D} — is where composure lives."
                    ),
                ],
                takeaways: [
                    "Suppressing emotion degrades judgement; reading it sharpens judgement.",
                    "Each emotion carries a specific message about the situation.",
                    "The goal is a wider gap between feeling and reacting — not feeling less.",
                ],
                reflection: "Think of the last time you 'kept it together' at work but paid for it later. What did keeping it together actually cost?",
                scenario: Scenario(
                    prompt: "It's 7pm. A deal document comes back from legal riddled with errors and the client call is at 8am. You feel heat rising in your chest. What's the most emotionally intelligent first move?",
                    options: [
                        ScenarioOption(text: "Push the feeling aside — no time for it, just fix the document.", isBest: false, feedback: "Suppression works for about an hour, then leaks out — usually at whoever messages you next. The feeling doesn't need an hour; it needs ten seconds of acknowledgement."),
                        ScenarioOption(text: "Notice: 'That's anger. It's telling me a standard was violated and I'm time-pressed.' Then plan.", isBest: true, feedback: "Exactly. Naming it takes ten seconds, drops its intensity, and turns it into information: the anger is about a standard and a deadline — both of which are solvable problems."),
                        ScenarioOption(text: "Fire off a sharp email to legal so they know this isn't acceptable.", isBest: false, feedback: "Maybe deserved — but sent at peak anger it will be 20% too hot, and you'll spend tomorrow managing the fallout instead of the client."),
                    ]
                )
            ),
            Lesson(
                id: "f2",
                title: "Name it to tame it",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "The label lowers the volume",
                        body: "Neuroscience calls it affect labelling: putting a feeling into words measurably reduces amygdala activity. Saying — even silently — \u{201C}this is frustration\u{201D} moves the experience from the alarm system to the part of the brain that can actually do something about it. It feels almost too simple. It works anyway."
                    ),
                    LessonSection(
                        heading: "Get more precise than 'stressed'",
                        body: "\u{201C}Stressed\u{201D} is like saying a portfolio is \u{201C}down\u{201D} — true, but useless for action. Is it frustration (blocked goal)? Anxiety (uncertain threat)? Helplessness (no control)? Resentment (unfair load)? Each has a different fix. Psychologists call this emotional granularity, and people who have it recover faster and make better decisions under pressure."
                    ),
                    LessonSection(
                        heading: "The one-line check-in",
                        body: "This is why Samatva's check-in takes fifteen seconds, not five minutes. One honest label, logged. Over weeks, the pattern becomes visible — which meetings, which hours, which people. You can't manage what you never name."
                    ),
                ],
                takeaways: [
                    "Naming an emotion reduces its grip — measurably.",
                    "Precision matters: frustration, anxiety, and helplessness need different responses.",
                    "Fifteen honest seconds a day builds a map of your patterns.",
                ],
                reflection: "What word do you reach for when someone asks how you are? What's the more precise word underneath it today?",
                scenario: nil
            ),
            Lesson(
                id: "f3",
                title: "The 90-second wave",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "Chemistry has a half-life",
                        body: "When something triggers you, a chemical surge — adrenaline, cortisol — floods the body. Here's the part nobody tells you: physiologically, that surge washes through in about 90 seconds. If you're still furious ten minutes later, it's because your thoughts keep re-triggering the wave — replaying the comment, drafting the comeback."
                    ),
                    LessonSection(
                        heading: "Ride it, don't feed it",
                        body: "The skill is to let the first wave pass without adding fuel. Feel the heat, the tight jaw, the fast pulse — and just observe it like a print moving on a screen, without opening the mental argument. Ninety seconds of watching beats thirty minutes of stewing."
                    ),
                    LessonSection(
                        heading: "Where the Reset button comes in",
                        body: "Samatva's Reset is built around this: when something hits, open it, and it walks you through the 90 seconds — breath, body, label — so the wave passes through you instead of into your next meeting."
                    ),
                ],
                takeaways: [
                    "The chemical part of an emotion lasts about 90 seconds.",
                    "Rumination — replaying and rehearsing — is what keeps it alive.",
                    "Ride the first wave without feeding it; then decide.",
                ],
                reflection: "When you stay angry for hours, what's the loop your mind replays? What would it be like to let the first wave pass just once?",
                scenario: nil
            ),
            Lesson(
                id: "f4",
                title: "Your body is the dashboard",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "The body knows first",
                        body: "By the time you consciously think \u{201C}I'm annoyed,\u{201D} your body has known for minutes: shoulders creeping toward ears, jaw tight, breath gone shallow, that specific heat behind the sternum. Interoception — reading these internal signals — is trainable, and it's your earliest warning system."
                    ),
                    LessonSection(
                        heading: "Find your tell",
                        body: "Every trader has a tell; so does every temper. Maybe yours is rereading the same email three times, typing harder, or going very quiet in meetings. Identify your two or three reliable tells and they become tripwires — catch the emotion at 3/10 instead of 8/10, when it's still cheap to handle."
                    ),
                    LessonSection(
                        heading: "The desk scan",
                        body: "Three times a day — coffee, lunch, the 4pm slump — run a ten-second scan: jaw, shoulders, breath, stomach. Release what's held. You're not meditating; you're checking the dashboard the way you'd glance at a risk screen."
                    ),
                ],
                takeaways: [
                    "Your body registers emotion before your conscious mind does.",
                    "Know your two or three physical 'tells' and treat them as tripwires.",
                    "A ten-second body scan, three times a day, catches trouble early.",
                ],
                reflection: "Where does pressure show up first in your body? Jaw, shoulders, chest, stomach — what's your tell?",
                scenario: nil
            ),
        ]
    )

    // MARK: - Course 2 · Heat (frustration & anger)

    static let heat = Course(
        id: "heat",
        title: "Heat",
        subtitle: "Frustration and anger, handled",
        symbol: "flame",
        tint: Theme.ember,
        lessons: [
            Lesson(
                id: "h1",
                title: "What anger is actually for",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "Anger is a boundary alarm",
                        body: "Anger fires when something you value is violated — your time, your standards, your team, your sense of fairness. That makes it useful: it tells you exactly what you care about. The problem is never the signal; it's the untranslated signal, delivered raw to a colleague at volume."
                    ),
                    LessonSection(
                        heading: "Frustration is blocked progress",
                        body: "Frustration is anger's cousin: a goal you're driving toward, blocked — by a slow approval chain, a flaky system, a person who won't decide. In a demanding job, frustration is structural, not personal. Expecting a frictionless day in finance is like expecting a flat vol surface. The question isn't how to never feel it; it's what to do in the first minute."
                    ),
                    LessonSection(
                        heading: "Translate before transmitting",
                        body: "The practice: when heat rises, ask \u{201C}what boundary or goal is this about?\u{201D} \u{201C}I'm furious at legal\u{201D} translates to \u{201C}I care about quality and I'm time-pressed.\u{201D} That sentence you can say out loud in a meeting. The untranslated version you can't."
                    ),
                ],
                takeaways: [
                    "Anger marks a violated boundary; frustration marks a blocked goal.",
                    "The signal is useful; the raw transmission is what causes damage.",
                    "Ask: what is this heat actually about? Then say that instead.",
                ],
                reflection: "What do your last three flashes of anger have in common? What value of yours were they defending?",
                scenario: nil
            ),
            Lesson(
                id: "h2",
                title: "The hijack",
                minutes: 4,
                sections: [
                    LessonSection(
                        heading: "Why smart people say dumb things at 9pm",
                        body: "Under acute stress, the amygdala can effectively hijack the prefrontal cortex — the part of you that models consequences, reads the room, and remembers that the person opposite you controls your bonus. In hijack mode your IQ is temporarily unavailable. Everyone's is. The skill isn't preventing the hijack; it's recognising it and refusing to make decisions inside it."
                    ),
                    LessonSection(
                        heading: "Your vulnerability multipliers",
                        body: "The hijack triggers far more easily when you're depleted. The checklist is HALT: Hungry, Angry (already), Lonely, Tired. On a 14-hour day you may be all four. That snappish reply at 10pm isn't your personality — it's your physiology. Which means the fix is often boring: eat, walk, sleep, call someone who knew you before the job."
                    ),
                    LessonSection(
                        heading: "Never trade during a hijack",
                        body: "Make one rule and keep it absolutely: no irreversible action while flooded. No sent email, no verdict on a direct report, no 'quick word' with a stakeholder. The queue can hold for ten minutes. Nothing written in the flood reads well in the morning."
                    ),
                ],
                takeaways: [
                    "Acute stress temporarily disconnects your best thinking. For everyone.",
                    "HALT — hungry, angry, lonely, tired — makes hijacks far more likely.",
                    "One iron rule: no irreversible actions while flooded.",
                ],
                reflection: "What time of day, and in what state, do your worst moments happen? What does that tell you about HALT?",
                scenario: Scenario(
                    prompt: "A managing director dismisses your team's analysis in front of everyone with a wave of the hand: 'This is half-baked.' You feel the flood — hot face, fast heart. The meeting is still going. What now?",
                    options: [
                        ScenarioOption(text: "Defend the work immediately and firmly — silence looks like agreement.", isBest: false, feedback: "Anything said in the first 30 seconds of a flood comes out sharper than intended, and now it's you versus an MD in public. The work can be defended better in five minutes than in five seconds."),
                        ScenarioOption(text: "Breathe out slowly, note 'that's anger — my team was attacked', and say: 'I'd push back on half-baked — let me walk you through the assumptions after this.'", isBest: true, feedback: "You bought your prefrontal cortex three seconds, protected your team on the record, and moved the fight to ground where evidence — not volume — decides it."),
                        ScenarioOption(text: "Say nothing, then vent to your team afterwards about how impossible the MD is.", isBest: false, feedback: "Your team watched the work get dismissed and then watched you absorb it. Venting downward transfers your flood to people who can do even less about it than you."),
                    ]
                )
            ),
            Lesson(
                id: "h3",
                title: "The STOP protocol",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "S — Stop. T — Take a breath.",
                        body: "When you notice the tell, stop — mid-sentence if needed; \u{201C}give me a second\u{201D} is a complete sentence. Then one slow breath with a long exhale. The extended exhale activates the parasympathetic brake directly; it's the fastest legal intervention on your own nervous system."
                    ),
                    LessonSection(
                        heading: "O — Observe.",
                        body: "Three quick observations: What's in my body? (heat, tight chest.) What's the emotion? (frustration, edging to anger.) What's the story I'm telling? (\u{201C}they don't respect my time.\u{201D}) That last one matters — the story is usually the accelerant, and it's usually only one of several possible readings."
                    ),
                    LessonSection(
                        heading: "P — Proceed on purpose.",
                        body: "Now choose: address it, park it, or drop it. All three are legitimate. What was never on the menu was the auto-reply your flooded brain drafted at second zero. STOP takes about fifteen seconds and works in an open-plan office, on a call, or mid-meeting. Practise it on small annoyances — the delayed train, the double-booked room — so it's there for the big ones."
                    ),
                ],
                takeaways: [
                    "Stop, Take a breath, Observe, Proceed — about fifteen seconds.",
                    "The long exhale is the fastest way to slow your own system.",
                    "The story you're telling is the accelerant. Question it first.",
                ],
                reflection: "What small daily annoyance could you use as STOP practice this week?",
                scenario: nil
            ),
            Lesson(
                id: "h4",
                title: "Discharge, don't suppress — and don't 'vent'",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "The venting myth",
                        body: "Punching pillows and ranting to colleagues feels productive but research is blunt: rehearsing anger deepens it. Each retelling re-runs the wave and carves the groove deeper. Venting isn't release — it's practice."
                    ),
                    LessonSection(
                        heading: "What actually discharges the charge",
                        body: "The stress chemicals want physical completion, not narrative. A fast walk around the block, two flights of stairs, twenty push-ups, a hard gym session after work — movement metabolises the cortisol. Cold water on the wrists and face works surprisingly well between meetings. Write the furious version down once — then close the notebook; that's discharge. Reading it to three people is venting."
                    ),
                    LessonSection(
                        heading: "The email rule",
                        body: "Angry email? Write it with the To: field empty. Say everything. Then leave it in drafts until after your next meal. Nine times out of ten you'll send a shorter, colder, far more effective version — or nothing, which is sometimes the strongest move available."
                    ),
                ],
                takeaways: [
                    "Venting rehearses anger; it doesn't release it.",
                    "Movement, cold water, and one private write-out actually discharge it.",
                    "Angry emails: empty To: field, and nothing sends before your next meal.",
                ],
                reflection: "What's your current discharge method — and is it discharge, or is it rehearsal?",
                scenario: nil
            ),
            Lesson(
                id: "h5",
                title: "Clean anger",
                minutes: 4,
                sections: [
                    LessonSection(
                        heading: "Composed doesn't mean silent",
                        body: "There's a failure mode on the other side of shouting: swallowing everything to seem professional, then leaking it as sarcasm, cc'd escalations, or sudden coldness. If you grew up where open disagreement with seniors felt disrespectful, this route is extra tempting. But unexpressed anger doesn't disappear — it compounds, and it collects interest."
                    ),
                    LessonSection(
                        heading: "The clean formula",
                        body: "Clean anger is specific, unheated, and aimed at behaviour, not character: \u{201C}When the deck came back at 11pm with the numbers unchecked \u{2192} I was frustrated \u{2192} because I care that we're accurate in front of the client \u{2192} next time, flag it by 6 if you're stuck.\u{201D} Situation, feeling, value, request. No verdicts on anyone's competence or character."
                    ),
                    LessonSection(
                        heading: "Deliver it cool",
                        body: "Timing is the multiplier: after the wave has passed, in private, once. Said calmly within a day, that script builds more respect than either the explosion or the swallow. People trust leaders whose displeasure is precise, predictable, and proportionate."
                    ),
                ],
                takeaways: [
                    "Swallowed anger leaks — as sarcasm, coldness, or escalation.",
                    "Clean formula: situation \u{2192} feeling \u{2192} value \u{2192} request.",
                    "Deliver after the wave, in private, once.",
                ],
                reflection: "Is there a conversation you've been swallowing? What would the clean, four-part version sound like?",
                scenario: Scenario(
                    prompt: "A peer keeps committing your team to deadlines in meetings you're not in. It's the third time. You're past annoyed. What's the clean-anger move?",
                    options: [
                        ScenarioOption(text: "Mention it lightly with a laugh so it doesn't get awkward: 'Ha, stop selling my team's weekends!'", isBest: false, feedback: "Humour-wrapped anger is still anger — but now it's deniable and easy to ignore. Third-time patterns deserve a direct sentence, not a joke."),
                        ScenarioOption(text: "Privately: 'When my team was committed to Friday without me in the room — third time now — I was genuinely frustrated. I need to be in the loop before commitments. Can we agree on that?'", isBest: true, feedback: "Specific, factual, states the feeling once without heat, ends with a clear request. Hard to argue with, easy to respect."),
                        ScenarioOption(text: "Escalate to your shared boss with a documented timeline of all three incidents.", isBest: false, feedback: "Escalating before a direct conversation reads as political warfare and burns the relationship. Escalation is the second move if the direct request fails — not the first."),
                    ]
                )
            ),
        ]
    )

    // MARK: - Course 3 · Ground (helplessness → agency)

    static let ground = Course(
        id: "ground",
        title: "Ground",
        subtitle: "From helplessness to agency",
        symbol: "mountain.2",
        tint: Theme.moss,
        lessons: [
            Lesson(
                id: "g1",
                title: "The helplessness trap",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "Where helplessness comes from",
                        body: "Helplessness is the feeling that outcomes are disconnected from effort. Finance manufactures it in bulk: markets move against you for reasons that have nothing to do with your work; decisions land from three levels up; a reorg redraws your world overnight. Psychologist Martin Seligman showed that with enough uncontrollable stress, we stop trying even where we do have control. That's the trap — the feeling spreads beyond the facts."
                    ),
                    LessonSection(
                        heading: "The trap generalises; reality doesn't",
                        body: "One genuinely uncontrollable quarter and the mind whispers that everything is uncontrollable — your hours, your career, your mood. Notice that move. Helplessness is accurate about specific things and almost always wrong as a general theory of your life."
                    ),
                    LessonSection(
                        heading: "The antidote is precision",
                        body: "The way out isn't positive thinking — it's an audit. What here is actually mine to move? The next lesson gives you the tool. For now, just catch the moment the feeling tries to go from \u{201C}I can't control this decision\u{201D} to \u{201C}I can't control anything.\u{201D}"
                    ),
                ],
                takeaways: [
                    "Helplessness = the felt disconnect between effort and outcome.",
                    "It generalises beyond the facts — one uncontrollable thing colours everything.",
                    "The antidote is a precise audit of what is and isn't yours to move.",
                ],
                reflection: "Where in your work does helplessness show up most? Is the feeling precise, or has it spread?",
                scenario: nil
            ),
            Lesson(
                id: "g2",
                title: "The control map",
                minutes: 4,
                sections: [
                    LessonSection(
                        heading: "Three circles",
                        body: "Take any situation that's eating you and sort every piece into three circles. Control: your preparation, your responses, your hours of sleep, what you escalate, how you communicate. Influence: your boss's view of you, your team's morale, the client's mood, promotion decisions. Concern: markets, reorgs, the economy, other people's temperaments."
                    ),
                    LessonSection(
                        heading: "The energy audit",
                        body: "Now the uncomfortable question: where does your worry-time actually go? For most people under pressure, 80% of mental energy pools in the Concern circle — precisely where it can achieve nothing. Stoics called this the dichotomy of control; it predates modern psychology by two millennia because it works."
                    ),
                    LessonSection(
                        heading: "Move one ring inward",
                        body: "The practice: for anything in Concern, find its handle in Influence or Control. Can't control the reorg \u{2192} can control being visibly excellent and having your CV honest. Can't control the MD's temper \u{2192} can control your preparation and how you time your asks. Every worry either has a handle you can grip, or it doesn't — in which case it's weather, and you dress for weather; you don't argue with it."
                    ),
                ],
                takeaways: [
                    "Sort any mess into Control / Influence / Concern.",
                    "Energy pooled in the Concern circle achieves nothing and costs everything.",
                    "For each concern, find its handle one ring inward — or accept it as weather.",
                ],
                reflection: "Take today's biggest worry. Which circle is it in? What's its handle one ring inward?",
                scenario: Scenario(
                    prompt: "Rumours of restructuring are everywhere. Your team keeps asking you what will happen; you don't know, and your own role may be at risk. You notice yourself refreshing news and Slack constantly. Best use of your energy?",
                    options: [
                        ScenarioOption(text: "Work your network hard for intel so you're never surprised.", isBest: false, feedback: "Some intel-gathering is reasonable, but rumour-chasing is Concern-circle activity dressed as action — it feeds the anxiety loop and produces mostly noise."),
                        ScenarioOption(text: "Map it: Control — my performance, my CV, honesty with my team about what I know and don't. Influence — how leadership sees my team's value. Concern — the decision itself. Act on the first two.", isBest: true, feedback: "This is the control map doing its job. Notice it also gives your team something honest and steady to hold onto — which is itself an Influence-circle move."),
                        ScenarioOption(text: "Reassure the team it will all be fine so morale holds.", isBest: false, feedback: "Promising what you can't control trades this week's comfort for your long-term credibility. 'Here's what I know, here's what I don't, here's what we control' is stronger and still steadying."),
                    ]
                )
            ),
            Lesson(
                id: "g3",
                title: "Micro-moves",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "Agency compounds like interest",
                        body: "Helplessness is broken by evidence, not affirmations. Each small completed action — one email sent, one decision made, one desk cleared — is a data point proving effort still connects to outcome. The size of the move barely matters; the completion does. Psychologists call it mastery experience. You'd call it marking positions to market."
                    ),
                    LessonSection(
                        heading: "Shrink until it's doable now",
                        body: "Overwhelmed by the whole? Shrink the next move until resistance disappears. Not \u{201C}fix the model\u{201D} — \u{201C}open the file.\u{201D} Not \u{201C}resolve the conflict\u{201D} — \u{201C}draft one sentence asking for 15 minutes.\u{201D} The absurdly small first step isn't a trick; it's how stuck systems restart."
                    ),
                    LessonSection(
                        heading: "End the day on a completion",
                        body: "One habit with outsized returns: never end the workday mid-failure. Close with one small completed thing — a tidy handover note, tomorrow's first task written down, one email cleared. Your brain files the day by its ending. Give it a completion to file."
                    ),
                ],
                takeaways: [
                    "Agency is rebuilt by evidence: small, completed actions.",
                    "Shrink the next step until the resistance disappears.",
                    "End every day on a completion, however small.",
                ],
                reflection: "What's one thing you've been circling for days? What's its absurdly small first step?",
                scenario: nil
            ),
            Lesson(
                id: "g4",
                title: "Asking for help isn't losing face",
                minutes: 4,
                sections: [
                    LessonSection(
                        heading: "The lone-hero tax",
                        body: "If you were raised to equate self-sufficiency with worth — common where academic and career excellence carried family honour — asking for help can feel like public failure. So the load grows silently until something cracks. But watch actual senior leaders: they ask for help constantly. They just call it 'leveraging resources' and 'aligning stakeholders.'"
                    ),
                    LessonSection(
                        heading: "Reframe: asking is an executive skill",
                        body: "A precise, early ask signals judgement, not weakness: you sized the problem, identified what's missing, and moved before it became expensive. What actually damages reputations is the surprise blow-up in week six that a five-minute conversation in week one would have prevented."
                    ),
                    LessonSection(
                        heading: "Make the ask specific",
                        body: "Weak: \u{201C}I'm drowning.\u{201D} Strong: \u{201C}I need either a day's extension or one analyst for two days — which works better for you?\u{201D} Specific asks are easy to grant and read as competence. And the same applies off the desk: telling one friend how the quarter actually felt is the personal-life version, and it's just as much a skill."
                    ),
                ],
                takeaways: [
                    "Silent overload isn't strength; it's deferred, compounding risk.",
                    "Early, precise asks read as judgement — surprise blow-ups read as failure.",
                    "Make asks specific and optioned: easy to grant, easy to respect.",
                ],
                reflection: "What are you currently carrying alone that a specific, five-minute ask could halve?",
                scenario: nil
            ),
        ]
    )

    // MARK: - Course 4 · Presence (leading with EQ)

    static let presence = Course(
        id: "presence",
        title: "Presence",
        subtitle: "Composure as a leadership tool",
        symbol: "person.2",
        tint: Theme.indigo,
        lessons: [
            Lesson(
                id: "p1",
                title: "Your mood is public infrastructure",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "Emotional contagion is real and fast",
                        body: "Humans sync moods automatically — and the syncing runs down the hierarchy far more strongly than up. As the manager, your Tuesday-morning stress becomes your team's Tuesday-morning stress within an hour, without a word said. You stopped having fully private moods the day you got direct reports."
                    ),
                    LessonSection(
                        heading: "They're reading you all day",
                        body: "Your team studies your face on calls, your punctuation on Slack, the speed of your replies. A terse \u{201C}fine.\u{201D} from you at 9am can cost a junior analyst a whole anxious morning. This isn't a reason to perform fake positivity — it's a reason to regulate for real, because the returns are multiplied by headcount."
                    ),
                    LessonSection(
                        heading: "Steady is the gift",
                        body: "The most valuable thing a leader under pressure transmits is regulated presence: urgency without panic, seriousness without doom. \u{201C}This is hard, and we can handle it\u{201D} — said with a settled nervous system — is worth more to a team than any pep talk. Every tool in this app quietly serves that sentence."
                    ),
                ],
                takeaways: [
                    "Moods propagate down hierarchies fast and silently.",
                    "Your team reads your signals all day; small tells have big costs.",
                    "Regulated presence — calm urgency — is the leader's real gift.",
                ],
                reflection: "What does your team most likely 'catch' from you in a bad week? What would you want them to catch instead?",
                scenario: nil
            ),
            Lesson(
                id: "p2",
                title: "Regulate before you respond",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "Buy three seconds, own the room",
                        body: "In tense meetings, the person who can insert three seconds between hearing and speaking has an unfair advantage. Tactics that look natural: take a sip of water; write the point down; repeat their statement back — \u{201C}so your concern is timing\u{201D} — which both buys time and makes the other person feel heard. Nobody knows you're regulating. That's the point."
                    ),
                    LessonSection(
                        heading: "The question is a fire-break",
                        body: "When challenged aggressively, a genuine question beats a fast defence: \u{201C}What would you need to see to be comfortable?\u{201D} \u{201C}Which assumption bothers you most?\u{201D} Questions shift you from defending to examining, drop the temperature, and often reveal the challenge was thinner than it sounded."
                    ),
                    LessonSection(
                        heading: "Call the break",
                        body: "If a meeting is genuinely running hot, naming it is senior behaviour: \u{201C}Let's take five and come back to this with the numbers.\u{201D} Composure isn't never feeling heat — it's being the person in the room who notices the temperature and has the standing to adjust it."
                    ),
                ],
                takeaways: [
                    "Three seconds of pause is an advantage nobody can see.",
                    "A genuine question de-escalates faster than a fast defence.",
                    "Naming the temperature and calling a break is senior behaviour.",
                ],
                reflection: "In your last heated meeting, what would three extra seconds have changed?",
                scenario: nil
            ),
            Lesson(
                id: "p3",
                title: "Feedback without heat",
                minutes: 4,
                sections: [
                    LessonSection(
                        heading: "Anger corrupts the message",
                        body: "Feedback delivered hot achieves the opposite of its intent: the recipient's threat response spikes, and all processing goes to survival, not learning. They'll remember your tone for years and the content for minutes. If you're still charged, you're not ready to deliver — that's what the Reset is for."
                    ),
                    LessonSection(
                        heading: "SBI: situation, behaviour, impact",
                        body: "The clean structure: Situation (\u{201C}in Thursday's client call\u{201D}), Behaviour (\u{201C}the sensitivity table had last quarter's rates\u{201D}), Impact (\u{201C}the client caught it, and it dented our credibility in the room\u{201D}). No character verdicts — not \u{201C}careless\u{201D}, not \u{201C}sloppy\u{201D}. Behaviour is fixable; character accusations just get defended."
                    ),
                    LessonSection(
                        heading: "Then close the loop forward",
                        body: "End with the future, jointly owned: \u{201C}What would make sure the final numbers get a second pass?\u{201D} People rise to being treated as the solution. And deliver praise with the same SBI precision — specific praise is fuel; vague praise is noise."
                    ),
                ],
                takeaways: [
                    "Hot delivery triggers defence, not learning.",
                    "SBI: specific situation, observable behaviour, real impact — no character verdicts.",
                    "Close forward: make them co-owner of the fix. Praise with the same precision.",
                ],
                reflection: "Think of feedback you need to give. Draft it silently as SBI. What changed from the version in your head?",
                scenario: Scenario(
                    prompt: "Your strongest analyst has been quietly missing internal deadlines for three weeks. Yesterday it caused you to look unprepared in front of your MD. You're annoyed and disappointed. How do you open the conversation?",
                    options: [
                        ScenarioOption(text: "'You're my best analyst, but lately you're letting me down and it made me look bad yesterday.'", isBest: false, feedback: "'Letting me down' is a character verdict wearing feedback's clothes, and leading with your image makes it about you. You'll get an apology and a defensive shell — not information or change."),
                        ScenarioOption(text: "'Over the last three weeks the Tuesday cuts have landed late, and yesterday it left me answering the MD without the numbers. That's unlike you — what's going on?'", isBest: true, feedback: "Specific situation and behaviour, honest impact, and then — crucially — a genuine question. Three weeks of uncharacteristic slipping usually has a cause worth knowing: burnout, a home situation, a hidden blocker."),
                        ScenarioOption(text: "Say nothing yet — they're your best performer and you don't want to demotivate them. Watch another two weeks.", isBest: false, feedback: "Three weeks of pattern plus a real impact is past the watching stage. Silence now means the eventual conversation happens at week eight, angrier, with more damage banked — and they'd have wanted to know sooner."),
                    ]
                )
            ),
            Lesson(
                id: "p4",
                title: "Pressure from above",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "You are the transformer, not the wire",
                        body: "A manager's core physics problem: pressure arrives from above at high voltage, and your job is to step it down — pass through the urgency and the facts, filter out the panic and the heat. Leaders who forward pressure raw ('the MD is furious, everything by Monday') get burnt-out teams. Leaders who absorb it silently get ulcers. Transform it: \u{201C}Priorities changed above us. Here's what actually needs to move, in what order.\u{201D}"
                    ),
                    LessonSection(
                        heading: "Manage up with the same EQ",
                        body: "Your seniors are also stressed humans with amygdalas. Time your asks after their storms, not during. Bring problems with options attached, never bare. And when a senior is heated at you, remember the contagion lesson in reverse: their heat is usually about their pressure, not your worth. You can decline to absorb it personally while still acting on the content."
                    ),
                    LessonSection(
                        heading: "Protect the boundary that protects the team",
                        body: "Sometimes stepping pressure down means a respectful push-back up: \u{201C}We can do all three by Friday at draft quality, or the top two properly — which serves you better?\u{201D} That sentence, delivered calmly, is what senior people themselves do. It's also how they spot who's ready for the next level."
                    ),
                ],
                takeaways: [
                    "Step pressure down: pass urgency and facts, filter panic and heat.",
                    "Time asks around your seniors' storms; bring options, not bare problems.",
                    "A calm, optioned push-back up is a senior move — and gets read as one.",
                ],
                reflection: "When pressure last arrived from above, did you pass it through raw, absorb it silently, or transform it?",
                scenario: nil
            ),
            Lesson(
                id: "p5",
                title: "Demanding and safe — both",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "Safety isn't softness",
                        body: "Psychological safety — the shared belief that speaking up won't be punished — is the strongest known predictor of team performance, including in high-pressure environments. It is not lowered standards. The best desks are both: brutal about the work, safe for the people. Errors get dissected; people don't."
                    ),
                    LessonSection(
                        heading: "Your reaction to bad news sets the price of truth",
                        body: "Every time someone brings you a mistake or a risk early, your face in that moment sets the price of the next warning. React with heat and the team learns to sit on problems until they explode. React with \u{201C}good catch — what do we do?\u{201D} and you've bought yourself an early-warning system money can't buy."
                    ),
                    LessonSection(
                        heading: "Own your misses out loud",
                        body: "The single fastest safety-builder: admit your own errors plainly. \u{201C}I called that wrong — here's what I'd do differently.\u{201D} From a leader who also holds a hard standard, that sentence doesn't reduce respect; it multiplies it, and it licenses honesty all the way down."
                    ),
                ],
                takeaways: [
                    "High standards and psychological safety aren't opposites — the best teams have both.",
                    "Your reaction to bad news sets the price of the next early warning.",
                    "Admitting your own misses out loud licenses honesty downward.",
                ],
                reflection: "Would your team tell you about a serious mistake on day one, or day ten? What's your evidence?",
                scenario: nil
            ),
        ]
    )

    // MARK: - Course 5 · Roots (life beyond the desk)

    static let roots = Course(
        id: "roots",
        title: "Roots",
        subtitle: "Identity, family, and a life outside work",
        symbol: "tree",
        tint: Theme.plum,
        lessons: [
            Lesson(
                id: "r1",
                title: "Two homes, two codes",
                minutes: 4,
                sections: [
                    LessonSection(
                        heading: "The switching load is real",
                        body: "Growing up South Asian in Singapore, studying and working in Britain — you run several cultural operating systems: one for the trading floor, one for the phone call home, one for old friends, each with different rules about directness, deference, humour, and what feelings are showable. Code-switching is a genuine skill. It also has a genuine metabolic cost that mostly goes unacknowledged."
                    ),
                    LessonSection(
                        heading: "Name the switch, drop the verdict",
                        body: "The exhaustion after certain dinners or calls isn't a character flaw — it's switching cost. And notice the quiet self-criticism that can ride along: too Asian for one room, too Westernised for another. Third-culture research is clear that the richness runs the other way: you have more registers, more empathy range, more ways to read a room than the single-culture people around you."
                    ),
                    LessonSection(
                        heading: "Keep one no-switch zone",
                        body: "Protect at least one context where no performance is required — a friend who knew you before the job, a cousin, a group where every version of you is admissible. That's not a luxury. For someone who switches all day, it's infrastructure, and it's worth scheduling like a client meeting."
                    ),
                ],
                takeaways: [
                    "Code-switching is a skill with a real, unacknowledged energy cost.",
                    "Multiple cultural registers are range, not inauthenticity.",
                    "Maintain one no-switch zone and treat it as infrastructure.",
                ],
                reflection: "Where in your life do you switch the least? When did you last spend time there?",
                scenario: nil
            ),
            Lesson(
                id: "r2",
                title: "The Sunday call",
                minutes: 4,
                sections: [
                    LessonSection(
                        heading: "Love arrives as expectation",
                        body: "In many South Asian families, love is expressed as involvement: questions about promotions, money, marriage, when you're moving closer to home. From eight time zones away, a Sunday call can land as an audit. It helps to translate: behind almost every heavy question is 'we miss you and we want to be sure you're safe.' The delivery is expectation; the payload is love."
                    ),
                    LessonSection(
                        heading: "Guilt is not a verdict",
                        body: "The pull between the life you're building in London and the one imagined for you back home generates guilt on a schedule. Feel it without obeying it reflexively: guilt is evidence you care about both worlds, not proof you've betrayed either. You can honour your family deeply while making different choices than they'd script — most of them, eventually, want your happiness more than their script."
                    ),
                    LessonSection(
                        heading: "Boundaries, warmly held",
                        body: "A boundary with family doesn't need to be cold: \u{201C}I want to tell you about work, and I need us to not do the marriage question every week\u{201D} — said with warmth — is love plus honesty. Also practical: call when you have energy to be present, not out of scheduled duty while multitasking. One good call beats four resentful ones, and they can feel the difference."
                    ),
                ],
                takeaways: [
                    "Heavy questions are usually love in expectation's clothing — translate them.",
                    "Guilt means you care about both worlds; it isn't a verdict on your choices.",
                    "Warm boundaries and fewer-but-present calls beat dutiful, resentful ones.",
                ],
                reflection: "What does your family actually want underneath their most repeated question?",
                scenario: nil
            ),
            Lesson(
                id: "r3",
                title: "Friendship on a banker's calendar",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "Connection is a system, not a mood",
                        body: "On 70-hour weeks, friendship can't run on spontaneity — there is none. It runs on small deliberate deposits: the two-line message when someone crosses your mind, the voice note on the walk between meetings, the standing monthly dinner that survives because it's standing. Consistency beats grandeur; five minutes reliably beats five hours theoretically."
                    ),
                    LessonSection(
                        heading: "Loneliness is a leadership hazard too",
                        body: "Managing a team is quietly isolating — you can't fully vent down, and up is politics. Without off-desk relationships, work relationships carry loads they were never built for, and HALT's 'L' becomes chronic. Friendships aren't the reward for surviving the demanding years; they're part of the equipment for surviving them."
                    ),
                    LessonSection(
                        heading: "Show up as a person, not a CV",
                        body: "One practice: with friends, lead with how things actually are, not the highlight reel. 'Honestly, brutal quarter, I'm tired' opens more connection in ten seconds than an hour of polished updates. You already perform all day. Friendship is where you get to stop."
                    ),
                ],
                takeaways: [
                    "On demanding hours, friendship runs on small consistent deposits.",
                    "Leadership is isolating; off-desk relationships are load-bearing equipment.",
                    "Lead with the real state, not the highlight reel.",
                ],
                reflection: "Which friendship have you been meaning to tend? What's the two-minute deposit you could make today?",
                scenario: nil
            ),
            Lesson(
                id: "r4",
                title: "Rest is a skill",
                minutes: 3,
                sections: [
                    LessonSection(
                        heading: "Detachment is what restores",
                        body: "Recovery research keeps finding the same thing: hours off don't restore you — psychological detachment does. Ten p.m. scrolling with work Slack open is not rest; it's low-grade work with worse posture. A shorter evening with a genuine mental sign-off beats a long one spent half-on."
                    ),
                    LessonSection(
                        heading: "Build a shutdown ritual",
                        body: "The mind needs a boundary marker. Cal Newport's version: review open loops, write tomorrow's first move, say an explicit 'shutdown complete.' Yours might be the walk from the station, the gym, cooking, ten minutes of breathing in this app. The form matters less than the consistency — a repeated signal that tells your nervous system the desk is closed."
                    ),
                    LessonSection(
                        heading: "Guard one non-negotiable",
                        body: "You will never find time for rest inside a demanding calendar; you can only defend it. Pick one non-negotiable block a week — the Sunday ride, the Saturday morning that's yours, the evening class — and protect it the way you'd protect a client meeting. Composure on Monday is manufactured on the weekend."
                    ),
                ],
                takeaways: [
                    "Restoration requires detachment, not just hours away from the desk.",
                    "A consistent shutdown ritual tells your nervous system the day is closed.",
                    "Defend one weekly non-negotiable block like a client meeting.",
                ],
                reflection: "What could your shutdown ritual be — and what's the one weekly block worth defending?",
                scenario: nil
            ),
        ]
    )
}
