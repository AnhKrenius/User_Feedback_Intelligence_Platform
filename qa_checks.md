# Data quality & validation checks (App2 demo)

Checklist aligned with fields used in **App2** (`app/app2/mockData.ts`, `app/app2/filterMock.ts`, `app/app2/page.tsx`). Use it when extending the portfolio CSVs or when explaining QA in interviews.

---

## 1) Schema & keys (submissions)

Required for each submission row (`sample_submissions.csv`):

- `id` unique, stable string (`demo_<n>` pattern in the live generator).
- `created_utc` integer **seconds** ≥ 0; converts cleanly to UTC dates for Period filters.
- `sentiment_advanced` ∈ `positive` \| `neutral` \| `negative`.
- `aspect_advanced` ∈ `ui` \| `speed` \| `bugs` \| `pricing` \| `catalog` \| `support` \| `performance` \| `other`.
- `confidence_advanced` ∈ \[0, 1\].
- `score`, `num_comments` non-negative integers.
- `permalink` starts with `/r/<subreddit>/comments/<id>/demo_thread/`.
- `url` equals `https://example.com/demo` + `permalink` (same convention as mock data).

---

## 2) Schema & keys (comments)

Required for each comment row (`sample_comments.csv`):

- `id` unique.
- `link_id` = `t3_` + parent submission `id`.
- `created_utc` ≥ parent post time (typical); still within filterable window.
- `permalink` uses the generator pattern: `/r/<sub>/comments/<id_without_leading_demo_>/demo_thread/<comment_id>/` (see `mockData.ts` `replace('demo_', '')` on parent id).
- `subreddit` matches parent for joinability.

---

## 3) Schema & keys (threads)

Thread rows (`sample_threads.csv`) must align to a submission:

- `id` and `submission_id` both equal the parent `demo_<n>` id.
- `permalink` / `url` match the submission thread URL.
- `thread_bucket` consistent with `s_thread` thresholds used in the demo (`buildThreads` logic).
- `risk_level` is `HIGH` only when demo rules say so (negative bucket + high score).

---

## 4) Schema & keys (internal daily + releases)

- `sample_demo_internal_daily.csv`: `date` ascending; `churn_signal` ∈ `low` \| `medium` \| `high`; metrics non-negative.
- `sample_demo_release_events.csv`: `release_type` ∈ `major` \| `minor` \| `hotfix`; `feature_area` uses codes consumed by `deliveryAreaLabel()` in the UI.

---

## 5) Missingness & joins

- No missing `created_utc` on rows that should appear in time-based charts.
- Comments without resolvable parent `link_id` should not exist (breaks comment charts).
- Thread tab in Detail view only shows threads for submissions still in the filtered set (`threadsMatchingSubmissions` behavior).

---

## 6) Metric sanity (App2-specific)

- **Weight domination:** post/comment weights use `log(1 + score)` — spot-check extreme scores still produce finite weights.
- **“Conversations that deserve a look”:** verify negative + `log(1+score) > 5` + `num_comments > 50` still surfaces a small, explainable set.
- **Delivery chart:** for each selected day, `active_users` and `session_count` should map to plausible `auK` / `sessionsK` (thousands rounding).

---

## 7) Classifier hygiene (when LLM labels are used)

- Reject outputs outside allowed sentiment / aspect enums (same spirit as strict parsers in batch scripts).
- Store confidence when available; investigate low-confidence clusters before reporting.
