# BeerDirect 组件清单（第一版）

## 说明

这份文档用于把 BeerDirect 当前已经确定的：

- UI 方向
- DESIGN.md
- 页面线框

进一步推进成真正可开发的**组件层清单**。

也就是说，从现在开始，我们不再只讨论“页面长什么样”，而是要回答：

- 前端要做哪些组件
- 哪些组件是全局基础组件
- 哪些组件是文档型页面专用组件
- 哪些组件是后台管理页专用组件

这一步的意义是：

**把 UI 研究转成 Vue 3 实现的可执行清单。**

---

## 一、组件设计原则

BeerDirect 的组件体系应遵循以下原则：

## 1. 文档优先，而不是纯表单优先
BeerDirect 很多页面承载的是：
- 资料
- 摘要
- 文档
- 观察记录
- 标签与关系

所以组件体系不能只围绕“后台表单组件”来设计。

## 2. 管理能力和阅读能力并重
组件既要支持：
- 管理
- 录入
- 筛选

也要支持：
- 阅读
- 浏览
- 关联理解

## 3. 尽量少而稳
第一阶段不需要搭大而全设计系统。

建议：
- 先做一小套高频组件
- 保证统一性
- 后续再扩展

## 4. 组件命名要贴近实际页面任务
避免一开始做太抽象、太泛化的命名。

例如：
- `DocumentMetaPanel`
- `DigestContentBlock`
- `WatchReasonBadgeGroup`

这种命名反而更适合当前阶段。

---

## 二、组件分层建议

建议把组件分成 4 层：

## Layer 1：App Shell 组件
负责整体应用框架。

## Layer 2：基础 UI 组件
负责按钮、标签、卡片、输入框等基础构件。

## Layer 3：业务组合组件
负责来源卡片、文档元信息块、筛选条等。

## Layer 4：页面级组件
负责某类页面专有结构，例如摘要阅读页的目录区。

---

## 三、Layer 1：App Shell 组件

这些组件先做，后面所有页面都会用到。

## 1. `AppSidebar`
### 作用
全局左侧导航。

### 包含
- Logo / Project name
- Primary nav items
- Secondary grouped items
- Active state

### 用于页面
- 全部页面

---

## 2. `AppTopbar`
### 作用
全局顶部栏。

### 包含
- 页面标题
- 页面说明（可选）
- 快捷操作按钮
- 全局搜索入口（后续）

### 用于页面
- 全部页面

---

## 3. `PageContainer`
### 作用
统一页面外层布局和宽度控制。

### 用于页面
- 全部页面

---

## 4. `PageHeader`
### 作用
统一页面标题区。

### 包含
- title
- description
- actions
- optional meta

### 用于页面
- Dashboard
- Sources
- Watchlists
- Documents
- Digests
- Entries
- Tags

---

## 四、Layer 2：基础 UI 组件

这些组件是最小 UI 基础设施。

## 5. `BaseButton`
### 变体
- primary
- secondary
- ghost
- danger

---

## 6. `BaseCard`
### 作用
统一卡片容器。

### 用途
- summary cards
- metadata blocks
- related lists
- content blocks

---

## 7. `BaseTag`
### 作用
通用标签。

### 标签类型
- topic
- platform
- source type
- digest type
- neutral

---

## 8. `StatusBadge`
### 作用
表达状态。

### 状态例子
- active
- archived
- processing
- completed
- draft
- error

---

## 9. `PriorityBadge`
### 作用
表达 P1 / P2 / P3 优先级。

### 说明
建议和普通 status 分开。

---

## 10. `BaseInput`
### 作用
统一文本输入。

---

## 11. `BaseTextarea`
### 作用
统一多行输入。

---

## 12. `BaseSelect`
### 作用
统一下拉选择。

---

## 13. `BaseTabs`
### 作用
平台切换、模块切换。

### 用途
- Watchlists page
- Document / Digest sections

---

## 14. `BaseTable`
### 作用
统一管理型表格。

### 特点
- soft borders
- row hover
- compact readable cells

---

## 15. `EmptyState`
### 作用
统一空状态展示。

### 用途
- no documents
- no digests
- no sources
- no search results

---

## 16. `LoadingState`
### 作用
统一加载状态。

---

## 17. `CalloutBlock`
### 作用
高亮关键信息。

### 变体
- info
- key takeaway
- warning
- note
- source note

---

## 五、Layer 3：业务组合组件

这些是 BeerDirect 真正最重要的一层。

## 18. `FilterBar`
### 作用
统一筛选条。

### 可插入内容
- search
- select filters
- tag filters
- date filters
- quick actions

### 用途
- Sources
- Watchlists
- Documents
- Digests
- Entries
- Tags

---

## 19. `SummaryStatCard`
### 作用
Dashboard 顶部统计卡片。

### 内容
- label
- count/value
- short hint
- optional trend/secondary info

---

## 20. `RecentActivityList`
### 作用
Dashboard 最近活动列表。

---

## 21. `FocusQueueCard`
### 作用
Dashboard 待处理事项卡片。

例如：
- PDFs waiting for digest
- P1 sources to review
- entries missing tags

---

## 22. `SourceListTable`
### 作用
Sources 页的主列表。

