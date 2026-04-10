# BeerDirect 数据模型草案（第一版）

## 说明

这份文档用于把 BeerDirect 当前已经完成的：

- UI 内容模型
- 页面线框
- 组件清单
- 技术架构轻量方案
- SQLite 可行性分析

进一步推进成真正可落地的数据模型草案。

它的作用是：

- 明确第一阶段核心表
- 明确表之间的关系
- 给 Express API 提供对象边界
- 给 SQLite 建表提供第一版结构

这不是最终 schema，而是：

**第一阶段可以直接拿来开始建库和写 API 的结构草案。**

---

## 一、建模原则

BeerDirect 当前的数据模型应遵循以下原则：

## 1. 先围绕核心对象，不追求一次完美
第一阶段先围绕 6 个核心对象：
- Source
- Watchlist
- Document
- Digest
- Entry
- Tag

## 2. 关系要清楚，但不要一开始过度复杂
BeerDirect 有很多潜在关系：
- 来源和标签
- 文档和摘要
- 条目和来源
- 条目和平台观察对象
- 标签和所有对象

第一阶段只把最核心的关系建稳。

## 3. 原始文件与元数据分开
- 数据库存元信息
- PDF / 原始文件走文件路径或外部链接
- 不把大文件塞进 SQLite

## 4. 摘要内容可以进库
Markdown 摘要、研究条目、说明文本都适合直接进数据库。

## 5. 未来迁移 PostgreSQL 时要尽量平滑
- 不依赖特别奇怪的 SQLite 私有技巧
- 关系表规范化
- 字段命名尽量稳定

---

## 二、核心对象总览

## Core Object 1: sources
定义信息源。

## Core Object 2: watchlists
定义平台观察对象。

## Core Object 3: documents
定义原始文档。

## Core Object 4: digests
定义加工后的 Markdown 摘要。

## Core Object 5: entries
定义研究条目 / 新闻 / 技术记录 / 平台观察记录。

## Core Object 6: tags
定义主题标签体系。

这些对象会构成 BeerDirect 第一阶段的主轴。

---

## 三、表结构草案

## 1. `sources`

### 作用
定义所有来源。

### 建议字段
- `id` INTEGER PRIMARY KEY
- `name` TEXT NOT NULL
- `description` TEXT
- `category` TEXT NOT NULL
- `access_type` TEXT NOT NULL
- `platform` TEXT
- `region` TEXT
- `language` TEXT
- `priority` TEXT NOT NULL DEFAULT 'p2'
- `status` TEXT NOT NULL DEFAULT 'active'
- `credibility` TEXT
- `update_frequency` TEXT
- `automation_feasibility` TEXT
- `url` TEXT
- `rss` TEXT
- `notes` TEXT
- `created_at` TEXT NOT NULL
- `updated_at` TEXT NOT NULL

### 说明
`category` 可以是：
- news
- technical
- ingredient
- market
- research
- competition
- platform
- pdf_layer

`access_type` 可以是：
- public
- paid
- member_only

---

## 2. `watchlists`

### 作用
定义平台观察对象。

### 建议字段
- `id` INTEGER PRIMARY KEY
- `name` TEXT NOT NULL
- `platform` TEXT NOT NULL
- `account_type` TEXT NOT NULL
- `region` TEXT
- `language` TEXT
- `priority` TEXT NOT NULL DEFAULT 'p2'
- `tracking_mode` TEXT NOT NULL DEFAULT 'manual'
- `profile_url` TEXT
- `notes` TEXT
- `last_checked_at` TEXT
- `created_at` TEXT NOT NULL
- `updated_at` TEXT NOT NULL

### 说明
`platform` 可以是：
- xiaohongshu
- wechat
- untappd
- x
- instagram
- youtube
- reddit

`account_type` 可以是：
- brewery
- brand
- bar
- media
- kol
- supplier
- technical_author

---

## 3. `watchlist_reasons`

### 作用
一个 watchlist 可能对应多个观察理由。

### 建议字段
- `id` INTEGER PRIMARY KEY
- `watchlist_id` INTEGER NOT NULL
- `reason` TEXT NOT NULL

### 外键
- `watchlist_id` -> `watchlists.id`

