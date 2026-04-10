# BeerDirect 技术架构方案（第一版）

## 目标

这份文档用于明确 BeerDirect 第一阶段的实现方向，重点回答三个问题：

1. 前端怎么做
2. 后端怎么做
3. 第一阶段如何用最小复杂度把系统跑起来

BeerDirect 当前不是一个高并发消费级产品，而是一个以：

- 来源管理
- 文档处理
- 知识沉淀
- 检索与研究
- 后续自动化扩展

为核心的资料系统。

因此，第一阶段技术架构应优先满足：

- 开发快
- 维护简单
- 结构清晰
- 易于本地部署
- 易于后续扩展到自动抓取、摘要、检索和任务调度

---

## 一、BeerDirect 第一阶段要实现什么

第一阶段的核心不是复杂交互，而是把基础能力建立起来。

## 第一阶段建议能力

### 1. 来源管理
- 新增来源
- 编辑来源
- 来源分类
- 优先级标记
- 观察名单管理

### 2. 文档管理
- 上传或登记 PDF / 文档
- 记录原始来源
- 保存 Markdown 提炼结果
- 主题标签与来源关联

### 3. 资料条目管理
- 新闻条目
- 技术文章条目
- 平台观察记录
- PDF 摘要条目

### 4. 检索与筛选
- 按主题、来源类型、平台、标签搜索
- 按时间、优先级、来源类别筛选

### 5. 后台操作界面
- 内部使用为主
- 重点是高效录入和查看，不是面向公众的复杂产品

---

## 二、推荐的整体实现方向

## 结论

对于 BeerDirect 第一阶段，最推荐的实现方式是：

### 前端
- **Next.js**
- 使用 App Router
- TypeScript
- Tailwind CSS
- 组件库可选：shadcn/ui

### 后端
- **Next.js API Routes / Route Handlers** 作为第一阶段后端
- ORM：**Prisma**
- 任务处理：先用脚本 + cron / GitHub Actions，后续再引入独立 worker

### 数据库
- **SQLite 可以作为第一阶段主库，且是可行的**
- 第二阶段若写入并发增多，再迁移 PostgreSQL

这套方案的核心优点是：
- 单仓库开发
- 前后端一体化
- 上手快
- 后续可平滑升级

---

## 三、前端实现建议

## 为什么前端不需要一开始做得很重

BeerDirect 第一阶段前端的本质更接近：
- 研究后台
- 内容管理界面
- 内部工作台

而不是：
- 面向大量外部用户的复杂社区产品
- 高交互消费级 SaaS

所以前端应以：
- 可快速开发
- 表单和表格友好
- 检索和筛选清晰
- 方便后续接 AI 功能

为优先。

## 推荐方案：Next.js

### 推荐理由
- React 生态成熟
- 页面、API、服务端渲染可以放在一起
- 适合后台类系统和内容类系统
- 以后接搜索、鉴权、后台、管理台都方便
- 部署方式灵活

## 前端技术建议
- Next.js
- TypeScript
- Tailwind CSS
- shadcn/ui
- TanStack Table（如果后面表格多）
- React Hook Form（如果表单复杂）

## 第一阶段前端页面建议

### 1. Dashboard
展示：
- 来源数量
- 最近新增条目
- 最近处理 PDF
- 最近观察记录

### 2. Sources
展示：
- 来源列表
- 来源详情
- 分类 / 平台 / 优先级筛选

### 3. Documents
展示：
- PDF / Markdown 摘要列表
- 原始文档与提炼结果关联

### 4. Entries
展示：
- 新闻 / 技术 / 平台观察 / 摘要条目
- 标签和来源关系

### 5. Watchlists
展示：
- 小红书 / 公众号 / UT / X 等观察名单

### 6. Settings / Config
展示：
- 来源配置
- 标签体系
- 处理状态

---

## 四、后端实现建议

## 第一阶段推荐：不要单独拆重后端

BeerDirect 第一阶段不建议一上来就做：
- 独立 NestJS 服务
- 独立 Python API 服务
- 多服务微服务架构

原因很简单：
- 现在核心问题是资料系统跑起来
- 还没到高并发和多团队协作阶段
- 过早拆分会增加复杂度

## 第一阶段推荐方案
- Next.js Route Handlers / API Routes
- Prisma 做数据库访问
- Node 脚本处理导入、清洗、批量任务

## 为什么这样更适合
- 前后端在一个代码库里
- 管理台、API、数据模型一致
- 先把 CRUD、检索、录入、文档管理做稳
- 后面再决定是否拆服务

## 后端第一阶段应该承担的能力