### 字段建议
- name
- category
- access type
- priority
- platform
- status

---

## 23. `SourceMetaPanel`
### 作用
来源详情元信息块。

### 内容
- basic fields
- notes
- related tags
- related docs
- related watchlists

---

## 24. `WatchlistTable`
### 作用
观察名单主表。

### 字段建议
- name
- platform
- account type
- region
- priority
- watch reason

---

## 25. `WatchReasonBadgeGroup`
### 作用
展示观察理由标签组。

例如：
- new_release
- trend
- technical_discussion
- consumer_feedback

---

## 26. `DocumentListTable`
### 作用
文档列表主表。

### 字段建议
- title
- type
- source
- processing status
- language
- updated at

---

## 27. `DocumentMetaPanel`
### 作用
文档详情元信息区。

### 内容
- document type
- source
- original link/path
- processing status
- language
- tags

---

## 28. `RelatedDigestList`
### 作用
文档详情中展示相关摘要。

---

## 29. `DigestListTable`
### 作用
摘要列表主表。

### 字段建议
- title
- digest type
- related document
- topic
- updated at

---

## 30. `DigestHeader`
### 作用
摘要详情页顶部头部。

### 内容
- title
- digest type
- related document
- source
- updated date
- tags

---

## 31. `DigestToc`
### 作用
摘要页左侧目录。

---

## 32. `DigestContentBlock`
### 作用
摘要正文 Markdown 区域。

### 要求
- heading hierarchy
- callout support
- quote block support
- list readability
- code/structured block readability

---

## 33. `DigestMetaSidebar`
### 作用
摘要页右侧辅助信息栏。

### 内容
- tags
- source info
- page refs
- related docs
- related topics

---

## 34. `EntryListItem`
### 作用
条目列表项。

### 内容
- title
- meta line
- short preview
- tags

---

## 35. `TagListTable`
### 作用
标签管理列表。

---

## 36. `TagMetaPanel`
### 作用
标签详情块。

### 内容
- description
- usage count
- related docs
- related entries
- related sources

---

## 六、Layer 4：页面级组件

这些组件更接近具体页面结构。

## 37. `DashboardOverviewSection`
### 用途
Dashboard 头部总览区。

---

## 38. `DashboardTopicBlock`
### 用途
Dashboard 主题块。

例如：
- hops
- yeast
- haze
- market
- china

---

## 39. `DocumentDetailLayout`
### 用途
文档详情页专用布局。

---

## 40. `DigestDetailLayout`
### 用途
摘要详情页三栏布局。

---

## 41. `WatchlistPlatformSection`
### 用途
按平台分组展示 watchlists。

---

## 七、第一阶段必须先做的组件

为了不铺太大，建议先做最小高频集。

## 第一批必做
1. `AppSidebar`
2. `AppTopbar`
3. `PageHeader`
4. `PageContainer`
5. `BaseButton`
6. `BaseCard`
7. `BaseTag`
8. `StatusBadge`
9. `PriorityBadge`
10. `BaseInput`
11. `BaseSelect`
12. `BaseTable`
13. `FilterBar`
14. `SummaryStatCard`
15. `SourceListTable`
16. `DocumentListTable`
17. `DigestHeader`
18. `DigestContentBlock`
19. `DigestToc`
20. `DigestMetaSidebar`

这批做完，就能先支撑：
- Dashboard
- Sources
- Documents
- Digests

---

## 八、第二阶段组件

## 第二批建议
21. `WatchlistTable`
22. `WatchReasonBadgeGroup`
23. `EntryListItem`
24. `TagListTable`
25. `TagMetaPanel`
26. `RelatedDigestList`
27. `CalloutBlock`
28. `EmptyState`
29. `LoadingState`

---

## 九、实现建议

## Vue 3 中建议的目录结构

```text
client/src/
├── components/
│   ├── app-shell/
│   ├── base/
│   ├── data-display/
│   ├── filters/
│   ├── digest/
│   ├── documents/
│   ├── sources/
│   ├── watchlists/
│   └── tags/
├── layouts/
├── pages/
└── composables/
```

## 命名建议
- 基础组件：`BaseXxx`
- 状态组件：`XxxBadge`
- 业务块组件：`SourceXxx`, `DocumentXxx`, `DigestXxx`
- 页面布局组件：`XxxLayout`

这样后续会很清楚。

---

## 十、当前判断

到这一步，BeerDirect 的 UI 研究已经进入真正可以开发的状态。

现在你已经有了：
- UI 方向
- DESIGN.md
- 页面线框
- 组件清单

后面前端实现时，不需要再靠临场想象页面怎么长，而可以按这套结构逐步落地。

---

## 十一、下一步建议

在组件清单之后，最适合继续推进的是：

### 1. `ui-content-model.md`
定义每个页面会出现哪些字段和信息块。

### 2. 直接开始 Vue 3 静态原型
先做：
- Dashboard
- Sources
- Documents
- Digests

### 3. `api-draft.md`
把前端需要请求的接口也先列出来。

当前最推荐的下一步是：

**ui-content-model.md**

因为它会把“组件长什么样”进一步推进到“组件里面到底装什么信息”。