### 说明
`reason` 例如：
- new_release
- trend
- consumer_feedback
- technical_discussion
- market_signal

---

## 4. `documents`

### 作用
定义原始资料对象。

### 建议字段
- `id` INTEGER PRIMARY KEY
- `title` TEXT NOT NULL
- `summary` TEXT
- `document_type` TEXT NOT NULL
- `language` TEXT
- `publisher` TEXT
- `author` TEXT
- `source_id` INTEGER
- `source_url` TEXT
- `original_file` TEXT
- `file_path` TEXT
- `processing_status` TEXT NOT NULL DEFAULT 'pending'
- `processing_mode` TEXT
- `last_processed_at` TEXT
- `priority` TEXT NOT NULL DEFAULT 'p2'
- `notes` TEXT
- `created_at` TEXT NOT NULL
- `updated_at` TEXT NOT NULL

### 外键
- `source_id` -> `sources.id`

### 说明
`document_type` 可以是：
- pdf
- book
- magazine
- report
- whitepaper
- webinar_pdf
- paper

`processing_status` 可以是：
- pending
- processing
- completed
- failed
- archived

---

## 5. `digests`

### 作用
定义 Markdown 提炼内容。

### 建议字段
- `id` INTEGER PRIMARY KEY
- `title` TEXT NOT NULL
- `digest_type` TEXT NOT NULL
- `summary` TEXT
- `markdown_content` TEXT NOT NULL
- `document_id` INTEGER
- `source_id` INTEGER
- `page_refs` TEXT
- `chapter_refs` TEXT
- `processing_notes` TEXT
- `status` TEXT NOT NULL DEFAULT 'active'
- `created_at` TEXT NOT NULL
- `updated_at` TEXT NOT NULL

### 外键
- `document_id` -> `documents.id`
- `source_id` -> `sources.id`

### 说明
`digest_type` 可以是：
- summary
- chapter_notes
- extracted_core
- paper_digest
- topic_digest

---

## 6. `entries`

### 作用
定义研究条目流。

### 建议字段
- `id` INTEGER PRIMARY KEY
- `title` TEXT NOT NULL
- `entry_type` TEXT NOT NULL
- `summary` TEXT
- `content` TEXT
- `source_id` INTEGER
- `watchlist_id` INTEGER
- `platform` TEXT
- `source_url` TEXT
- `author_or_account` TEXT
- `priority` TEXT NOT NULL DEFAULT 'p2'
- `published_at` TEXT
- `created_at` TEXT NOT NULL
- `updated_at` TEXT NOT NULL

### 外键
- `source_id` -> `sources.id`
- `watchlist_id` -> `watchlists.id`

### 说明
`entry_type` 可以是：
- news
- technical
- platform_observation
- brand_update
- market_note
- research_note

---

## 7. `tags`

### 作用
定义标签体系。

### 建议字段
- `id` INTEGER PRIMARY KEY
- `name` TEXT NOT NULL UNIQUE
- `tag_group` TEXT NOT NULL
- `description` TEXT
- `status` TEXT NOT NULL DEFAULT 'active'
- `created_at` TEXT NOT NULL
- `updated_at` TEXT NOT NULL

### 说明
`tag_group` 可以是：
- topic
- platform
- source_type
- style
- ingredient
- market
- region
- process

---

## 四、关系表草案

为了保持结构清楚，标签统一走关系表。

## 8. `source_tags`
- `id` INTEGER PRIMARY KEY
- `source_id` INTEGER NOT NULL
- `tag_id` INTEGER NOT NULL

## 9. `document_tags`
- `id` INTEGER PRIMARY KEY
- `document_id` INTEGER NOT NULL
- `tag_id` INTEGER NOT NULL

## 10. `digest_tags`
- `id` INTEGER PRIMARY KEY
- `digest_id` INTEGER NOT NULL
- `tag_id` INTEGER NOT NULL

## 11. `entry_tags`
- `id` INTEGER PRIMARY KEY
- `entry_id` INTEGER NOT NULL
- `tag_id` INTEGER NOT NULL

## 12. `watchlist_tags`
- `id` INTEGER PRIMARY KEY
- `watchlist_id` INTEGER NOT NULL
- `tag_id` INTEGER NOT NULL