### 1. 来源管理 API
- 新增来源
- 更新来源
- 标记优先级
- 绑定分类

### 2. 文档管理 API
- 上传文档元信息
- 保存 Markdown 摘要
- 记录原始 PDF 信息和处理状态

### 3. 条目管理 API
- 新增新闻条目
- 新增技术条目
- 新增平台观察记录
- 新增 PDF 摘要记录

### 4. 搜索 / 筛选 API
- 按标签
- 按来源
- 按时间
- 按类型

### 5. 后续可扩展任务
- 定时抓取
- 批量导入
- 自动摘要
- 自动打标签

---

## 五、为什么暂时不建议 Python 做主后端

不是说 Python 不适合，而是第一阶段不适合把 Python 放在主 Web 后端位置。

## Python 更适合承担的角色
- 抓取脚本
- PDF 处理
- 文本清洗
- NLP / 摘要
- 数据导入导出

## 不建议一开始用 Python 做主后端的原因
- 前后端联调效率不一定更高
- 如果同时做管理台，React + TS + Node 一体化更顺
- BeerDirect 第一阶段更多是后台内容系统，不是计算密集 API 平台

## 更合理的分工
- Web 应用：Next.js
- 数据处理脚本：Python 或 Node 均可
- 后续 AI / PDF pipeline：可逐步引入 Python

---

## 六、建议的项目目录结构

```text
BeerDirect/
├── apps/
│   └── web/                  # Next.js 前后端一体项目
├── packages/
│   ├── ui/                   # 可复用 UI 组件（后续）
│   ├── config/               # 共享配置（后续）
│   └── types/                # 共享类型（后续）
├── prisma/
│   ├── schema.prisma
│   └── migrations/
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

## 如果第一阶段更想简单一点
也可以先不做 monorepo，直接：

```text
BeerDirect/
├── app/
├── components/
├── lib/
├── prisma/
├── scripts/
├── data/
├── docs/
└── config/
```

这对第一阶段反而更轻。

---

## 七、推荐的第一阶段模块设计

## 1. Source 模块
管理来源定义。

字段示例：
- name
- category
- access_type
- platform
- priority
- url
- notes

## 2. Watchlist 模块
管理平台账号或观察对象。

字段示例：
- platform
- account_name
- account_type
- watch_reason
- priority

## 3. Document 模块
管理 PDF、书籍、杂志、报告等原始资料。

字段示例：
- title
- source_id
- file_path / source_url
- file_type
- processing_status
- original_language

## 4. Digest 模块
管理 Markdown 摘要、章节提炼、核心知识卡片。

字段示例：
- document_id
- digest_type
- markdown_content
- summary
- page_refs

## 5. Entry 模块
管理日常采集的新闻、技术文章、平台观察条目。

字段示例：
- title
- entry_type
- source_id
- content
- published_at
- tags

## 6. Tag 模块
统一标签系统。

例如：
- hops
- yeast
- haze
- packaging
- market
- china
- hazy_ipa

---

## 八、第一阶段开发顺序建议

## Step 1
先搭建基础管理台：
- 来源管理
- 标签管理
- 文档管理

## Step 2
再做条目管理：
- 新闻条目
- 技术条目
- 平台观察记录

## Step 3
再做 PDF 摘要与 Markdown 内容管理。

## Step 4
最后再接：
- 搜索
- 自动抓取
- 自动摘要
- 定时任务

---

## 九、SQLite 在这个架构里的角色

SQLite 在第一阶段是可用的，而且很适合：
- 本地开发
- 单人或小团队内部系统
- 中低频写入
- 结构先跑起来

它和 Next.js + Prisma 的组合也很常见。

但是数据库细节和迁移策略，建议看单独文档：
- `database-selection.md`

---

## 十、当前建议结论

对于 BeerDirect 第一阶段，我的明确建议是：

### 推荐技术栈
- 前端：Next.js + TypeScript + Tailwind + shadcn/ui
- 后端：Next.js Route Handlers + Prisma
- 数据处理：Node / Python 脚本
- 数据库：SQLite 起步

### 为什么这样最好
- 最省复杂度
- 最容易快速出后台系统
- 最适合来源管理 + 文档管理 + 研究系统
- 后续能平滑迁移到 PostgreSQL 和更复杂的任务架构

---

## 十一、后续技术文档建议

在这份文档之后，最适合继续补的是：

### 1. database-selection.md
明确 SQLite 是否可行、边界在哪、何时迁移 PostgreSQL。

### 2. data-model-draft.md
先把核心表结构起草出来。

### 3. mvp-scope.md
把第一阶段最小功能再收紧一次，防止做散。
