# Data dictionary (App2-aligned)

All CSVs under `github/data/` are **synthetic portfolio samples**. Their columns match the shapes produced in the App2 demo code:

| Source in repo (not published on GitHub) | What it defines |
|---|---|
| `app/app2/mockData.ts` | `FAKE_SUBMISSIONS`, `FAKE_COMMENTS`, `FAKE_THREADS` |
| `app/app2/demoProductIntelligence.ts` | `DemoInternalMetricRow`, `DemoReleaseEvent` |

The live demo builds charts from the same field names (plus UI-only derivations like `created_time` from `created_utc` in **Detail view**).

---

## `data/sample_submissions.csv`

**Grain:** one row = one Reddit submission (post) in the demo model.

**Canonical fields** (same keys as objects in `FAKE_SUBMISSIONS` after `stripInternalFields` in `mockData.ts`):

| Column | Type | Description |
|---|---|---|
| `id` | string | Primary id, pattern `demo_<n>`. |
| `created_utc` | integer | Unix timestamp **seconds** (UTC). |
| `title` | string | Post title (demo text). |
| `selftext` | string | Post body / selftext. |
| `sentiment_advanced` | string | `positive` \| `neutral` \| `negative` (LLM-style label in demo). |
| `aspect_advanced` | string | `ui` \| `speed` \| `bugs` \| `pricing` \| `catalog` \| `support` \| `performance` \| `other`. |
| `confidence_advanced` | number | Classifier confidence in \([0, 1]\). |
| `score` | integer | Engagement score (maps to Reddit score; used for `log(1 + score)` weighting in charts). |
| `num_comments` | integer | Comment count shown on the post (demo-inflated vs internal `_commentCount` in generator). |
| `permalink` | string | Path form `/r/<subreddit>/comments/<id>/demo_thread/`. |
| `subreddit` | string | Source “community” name (matches `DEMO_FILTER_HINTS.subreddits` style). |
| `url` | string | Demo absolute URL prefix `https://example.com/demo` + `permalink`. |

**Not included** (exists only inside the generator before strip): `_commentCount`.

**UI note:** Detail view shows **Created** from `created_utc` when `created_time` is absent.

---

## `data/sample_comments.csv`

**Grain:** one row = one comment on a submission.

**Canonical fields** (same keys as `FAKE_COMMENTS` in `mockData.ts`):

| Column | Type | Description |
|---|---|---|
| `id` | string | Comment id (demo uses `c_<n>` style; samples use `c_pt_*`). |
| `link_id` | string | Parent submission id with Reddit prefix `t3_<submission_id>`. |
| `created_utc` | integer | Unix timestamp **seconds** (UTC), typically after parent post. |
| `body` | string | Comment text. |
| `sentiment_advanced` | string | `positive` \| `neutral` \| `negative`. |
| `score` | integer | Comment score (used for comment weighting `log(1 + score)` in charts). |
| `permalink` | string | Path form `/r/<sub>/comments/<id_without_demo_prefix>/demo_thread/<comment_id>/` (matches generator `replace('demo_', '')` behavior). |
| `subreddit` | string | Subreddit name. |
| `url` | string | `https://example.com/demo` + `permalink`. |

---

## `data/sample_threads.csv`

**Grain:** one row = one **thread** row aligned to a submission (used for thread-level charts and the **Threads** tab in Detail view).

**Canonical fields** (same keys as `FAKE_THREADS` from `buildThreads()` in `mockData.ts`):

| Column | Type | Description |
|---|---|---|
| `id` | string | Same as parent submission `id`. |
| `submission_id` | string | Explicit parent submission id (same as `id` in demo). |
| `title` | string | Thread title (copied from submission). |
| `created_utc` | integer | Thread anchor time (submission `created_utc`). |
| `permalink` | string | Submission permalink. |
| `subreddit` | string | Subreddit. |
| `s_thread` | number | Thread score signal in \([-1, 1]\) range (demo). |
| `w_thread` | number | Thread weight (demo). |
| `thread_bucket` | string | `positive` \| `neutral` \| `negative` summary bucket. |
| `s_post` | number | Post-side signal (demo). |
| `s_comments` | number | Comment-side signal (demo). |
| `reaction_gap` | number | Gap between post vs community reaction (demo). |
| `risk_level` | string | `HIGH` \| `LOW` (demo rule: high when thread bucket is negative and score is high). |
| `score` | integer | Submission score. |
| `num_comments` | integer | Submission comment count. |
| `comments_analyzed` | integer | Cap-style count of comments used in thread analytics (demo). |
| `comments_engagement_weight` | number | Aggregated comment engagement weight (demo). |
| `url` | string | Demo URL for the thread. |

---

## `data/sample_demo_internal_daily.csv`

**Grain:** one row = **one day** of illustrative internal product metrics (Delivery & experience narrative).

**Canonical fields** (same as `DemoInternalMetricRow` in `demoProductIntelligence.ts`):

| Column | Type | Description |
|---|---|---|
| `date` | date | `YYYY-MM-DD` within the demo storyline window (`DEMO_INTEL_RANGE` in code). |
| `active_users` | integer | Signed-in active users (same units feeding `auK` in charts: thousands in UI = `active_users / 1000`). |
| `session_count` | integer | Sessions (UI chart uses `session_count / 1000` as `sessionsK`). |
| `avg_session_duration` | number | Minutes (maps to `duration` line in the delivery chart). |
| `churn_signal` | string | `low` \| `medium` \| `high` — maps to **Retention read** pills: Stable / Elevated / Priority via `retentionSignalLabel()`. |

---

## `data/sample_demo_release_events.csv`

**Grain:** one row = one modeled **release milestone** (same content as `DEMO_RELEASE_EVENTS` in `demoProductIntelligence.ts`).

| Column | Type | Description |
|---|---|---|
| `release_date` | date | `YYYY-MM-DD`. |
| `release_type` | string | `major` \| `minor` \| `hotfix`. |
| `feature_area` | string | Codes like `UI`, `pricing`, `performance` (fed through `deliveryAreaLabel()` in UI). |
| `description` | string | Human-readable “what changed”. |