### 关系表统一约束建议
- `(object_id, tag_id)` 建唯一约束

---

## 五、可选关系表（第二阶段）

这些关系第一阶段不一定必须建，但很可能后续会需要。

## 13. `document_related_entries`
文档和条目关联。

## 14. `digest_related_entries`
摘要和条目关联。

## 15. `digest_related_documents`
摘要和其他文档关联。

## 16. `source_related_watchlists`
来源与观察名单关联。

### 建议
第一阶段可以不先做成正式关系表，先用简单字段或手工管理。
如果后面关联越来越多，再补。

---

## 六、第一阶段最小可执行表集合

如果要尽快启动，建议第一阶段先建这几张：

### 必建主表
1. `sources`
2. `watchlists`
3. `documents`
4. `digests`
5. `entries`
6. `tags`

### 必建关系表
7. `source_tags`
8. `document_tags`
9. `digest_tags`
10. `entry_tags`
11. `watchlist_tags`
12. `watchlist_reasons`

这已经足够支撑：
- 来源管理
- 平台观察名单
- 文档管理
- 摘要管理
- 条目管理
- 标签系统

---

## 七、对象关系图（概念层）

```text
sources ─────┬───── documents ─────┬───── digests
             │                     │
             │                     └───── document_tags
             │
             ├───── entries
             │
             ├───── source_tags
             │
             └───── related to watchlists (logical)

watchlists ──┬───── entries
             ├───── watchlist_reasons
             └───── watchlist_tags

tags ────────┬───── source_tags
             ├───── document_tags
             ├───── digest_tags
             ├───── entry_tags
             └───── watchlist_tags
```

---

## 八、字段设计建议

## 时间字段
建议统一使用 ISO 8601 文本，例如：
- `2026-04-10T10:30:00Z`

因为 SQLite 对这种形式足够友好，也便于后续迁移。

## 状态字段
建议统一用 TEXT + 应用层约束。

先不要一开始为了“严格”做太多复杂枚举系统。

## 长文本字段
这些可以直接存 TEXT：
- `summary`
- `description`
- `notes`
- `markdown_content`
- `content`

## 页面引用字段
`page_refs` 可以先用简单文本：
- `p.12`
- `p.12-14`
- `p.12; p.28-30`

后续若需要结构化再升级。

---

## 九、和 UI 的直接对应

## Sources 页面对应
- `sources`
- `source_tags`
- `tags`

## Watchlists 页面对应
- `watchlists`
- `watchlist_reasons`
- `watchlist_tags`
- `entries`（关联查看）

## Documents 页面对应
- `documents`
- `document_tags`
- `digests`

## Digests 页面对应
- `digests`
- `digest_tags`
- `documents`
- `sources`

## Entries 页面对应
- `entries`
- `entry_tags`
- `sources`
- `watchlists`

## Tags 页面对应
- `tags`
- 各种 tag relation 表

这说明当前 UI 模型和数据库模型已经基本对齐了。

---

## 十、和 API 的直接对应

如果按 Express 来做，第一阶段 API 就很自然会按这些对象展开：

- `/api/sources`
- `/api/watchlists`
- `/api/documents`
- `/api/digests`
- `/api/entries`
- `/api/tags`

也就是说，这份数据模型草案已经可以直接喂给下一步 API 草案。

---

## 十一、当前判断

到这一步，BeerDirect 已经具备了开始真正开发的条件。

因为现在已经有了：
- 技术栈方向
- SQLite 可行性结论
- UI 风格
- 页面线框
- 组件清单
- 页面内容模型
- 数据模型草案

这意味着下一步已经不该再继续抽象讨论系统长什么样，而是可以进入：
- API 草案
- SQLite schema.sql
- Vue 3 静态原型
- Express 项目骨架

---

## 十二、下一步建议

在这份数据模型草案之后，最适合继续推进的是：

### 1. `api-draft.md`
把 Express 接口定义出来。

### 2. `schema.sql`
把这份草案转成 SQLite 初始建表 SQL。

### 3. Vue 3 静态原型
先做 Dashboard / Sources / Documents / Digests 四页。

当前最推荐的下一步是：

**api-draft.md**

因为它会把前端页面、数据库对象和 Express 路由正式串起来。