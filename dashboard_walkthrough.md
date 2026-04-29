# Dashboard walkthrough

**Data note:** the demo uses **fake / synthetic data** for showcasing.

---

## Top navigation

- **Executive view** — main stakeholder dashboard (this page).
- **Detail view** — tabular drill-down (separate route).
- **Sign out** — session control.

---

## Header

- **Title:** *User Feedback Intelligence Platform*
- **Subtitle:** stakeholder framing (public voice, tone, recurring themes).

---

## Filters (top card)

1. **Period** — presets: Last 7 Days, Last 30 Days, This Month, Last Month, YTD, Last 12 Months, All Time, Custom Range.
2. **Data refreshed** — shows when the demo dataset was last “refreshed” (synthetic).
3. **Topic** — free-text keyword filter (e.g. pricing, HDR).
4. **Source** — optional community/source filter.
5. **View by** — time bucketing: Day / Week / Month / Year.
6. **Refresh** / **Reset** — reload data with current filters or clear filters.

---

## Section: At a glance

**Goal:** give leadership a compact read on tone + where to look next.

1. **Summary table** — rows are named **Indicators** with **Score** and **Outlook** (interpretation).
2. **Themes in the conversation** — table columns:
   - Theme · Mentions · **Share critical** · Audience signal · Direction  
   (Themes are human-readable labels like “Experience & layout”, “Pricing & value”, etc.)
3. **Conversations that deserve a look** — high-signal threads:
   - Conversation · Reach · Replies · **Tone** (negative shows as **Critical**) · Priority

---

## Section: Delivery & experience narrative

**Goal:** connect **modeled internal activity** with **delivery milestones** so teams can narrate “what shipped” vs “what the audience did”.

Read the **banner** first: this storyline is **illustrative only** (modeled milestones + internal activity shaped for the demo).

1. **Audience activity alongside delivery moments** — line chart:
   - Signed-in audience (000s)
   - Sessions (000s)
   - Average visit length (minutes)  
   Vertical guides mark **modeled delivery dates** inside the selected period.
2. **Milestones in this period** — table: Date · Release · Focus · What changed.
3. **Daily pulse excerpt** — table: Date · Signed-in audience · Sessions · Avg. visit · **Retention read** (Stable / Elevated / Priority).
4. **What the pattern suggests** — markdown insight block (demo narrative).
5. **What to watch for** — markdown risks block (demo narrative).
6. **Recurring experience themes** — “what we keep hearing” mapped to themes + why leaders care.
7. **Recommended moves** — action table with timing horizon (Near term / Mid term / Long term).

---

## Tone trends (three stacked charts)

**Goal:** separate **thread-level** tone from **post-level** vs **comment-level** tone (this matches how teams debate “the post vs the community reaction”).

Each chart is a **tone mix** over time with three series:

- **Positive**
- **Neutral**
- **Critical** (this is the UI label for strongly negative tone)

Charts (in vertical order on the page):

1. **Audience tone trend (threads)** — thread-level mix; badge shows thread count.
2. **Post tone over time** — submission/post mix; badge shows post count.
3. **Comment tone over time** — comment mix; badge shows comment count.

**Tooltip detail (important for interviews):** hover tooltips show **% of voice** (weighted mix) and **counts** (posts/comments/threads in that bucket).

---

## Section: Language & tone mix

**Goal:** qualitative texture + overall distribution.

1. **Words people use most** — word cloud (top terms).
2. **Overall tone mix** — pie chart with Positive / Neutral / Critical; tooltip shows **% of voice** and post counts.

---

## Section: Guided narrative

**Goal:** show LLM-assisted storytelling for stakeholders.

- Text area placeholder explains you can ask a focused question **or** leave blank.
- Buttons:
  - **Leadership summary**
  - **Answer your question**
- Output appears under **Narrative** (markdown).

---

## Second page: Detail view

From the top nav, open **Detail view** when you want to show **tabular QA** (sorting/filtering rows) rather than the executive storyline.

---

## Screenshots in `screenshots/`
