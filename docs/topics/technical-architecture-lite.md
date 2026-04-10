# BeerDirect 技术架构方案（轻量修订版）

## 说明

这份文档用于替代前一版偏 Next.js / Prisma 的方案，明确 BeerDirect 当前更适合采用一套**更轻、更直接、更少抽象层**的实现方式。

本次修订遵循三个明确原则：

1. 前端改为 **Vue 3**
2. **不使用 Prisma**
3. 后端进一步简化，采用 **Express**

核心目标不是做一套“标准大厂架构”，而是做一套：

- 容易启动
- 容易维护
- 容易本地部署
- 容易理解
- 方便逐步扩展

的 BeerDirect 第一阶段实现方案。

---

## 一、先说结论

对于 BeerDirect 第一阶段，推荐的最简技术路线是：

### 前端
- Vue 3
- Vite
- TypeScript
- Pinia
- Vue Router
- UI 可选：Naive UI / Element Plus / 自己少量封装

### 后端
- Express
- TypeScript 可选，但如果想更轻，也可以先 JavaScript
- 路由按模块拆分
- 中间层尽量少

### 数据库
- SQLite
- 不使用 Prisma
- 直接使用轻量数据库访问方式，例如：
  - `better-sqlite3`
  - 或 `sqlite3`

### 数据处理
- Node 脚本优先
- Python 仅用于 PDF、清洗、摘要等确实更适合的场景

这套组合的核心优势是：
- 足够轻
- 学习和维护成本低
- 非常适合内部研究系统 / 内容管理台
- 对 BeerDirect 这种资料系统非常实际

---

## 二、为什么这套方案比上一版更适合当前阶段

上一版的思路更偏：
- 前后端一体化框架
- ORM 驱动
- 相对“现代全栈”

但你现在明确提出：
- Vue 3
- 不要 Prisma
- 后端进一步简化

这意味着项目当前更适合遵循：

### 原则 1：少层级
不要引入过多抽象。

### 原则 2：少魔法
不要用太多框架隐式约定。

### 原则 3：能直接看到数据流
前端请求什么、后端返回什么、数据库怎么存，尽量清楚直白。

### 原则 4：优先“可维护的小系统”
BeerDirect 当前不是通用平台，而是一个围绕来源管理、文档处理和研究工作的内部工具。

所以：

**Vue 3 + Express + SQLite + 直接 SQL/轻封装**

比

**Next.js + Prisma + 更重一体化方案**

更符合你现在的方向。

---

## 三、前端方案建议

## 推荐：Vue 3 + Vite

### 为什么适合
- 启动快
- 配置轻
- 非常适合后台管理台
- Vue 在表单、后台、配置界面这类场景里开发体验很好

## 推荐前端栈
- Vue 3
- Vite
- TypeScript
- Vue Router
- Pinia
- Axios 或原生 fetch
- UI 库建议二选一：
  - Naive UI：更现代，适合后台工具
  - Element Plus：成熟稳妥，表单和表格生态强

## 第一阶段前端页面建议

### 1. Dashboard
显示：
- 来源总数
- 最近新增文档
- 最近摘要
- 最近观察记录

### 2. Sources
- 来源列表
- 新增 / 编辑来源
- 分类筛选
- 优先级筛选

### 3. Watchlists
- 平台观察名单
- 按平台分组
- 账号 / 品牌 / 门店分类

### 4. Documents
- PDF / 书籍 / 白皮书 / 讲义列表
- 原始信息与处理状态

### 5. Digests
- Markdown 摘要
- 章节提炼
- 论文摘要

### 6. Entries
- 新闻条目
- 技术条目
- 平台观察条目

### 7. Tags
- 标签管理
- 主题体系维护

---

## 四、后端方案建议

## 推荐：Express

这一步是合理的，因为 BeerDirect 当前后端需求非常明确：
- CRUD
- 搜索与筛选
- 文档元信息管理
- 为前端提供简单 API

不需要一开始就上更复杂的后端框架。

## 推荐后端原则

### 1. 路由清晰
按资源划分路由：
- `/sources`
- `/watchlists`
- `/documents`
- `/digests`
- `/entries`
- `/tags`

### 2. 服务层适度，不要过度设计
可以有简单 service / repository 分层，但不要太重。

### 3. 先不要引入复杂鉴权
如果当前是本地或内部工具，先把核心管理台跑通。

### 4. 先不要引入消息队列
抓取、导入、清洗先用脚本和定时任务即可。

---

## 五、为什么不使用 Prisma 是合理的

你现在要求不用 Prisma，这在 BeerDirect 第一阶段完全成立。

## 不用 Prisma 的好处
- 少一层抽象
- 少一套 schema 和 migration 心智负担
- 更直接控制 SQL 和表结构
- 对 SQLite 这种轻量数据库更直接

