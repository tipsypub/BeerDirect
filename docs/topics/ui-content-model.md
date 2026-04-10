# BeerDirect UI 内容模型（第一版）

## 说明

这份文档用于把 BeerDirect 当前已经完成的：

- UI 方向
- DESIGN.md
- 页面线框
- 组件清单

进一步推进到一个更接近开发的数据层问题：

**每个页面到底要展示哪些信息块、哪些字段、哪些关系。**

也就是说，这份文档的作用是把：
- 页面结构
- 组件设计
- 数据模型

真正对齐起来。

它会直接影响后续：
- Vue 3 静态原型
- Express API 设计
- SQLite 表结构设计

---

## 一、内容模型的目标

BeerDirect 不是普通后台，它同时承载：
- 来源管理
- 文档管理
- 摘要管理
- 平台观察
- 研究记录
- 标签与知识关系

所以每个页面不只是“一个表格”，而是：
- 主对象
- 元信息
- 状态
- 标签
- 关联对象
- 处理动作

这份文档的目标就是把这些元素整理清楚。

---

## 二、全局高频信息块

在 BeerDirect 里，很多页面都会反复出现一些共同的信息块。

## 1. 基本标识信息
- `id`
- `title` / `name`
- `slug`（后续可选）
- `description` / `notes`

## 2. 分类信息
- `category`
- `type`
- `platform`
- `group`

## 3. 优先级和状态
- `priority`
- `status`
- `processing_status`
- `access_type`

## 4. 时间信息
- `created_at`
- `updated_at`
- `published_at`
- `last_checked_at`

## 5. 关联关系
- `source`
- `document`
- `digest`
- `tags`
- `related_entries`
- `related_documents`

## 6. 外部定位信息
- `url`
- `file_path`
- `source_url`
- `original_file`
- `page_refs`

这些字段未来不一定每个页面都显示完整，但这是 UI 设计和数据模型里最常见的基础块。

---

## 三、Dashboard 内容模型

## 页面目标
Dashboard 要回答：
- 现在系统里有什么
- 最近发生了什么
- 接下来值得处理什么

## 信息块 1：总体统计
### 显示字段
- `total_sources`
- `total_documents`
- `total_digests`
- `total_entries`
- `total_watchlists`

## 信息块 2：最近新增
### 来源对象
- documents
- digests
- entries

### 每项最少字段
- `id`
- `title`
- `type`
- `created_at`
- `source_name`
- `priority`

## 信息块 3：待处理事项
### 可能类型
- documents without digest
- entries without tags
- p1 sources needing review
- watchlists without recent observations

### 每项最少字段
- `id`
- `title`
- `item_type`
- `status`
- `updated_at`
- `priority`

## 信息块 4：主题块
### 每个主题块可显示
- `tag_name`
- `related_documents_count`
- `related_entries_count`
- `recent_items`

---

## 四、Sources 页面内容模型

## 页面目标
Sources 页面管理的是“来源定义”。

## 列表页字段
建议显示：
- `id`
- `name`
- `category`
- `access_type`
- `platform`
- `priority`
- `status`
- `url`
- `updated_at`

## 详情页字段
建议分组展示：

### 基本信息
- `name`
- `description`
- `category`
- `access_type`
- `platform`
- `region`
- `language`

### 追踪属性
- `priority`
- `credibility`
- `update_frequency`
- `automation_feasibility`

### 来源定位
- `url`
- `rss`
- `notes`

### 关联内容
- `tags[]`
- `related_documents[]`
- `related_watchlists[]`
- `related_entries[]`

## UI 说明
Source 详情页不应只是一堆字段，而应让用户能快速看清：
- 这是什么来源
- 为什么值得跟踪
- 它和哪些资料相连

---

## 五、Watchlists 页面内容模型

## 页面目标
Watchlists 页面管理“平台观察对象”。

## 列表页字段
建议显示：
- `id`
- `name`
- `platform`
- `account_type`
- `region`
- `priority`
- `tracking_mode`
- `watch_reasons[]`
- `updated_at`

## 详情页字段
### 基本信息
- `name`
- `platform`
- `account_type`
- `region`
- `language`

### 观察逻辑
- `priority`
- `tracking_mode`
- `watch_reasons[]`
- `notes`

### 外部定位
- `profile_url`
- `source_reference`

### 关联信息
- `related_sources[]`
- `recent_entries[]`
- `related_tags[]`

## UI 说明
Watchlist 详情一定要突出：
- 为什么观察它
- 属于哪类对象
- 最近有没有新观察

---

## 六、Documents 页面内容模型

## 页面目标
Documents 页面管理所有原始资料。

## 列表页字段
建议显示：
- `id`
- `title`
- `document_type`
- `source_name`
- `language`
- `processing_status`
- `priority`
- `updated_at`

## 详情页字段
### 基本信息
- `title`
- `summary`
- `document_type`
- `language`
- `publisher`
- `author`

### 来源与定位
- `source_id`
- `source_name`
- `source_url`
- `original_file`
- `file_path`

### 处理状态
- `processing_status`
- `processing_mode`
- `last_processed_at`
- `notes`

### 关联信息
- `tags[]`
- `related_digests[]`
- `related_entries[]`
- `related_topics[]`

