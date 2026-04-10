# BeerDirect Express API 草案（第一版）

## 说明

这份文档用于把 BeerDirect 当前已经完成的：

- 技术架构轻量方案
- UI 内容模型
- 数据模型草案

进一步推进成可实现的 **Express API 设计草案**。

它的目标不是一开始就做一套完美 API，而是：

- 先定义第一阶段需要哪些接口
- 让前端、后端、数据库三条线对齐
- 让 Express 路由可以直接开始搭建

---

## 一、API 设计原则

## 1. REST 优先
第一阶段不需要 GraphQL，也不需要 RPC 风格。

采用清晰直接的 REST 风格即可：
- list
- detail
- create
- update
- delete

## 2. 先服务内部管理台
当前 API 的主要消费者是 Vue 3 管理台。

所以第一阶段重点是：
- 稳定
- 清晰
- 好调试

不是“对外开放平台化”。

## 3. 查询参数尽量简单
优先支持：
- keyword search
- category/type/platform filters
- priority/status filters
- paging
- sorting

## 4. 响应结构统一
建议统一基础响应格式：

```json
{
  "success": true,
  "data": {},
  "meta": {}
}
```

错误时：

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "..."
  }
}
```

---

## 二、基础约定

## Base URL
```text
/api
```

## 时间格式
统一返回 ISO 8601：
```text
2026-04-10T10:30:00Z
```

## 分页建议
列表接口支持：
- `page`
- `page_size`
- `sort_by`
- `sort_order`

例如：
```text
GET /api/sources?page=1&page_size=20&sort_by=updated_at&sort_order=desc
```

## 搜索建议
统一支持：
- `q` 用于关键词搜索

---

## 三、Sources API

## 1. 获取来源列表
```http
GET /api/sources
```

### 支持参数
- `q`
- `category`
- `access_type`
- `platform`
- `priority`
- `status`
- `page`
- `page_size`

### 返回数据项建议
- `id`
- `name`
- `category`
- `access_type`
- `platform`
- `priority`
- `status`
- `url`
- `updated_at`

---

## 2. 获取来源详情
```http
GET /api/sources/:id
```

### 返回建议
- 基本字段
- `tags`
- `related_documents_count`
- `related_entries_count`
- `related_watchlists_count`

---

## 3. 新建来源
```http
POST /api/sources
```

### 请求体建议
```json
{
  "name": "Brewers Association",
  "description": "...",
  "category": "research",
  "access_type": "public",
  "platform": null,
  "region": "us",
  "language": "en",
  "priority": "p1",
  "status": "active",
  "credibility": "high",
  "update_frequency": "weekly",
  "automation_feasibility": "medium",
  "url": "https://...",
  "rss": null,
  "notes": "..."
}
```

---

## 4. 更新来源
```http
PUT /api/sources/:id
```

---

## 5. 删除来源
```http
DELETE /api/sources/:id
```

### 说明
第一阶段可以做“软删除”或直接 `archived`。

---

## 6. 来源标签接口
```http
GET /api/sources/:id/tags
POST /api/sources/:id/tags
DELETE /api/sources/:id/tags/:tag_id
```

---

## 四、Watchlists API

## 1. 获取观察名单列表
```http
GET /api/watchlists
```

### 支持参数
- `q`
- `platform`
- `account_type`
- `region`
- `priority`
- `tracking_mode`
- `page`
- `page_size`

---

## 2. 获取观察对象详情
```http
GET /api/watchlists/:id
```

### 返回建议
- 基本字段
- `watch_reasons`
- `tags`
- `recent_entries`

---

## 3. 新建观察对象
```http
POST /api/watchlists
```

### 请求体建议
```json
{
  "name": "某精酿品牌",
  "platform": "xiaohongshu",
  "account_type": "brand",
  "region": "china",
  "language": "zh",
  "priority": "p1",
  "tracking_mode": "manual",
  "profile_url": "https://...",
  "notes": "...",
  "watch_reasons": ["new_release", "trend"]
}
```

---

## 4. 更新观察对象
```http
PUT /api/watchlists/:id
```

---

## 5. 删除观察对象
```http
DELETE /api/watchlists/:id
```

---

## 6. 观察理由接口
```http
GET /api/watchlists/:id/reasons
POST /api/watchlists/:id/reasons
DELETE /api/watchlists/:id/reasons/:reason_id
```

---

## 7. 观察对象标签接口
```http
GET /api/watchlists/:id/tags
POST /api/watchlists/:id/tags
DELETE /api/watchlists/:id/tags/:tag_id
```

---

## 五、Documents API

## 1. 获取文档列表
```http
GET /api/documents
```

### 支持参数
- `q`
- `document_type`
- `source_id`
- `processing_status`
- `priority`
- `language`
- `page`
- `page_size`

---

## 2. 获取文档详情
```http
GET /api/documents/:id
```

### 返回建议
- 基本字段
- `source`
- `tags`
- `related_digests`
- `related_entries`

---

## 3. 新建文档记录
```http
POST /api/documents
```

### 请求体建议
```json
{
  "title": "Hop Whitepaper 2025",
  "summary": "...",
  "document_type": "whitepaper",
  "language": "en",
  "publisher": "...",
  "author": "...",
  "source_id": 1,
  "source_url": "https://...",
  "original_file": "hop-whitepaper-2025.pdf",
  "file_path": "data/raw/...pdf",
  "processing_status": "pending",
  "processing_mode": "summary",
  "priority": "p1",
  "notes": "..."
}
```

---

## 4. 更新文档记录
```http
PUT /api/documents/:id
```

---

## 5. 删除文档记录
```http
DELETE /api/documents/:id
```

---

## 6. 文档标签接口
```http
GET /api/documents/:id/tags
POST /api/documents/:id/tags
DELETE /api/documents/:id/tags/:tag_id
```

---

## 六、Digests API

## 1. 获取摘要列表
```http
GET /api/digests
```

### 支持参数
- `q`
- `digest_type`
- `document_id`
- `source_id`
- `tag_id`
- `page`
- `page_size`

---

## 2. 获取摘要详情
```http
GET /api/digests/:id
```

### 返回建议
- 基本字段
- `document`
- `source`
- `tags`
- `related_entries`

---

## 3. 新建摘要
```http
POST /api/digests
```

### 请求体建议
```json
{
  "title": "Hop Whitepaper 核心摘要",
  "digest_type": "summary",
  "summary": "...",
  "markdown_content": "# ...",
  "document_id": 12,
  "source_id": 3,
  "page_refs": "p.12-18",
  "chapter_refs": "chapter 2",
  "processing_notes": "...",
  "status": "active"
}
```

---

## 4. 更新摘要
```http
PUT /api/digests/:id
```

---

## 5. 删除摘要
```http
DELETE /api/digests/:id
```

---

## 6. 摘要标签接口
```http
GET /api/digests/:id/tags
POST /api/digests/:id/tags
DELETE /api/digests/:id/tags/:tag_id
```

---

## 七、Entries API

## 1. 获取条目列表
```http
GET /api/entries
```

### 支持参数
- `q`
- `entry_type`
- `platform`
- `source_id`
- `watchlist_id`
- `priority`
- `tag_id`
- `page`
- `page_size`

---

## 2. 获取条目详情
```http
GET /api/entries/:id
```

### 返回建议
- 基本字段
- `source`
- `watchlist`
- `tags`
- `related_documents`
- `related_digests`

---

## 3. 新建条目
```http
POST /api/entries
```

### 请求体建议
```json
{
  "title": "某酒厂发布新酒花 IPA",
  "entry_type": "brand_update",
  "summary": "...",
  "content": "...",
  "source_id": 5,
  "watchlist_id": 8,
  "platform": "xiaohongshu",
  "source_url": "https://...",
  "author_or_account": "...",
  "priority": "p2",
  "published_at": "2026-04-10T10:30:00Z"
}
```

---

## 4. 更新条目
```http
PUT /api/entries/:id
```

---

## 5. 删除条目
```http
DELETE /api/entries/:id
```

---

## 6. 条目标签接口
```http
GET /api/entries/:id/tags
POST /api/entries/:id/tags
DELETE /api/entries/:id/tags/:tag_id
```

---

## 八、Tags API

## 1. 获取标签列表
```http
GET /api/tags
```

### 支持参数
- `q`
- `tag_group`
- `status`
- `page`
- `page_size`

---

## 2. 获取标签详情
```http
GET /api/tags/:id
```

### 返回建议
- 基本字段
- `usage_counts`
- `related_sources`
- `related_documents`
- `related_digests`
- `related_entries`

---

## 3. 新建标签
```http
POST /api/tags
```

### 请求体建议
```json
{
  "name": "hops",
  "tag_group": "ingredient",
  "description": "Hop-related topics"
}
```

---

## 4. 更新标签
```http
PUT /api/tags/:id
```

---

## 5. 删除标签
```http
DELETE /api/tags/:id
```

### 说明
删除前应检查关联，第一阶段可先限制只允许删除未被使用的标签。

---

## 九、Dashboard API

Dashboard 不一定需要单独表，但建议有一个聚合接口。

## 1. 获取 Dashboard 数据
```http
GET /api/dashboard
```

### 返回建议
```json
{
  "success": true,
  "data": {
    "counts": {
      "sources": 120,
      "documents": 48,
      "digests": 32,
      "entries": 210,
      "watchlists": 56
    },
    "recent_documents": [],
    "recent_digests": [],
    "recent_entries": [],
    "focus_queue": []
  }
}
```

---

## 十、Settings / Config API（可选）

第一阶段如果想轻一点，可以先不做配置 API，直接在前端写死部分枚举。

如果要做，建议：

```http
GET /api/config/source-categories
GET /api/config/platforms
GET /api/config/priorities
GET /api/config/digest-types
GET /api/config/tag-groups
```

---

## 十一、推荐的 Express 路由结构

```text
server/src/
├── routes/
│   ├── dashboard.routes.ts
│   ├── sources.routes.ts
│   ├── watchlists.routes.ts
│   ├── documents.routes.ts
│   ├── digests.routes.ts
│   ├── entries.routes.ts
│   └── tags.routes.ts
├── controllers/
├── services/
└── db/
    └── queries/
