# Metric definitions (App2 demo)

These definitions match how **App2** (`/app2`) explains metrics in the UI. They align with:

- `app/app2/page.tsx` — chart aggregations, tooltips, “Conversations that deserve a look”
- `app/app2/mockData.ts` — `FAKE_SUBMISSIONS`, `FAKE_COMMENTS`, `FAKE_THREADS`
- `app/app2/demoProductIntelligence.ts` — modeled internal daily metrics + release milestones

Portfolio CSVs under `github/data/` use the **same column names** as those structures.

---

## 1) Internal product metrics (Delivery & experience narrative)

Source shape: `DemoInternalMetricRow` → `sample_demo_internal_daily.csv`.

| Field / UI label | Definition |
|---|---|
| `date` | Calendar day (`YYYY-MM-DD`) inside the demo storyline range. |
| `active_users` | Modeled signed-in active users for the day. In the line chart the UI plots **`active_users / 1000`** as “Signed-in audience (000s)”. |
| `session_count` | Modeled sessions for the day. Plotted as **`session_count / 1000`** (“Sessions (000s)”). |
| `avg_session_duration` | Average session length in **minutes** (“Average visit length”). |
| `churn_signal` | `low` \| `medium` \| `high` internal signal; displayed as **Retention read**: Stable / Elevated / Priority. |

Release overlays use `sample_demo_release_events.csv` (`release_date`, `release_type`, `feature_area`, `description`) as vertical guides in the chart.

---

## 2) Public voice — submissions (posts)

Source shape: `sample_submissions.csv` (same keys as `FAKE_SUBMISSIONS`).

| Concept | Definition |
|---|---|
| `created_utc` | Unix **seconds**; drives time bucketing (Day / Week / Month / Year) after converting to UTC dates. |
| `sentiment_advanced` | `positive` \| `neutral` \| `negative` — primary sentiment for posts in App2. |
| `aspect_advanced` | Theme bucket: `ui` \| `speed` \| `bugs` \| `pricing` \| `catalog` \| `support` \| `performance` \| `other` — shown with friendly labels in **Themes in the conversation**. |
| **Post weight** | \( \max(0, \ln(1 + \texttt{score})) \) — used when aggregating tone over time and in the pie chart (“% of voice”). |
| **Share critical** (themes table) | Among posts in a theme, % where `sentiment_advanced === 'negative'`. |
| **Audience signal** (themes table) | Sum of post weights within that theme (rounded for display). |

---

## 3) Public voice — comments

Source shape: `sample_comments.csv` (same keys as `FAKE_COMMENTS`).

| Field | Definition |
|---|---|
| `link_id` | Parent submission id with prefix `t3_` + `demo_<n>`. |
| `body` | Comment text. |
| `sentiment_advanced` | Sentiment used in **Comment tone over time** (falls back to `sentiment` only if present in other datasets). |
| **Comment weight** | \( \max(0, \ln(1 + \texttt{score})) \) — same weighting idea as posts. |

---

## 4) Thread-level metrics

Source shape: `sample_threads.csv` (same keys as `FAKE_THREADS`).

| Field | Definition |
|---|---|
| `s_thread`, `s_post`, `s_comments` | Demo signals in roughly \([-1, 1]\) for thread, post-only, and comment-only perspectives. |
| `w_thread` | Demo thread weight. |
| `thread_bucket` | `positive` \| `neutral` \| `negative` rollup for **Audience tone trend (threads)**. |
| `reaction_gap` | Distance between post sentiment and comment sentiment (demo). |
| `risk_level` | `HIGH` \| `LOW` — demo flag when the thread bucket is negative **and** `score` is very high. |
| `comments_analyzed` | Count of comments considered in thread analytics (capped style in demo). |
| `comments_engagement_weight` | Aggregated engagement from comments (demo). |

---

## 5) Tone mix charts & “Critical”

In line charts and pie charts, **negative** sentiment is labeled **Critical** in the legend (stakeholder wording).

Tooltips report:

- **% of voice** = sentiment weight / total weight in that time bucket  
- **Counts** = number of posts / comments / threads in that bucket  

---

## 6) “Conversations that deserve a look”

Demo rule on submissions (high reach + high discussion + critical tone):

- `sentiment_advanced === 'negative'`
- `ln(1 + score) > 5` (very high engagement proxy)
- `num_comments > 50`

Rows appear with **Tone** shown as **Critical** when sentiment is negative.