## UI 说明
Document 详情页要同时支持：
- 资料管理
- 来源追踪
- 摘要跳转

所以“文档基础信息”和“相关摘要”一定要拆开显示。

---

## 七、Digests 页面内容模型

## 页面目标
Digests 页面展示的是加工后的核心知识。

这是 BeerDirect 最重要的内容层之一。

## 列表页字段
建议显示：
- `id`
- `title`
- `digest_type`
- `document_title`
- `source_name`
- `topic_tags[]`
- `updated_at`

## 详情页字段
### 基本信息
- `title`
- `digest_type`
- `summary`
- `markdown_content`

### 来源关系
- `document_id`
- `document_title`
- `source_name`
- `source_url`

### 定位信息
- `page_refs`
- `chapter_refs`
- `original_file`

### 分类信息
- `tags[]`
- `topics[]`
- `related_documents[]`
- `related_entries[]`

### 处理信息
- `created_at`
- `updated_at`
- `processing_notes`

## UI 说明
Digest 详情页至少要分成 4 个明显层次：
- 标题与基本信息
- Markdown 主体内容
- 来源与页码定位
- 相关主题与相关资料

---

## 八、Entries 页面内容模型

## 页面目标
Entries 页面承载日常研究条目流。

## 列表页字段
建议显示：
- `id`
- `title`
- `entry_type`
- `platform`
- `source_name`
- `published_at`
- `priority`
- `tags[]`

## 详情页字段
### 基本信息
- `title`
- `entry_type`
- `summary`
- `content`

### 来源信息
- `source_name`
- `platform`
- `source_url`
- `author_or_account`

### 时间信息
- `published_at`
- `created_at`

### 分类信息
- `tags[]`
- `topics[]`
- `priority`

### 关联关系
- `related_documents[]`
- `related_digests[]`
- `related_sources[]`

## UI 说明
Entry 页面既要适合快速浏览，也要支持把条目沉淀进知识系统。

所以列表页应强调：
- 类型
- 来源
- 时间
- 标签

---

## 九、Tags 页面内容模型

## 页面目标
Tags 页面承载知识分类体系。

## 列表页字段
建议显示：
- `id`
- `name`
- `tag_group`
- `description`
- `usage_count`
- `updated_at`

## 详情页字段
### 基本信息
- `name`
- `tag_group`
- `description`

### 使用情况
- `related_sources_count`
- `related_documents_count`
- `related_digests_count`
- `related_entries_count`

### 关联内容
- `related_sources[]`
- `related_documents[]`
- `related_digests[]`
- `related_entries[]`

## UI 说明
Tag 页面应该像“知识索引页”，而不只是后台字段管理页。

---

## 十、Settings 页面内容模型

## 页面目标
Settings 页面承载系统级配置。

## 第一阶段建议内容
- source categories
- platforms
- priority definitions
- digest types
- tag groups

## 每类配置项通用字段
- `id`
- `name`
- `description`
- `sort_order`
- `status`

---

## 十一、页面与核心对象对应关系

## Core Object 1: Source
对应页面：
- Sources
- Dashboard
- Tags
- Watchlists（关联）

## Core Object 2: Watchlist
对应页面：
- Watchlists
- Entries
- Sources（关联）

## Core Object 3: Document
对应页面：
- Documents
- Digests
- Dashboard

## Core Object 4: Digest
对应页面：
- Digests
- Documents
- Dashboard
- Tags

## Core Object 5: Entry
对应页面：
- Entries
- Dashboard
- Tags
- Watchlists

## Core Object 6: Tag
对应页面：
- Tags
- 所有详情页

这说明后续数据库设计时，这 6 类对象就是核心主轴。

---

## 十二、对后端 API 的直接影响

这个内容模型会直接影响 API 设计。

例如：

## Sources API 至少需要支持
- list
- detail
- create
- update
- filter by category/platform/priority

## Documents API 至少需要支持
- list
- detail
- create
- update
- filter by type/status/source

## Digests API 至少需要支持
- list
- detail
- create
- update
- filter by topic/document/source

所以这份文档可以直接作为后续 `api-draft.md` 的基础。

---

## 十三、对数据库建模的直接影响

这份文档也会直接影响数据模型。

高频字段已经很明确，后续建表时大概率会形成：
- sources
- watchlists
- documents
- digests
- entries
- tags
- source_tags
- document_tags
- digest_tags
- entry_tags
- relationship tables（可选）

因此，这份文档也是后续 `data-model-draft.md` 的上游输入。

---

## 十四、当前判断

到这一步，BeerDirect 的前端信息架构已经非常接近可开发状态。

你现在已经拥有：
- 风格定义
- 页面骨架
- 组件清单
- 页面内容模型

也就是说，下一步已经不该再继续抽象讨论 UI，而是要进入：
- API 草案
- 数据表草案
- 或直接前端静态原型

---

## 十五、下一步建议

最适合继续推进的是三个方向：

### 1. `api-draft.md`
定义 Express 后端接口。

### 2. `data-model-draft.md`
定义 SQLite 表结构。

### 3. Vue 3 静态原型
先做 Dashboard / Sources / Documents / Digests 四页。

当前最推荐的下一步是：

**data-model-draft.md**

因为它会把 UI、API、数据库三条线真正锁在一起。