```

### 路由职责
- routes：定义 HTTP 接口
- controllers：处理请求/响应
- services：业务逻辑
- db/queries：数据库访问

---

## 十二、第一阶段最小必做接口

如果要最快启动，建议先做这 5 组：

### 第一批
1. `GET /api/dashboard`
2. `GET /api/sources`
3. `GET /api/documents`
4. `GET /api/digests`
5. `GET /api/watchlists`

### 第二批
6. `POST /api/sources`
7. `POST /api/documents`
8. `POST /api/digests`
9. `POST /api/watchlists`

### 第三批
10. `GET /api/entries`
11. `POST /api/entries`
12. `GET /api/tags`
13. `POST /api/tags`

也就是说，第一阶段可以先从**读接口 + 核心新建接口**启动。

---

## 十三、与前端页面的直接对应

## Dashboard
- `GET /api/dashboard`

## Sources
- `GET /api/sources`
- `GET /api/sources/:id`
- `POST /api/sources`
- `PUT /api/sources/:id`

## Watchlists
- `GET /api/watchlists`
- `GET /api/watchlists/:id`
- `POST /api/watchlists`
- `PUT /api/watchlists/:id`

## Documents
- `GET /api/documents`
- `GET /api/documents/:id`
- `POST /api/documents`
- `PUT /api/documents/:id`

## Digests
- `GET /api/digests`
- `GET /api/digests/:id`
- `POST /api/digests`
- `PUT /api/digests/:id`

## Entries
- `GET /api/entries`
- `GET /api/entries/:id`
- `POST /api/entries`
- `PUT /api/entries/:id`

## Tags
- `GET /api/tags`
- `GET /api/tags/:id`
- `POST /api/tags`
- `PUT /api/tags/:id`

---

## 十四、当前判断

到这一步，BeerDirect 的：
- UI
- 数据模型
- API 草案

已经形成闭环。

接下来真正最应该推进的，不再是补更多抽象文档，而是：
- SQLite `schema.sql`
- Express 项目骨架
- Vue 3 静态页面

---

## 十五、下一步建议

在这份 API 草案之后，最适合继续推进的是：

### 1. `schema.sql`
把表结构真正写成 SQLite 建表文件。

### 2. `implementation-plan-lite.md`
把 Express、Vue 3、SQLite 的开发顺序拆出来。

### 3. Express 项目骨架
直接开始把 routes/controllers/db queries 建起来。

当前最推荐的下一步是：

**schema.sql**

因为这样文档就会开始真正变成可执行代码资产。