## 可能的代价
- 你要自己更明确管理 SQL
- 迁移和表结构变更不能完全依赖 ORM 自动化

但对于 BeerDirect 当前规模，这个代价是可接受的。

## 推荐做法
不要直接到处散写 SQL，而是：
- 建一个 `db/` 目录
- 把每个模块的 SQL 操作收束在单独文件里

例如：

```text
server/
├── db/
│   ├── index.ts
│   ├── schema.sql
│   ├── migrations/
│   └── queries/
│       ├── sources.ts
│       ├── documents.ts
│       ├── digests.ts
│       └── entries.ts
```

这样既轻，又不会太乱。

---

## 六、数据库访问建议

## 首选：better-sqlite3

如果你想要：
- 更轻
- API 简单
- 本地工具和内部系统体验好

那么 `better-sqlite3` 很适合。

### 优点
- 简单直接
- 性能对这类项目足够
- 同步 API 对后台系统反而更直观
- 很适合 Express + SQLite 的小中型内部工具

## 也可选：sqlite3
但如果从开发体验和简洁性看，我更偏向 `better-sqlite3`。

---

## 七、推荐项目结构

为了尽可能简单，建议不要一开始搞 monorepo。

## 推荐目录

```text
BeerDirect/
├── client/                    # Vue 3 前端
│   ├── src/
│   ├── public/
│   └── vite.config.ts
├── server/                    # Express 后端
│   ├── src/
│   │   ├── routes/
│   │   ├── controllers/
│   │   ├── services/
│   │   ├── db/
│   │   ├── utils/
│   │   └── app.ts
│   └── data/
│       └── beerdirect.sqlite
├── scripts/
│   ├── collectors/
│   ├── cleaners/
│   ├── importers/
│   └── exporters/
├── data/
│   ├── raw/
│   ├── cleaned/
│   └── curated/
├── docs/
└── config/
```

### 为什么这样更合适
- 前后端明确分开
- 结构一眼能懂
- 不需要太多工具链知识
- 后续也容易改成单独部署

---

## 八、第一阶段 API 设计建议

## Sources
- `GET /api/sources`
- `POST /api/sources`
- `PUT /api/sources/:id`
- `DELETE /api/sources/:id`

## Watchlists
- `GET /api/watchlists`
- `POST /api/watchlists`
- `PUT /api/watchlists/:id`
- `DELETE /api/watchlists/:id`

## Documents
- `GET /api/documents`
- `POST /api/documents`
- `PUT /api/documents/:id`

## Digests
- `GET /api/digests`
- `POST /api/digests`
- `PUT /api/digests/:id`

## Entries
- `GET /api/entries`
- `POST /api/entries`
- `PUT /api/entries/:id`

## Tags
- `GET /api/tags`
- `POST /api/tags`

第一阶段保持 REST 风格最简单，不需要急着做 GraphQL 或 RPC 风格。

---

## 九、第一阶段最小模块

为了避免架构虽然简化了，但需求又膨胀，建议 MVP 只做：

### 必做
- 来源管理
- 平台观察名单管理
- 文档记录管理
- Markdown 摘要管理
- 标签管理

### 第二步再做
- 条目管理
- 搜索筛选增强
- PDF 处理流程状态

### 再之后
- 自动抓取
- 自动摘要
- 调度任务
- 多用户和权限

---

## 十、对 SQLite 的配合建议

在这套轻架构里，SQLite 反而更自然。

因为现在已经没有：
- Prisma
- 重后端框架
- 复杂一体化平台

于是整体会变成：

- Vue 3 前端
- Express API
- SQLite 文件数据库
- 直接 SQL 或轻封装查询

这套组合非常适合 BeerDirect 第一阶段。

---

## 十一、明确结论

对 BeerDirect 当前阶段，我的推荐方案修订为：

### 前端
- Vue 3 + Vite + TypeScript + Pinia + Vue Router

### 后端
- Express

### 数据访问
- better-sqlite3
- 不用 Prisma
- SQL / 轻量查询层

### 数据库
- SQLite

### 任务与处理
- Node 脚本优先
- Python 只承担 PDF、文本处理等确实更适合的工作

这套方案最大的优点是：

**够轻、够清晰、够实用，而且很适合 BeerDirect 当前阶段。**

---

## 十二、下一步建议

在这个轻量方案下，最值得继续补的不是再谈框架，而是：

### 1. data-model-draft.md
把表结构真正定下来。

### 2. mvp-scope.md
把第一阶段页面和接口收紧。

### 3. implementation-plan-lite.md
把前后端、SQLite、脚本、目录结构串成开发步骤。