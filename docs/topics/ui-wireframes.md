# BeerDirect 核心页面线框（第一版）

## 说明

这份文档用于把 BeerDirect 当前已经确定的 UI 方向，从风格层进一步推进到**页面结构层**。

前面已经完成：
- Mintlify 方向确认
- BeerDirect 的 `DESIGN.md`

现在需要回答的是：

- 首页怎么排
- 来源页怎么排
- 文档页怎么排
- 摘要页怎么排
- 观察名单页怎么排

也就是：

**把“风格”变成“可实现页面骨架”。**

---

## 一、整体应用骨架

BeerDirect 第一阶段推荐采用统一应用壳结构：

```text
┌──────────────────────────────────────────────────────────────┐
│ Top Bar                                                      │
├───────────────┬──────────────────────────────────────────────┤
│ Left Sidebar  │ Main Content                                 │
│               │                                              │
│               │                                              │
│               │                                              │
├───────────────┴──────────────────────────────────────────────┤
│ Optional bottom states / feedback / status area              │
└──────────────────────────────────────────────────────────────┘
```

## 结构说明

### Top Bar
建议承载：
- 当前页面标题
- 全局搜索入口（后续）
- 快捷操作按钮
- 当前环境 / 状态提示

### Left Sidebar
建议固定为主导航：
- Dashboard
- Sources
- Watchlists
- Documents
- Digests
- Entries
- Tags
- Reports
- Settings

### Main Content
按不同页面形态切换：
- 列表管理页
- 文档阅读页
- 摘要详情页
- 混合信息页

---

## 二、Dashboard 页面线框

## 目标
Dashboard 不是 BI 看板，而是“研究系统当前状态总览”。

## 页面结构

```text
┌──────────────────────────────────────────────────────────┐
│ Page Title: Dashboard                                   │
│ Short description                                       │
├──────────────────────────────────────────────────────────┤
│ Summary Cards:                                          │
│ [Sources] [Documents] [Digests] [Entries]               │
├──────────────────────────────────────────────────────────┤
│ Recent Activity                                         │
│ - Recently added documents                              │
│ - Recently created digests                              │
│ - Recent watchlist observations                         │
├──────────────────────────────────────────────────────────┤
│ Priority Focus                                          │
│ - P1 Sources needing review                             │
│ - PDFs waiting for digest                               │
│ - Entries missing tags                                  │
├──────────────────────────────────────────────────────────┤
│ Topic Blocks                                            │
│ [Hops] [Yeast] [Haze] [Market] [China] ...              │
└──────────────────────────────────────────────────────────┘
```

## 设计重点
- 少图表
- 多状态摘要
- 强调“最近发生什么”和“接下来该处理什么”

---

## 三、Sources 页面线框

## 目标
Sources 页面是来源管理中枢。

## 页面结构

```text
┌──────────────────────────────────────────────────────────┐
│ Page Title: Sources                                     │
│ Actions: [New Source] [Import]                          │
├──────────────────────────────────────────────────────────┤
│ Filter Bar                                              │
│ [Search] [Category] [Access Type] [Priority] [Platform] │
├──────────────────────────────────────────────────────────┤
│ Source List / Table                                     │
│ ------------------------------------------------------  │
│ Name | Category | Access | Priority | Platform | Status │
│ ------------------------------------------------------  │
│ ...                                                      │
├──────────────────────────────────────────────────────────┤
│ Detail Panel / Detail Page                              │
│ - Basic metadata                                        │
│ - Notes                                                 │
│ - Related tags                                          │
│ - Related documents                                     │
│ - Watchlist connections                                 │
└──────────────────────────────────────────────────────────┘
```

## 两种实现方式建议

### 方案 A：列表 + 右侧详情抽屉
适合高频管理

### 方案 B：列表页 + 独立详情页
适合后续资料关系更复杂时

### 第一阶段建议
先做 **列表页 + 右侧详情抽屉**，实现更轻。

---

## 四、Watchlists 页面线框

## 目标
Watchlists 页面是平台型来源监测入口。

## 页面结构

```text
┌──────────────────────────────────────────────────────────┐
│ Page Title: Watchlists                                  │
│ Actions: [New Watch Item]                               │
├──────────────────────────────────────────────────────────┤
│ Platform Tabs                                           │
│ [Xiaohongshu] [Wechat] [Untappd] [X] [Instagram] ...    │
├──────────────────────────────────────────────────────────┤
│ Filter Bar                                              │
│ [Search] [Account Type] [Priority] [Region]             │
├──────────────────────────────────────────────────────────┤
│ Watchlist Table / Cards                                 │
│ Name | Platform | Type | Region | Priority | Reason     │
├──────────────────────────────────────────────────────────┤
│ Quick Detail Panel                                      │
│ - Watch reason                                          │
│ - Notes                                                 │
│ - Related sources                                       │
│ - Recent observations                                   │
└──────────────────────────────────────────────────────────┘
```

## 设计重点
- 平台切换要清楚
- 账号类型和观察理由要一眼可见
- 支持后续从 watchlist 跳到 entries

---

## 五、Documents 页面线框

## 目标
Documents 页面用于管理原始文档，包括 PDF、书籍、报告、白皮书等。

## 页面结构

```text
┌──────────────────────────────────────────────────────────┐
│ Page Title: Documents                                   │
│ Actions: [New Document] [Upload]                        │
├──────────────────────────────────────────────────────────┤
│ Filter Bar                                              │
│ [Search] [Type] [Processing Status] [Source] [Priority] │
├──────────────────────────────────────────────────────────┤
│ Document List                                           │
│ ------------------------------------------------------  │
│ Title | Type | Source | Status | Language | Updated     │
│ ------------------------------------------------------  │
│ ...                                                      │
├──────────────────────────────────────────────────────────┤
│ Selected Document Detail                                │
│ - Metadata                                               │
│ - Original file path / link                              │
│ - Related digest status                                  │
│ - Tags                                                   │
│ - Notes                                                  │
└──────────────────────────────────────────────────────────┘
```

## 推荐交互
- 列表页适合表格
- 文档详情页适合文档式布局

### 文档详情页进一步结构

```text
┌──────────────────────────────────────────────────────────┐
│ Document Title                                          │
│ Meta row: Type / Source / Language / Status             │
├──────────────────────────────────────────────────────────┤
│ Summary Panel                                           │
├──────────────────────────────────────────────────────────┤
│ Related Digests                                         │
├──────────────────────────────────────────────────────────┤
│ Notes / Processing History                              │
├──────────────────────────────────────────────────────────┤
│ Tags / Related Topics                                   │
└──────────────────────────────────────────────────────────┘
```

---

## 六、Digests 页面线框

## 目标
Digests 页面是 BeerDirect 的核心页面之一。

它承载：
- Markdown 摘要
- 章节提炼
- 论文摘要
- PDF 核心内容压缩结果

## 列表页结构

```text
┌──────────────────────────────────────────────────────────┐
│ Page Title: Digests                                     │
│ Actions: [New Digest]                                   │
├──────────────────────────────────────────────────────────┤
│ Filter Bar                                              │
│ [Search] [Digest Type] [Topic] [Source] [Document]      │
├──────────────────────────────────────────────────────────┤
│ Digest List                                             │
│ Title | Type | Related Document | Topic | Updated       │
└──────────────────────────────────────────────────────────┘
```

## 详情页结构（重点）

```text
┌────────────────────────────────────────────────────────────────────┐
│ Title                                                             │
│ Meta: Digest Type / Document / Source / Updated                   │
├───────────────┬──────────────────────────────────────┬─────────────┤
│ Left TOC      │ Main Markdown Content                │ Right Meta  │
│               │                                      │             │
│ - Sections    │ ## Summary                           │ Tags        │
│ - Headings    │ ## Key Findings                      │ Source Info │
│               │ ## Key Parameters                    │ Page Refs   │
│               │ ## Notes                             │ Related Docs│
│               │ ## Related Topics                    │             │
└───────────────┴──────────────────────────────────────┴─────────────┘
```

## 设计重点
- 最接近 Mintlify 文档体验
- 强调阅读
- 页码、来源、标签、关联内容必须容易看到
- 支持关键结论用 callout 突出

---

## 七、Entries 页面线框

## 目标
Entries 页面是研究记录流。

包括：
- 新闻条目
- 技术条目
- 平台观察条目
- 品牌动态条目

## 页面结构

```text
┌──────────────────────────────────────────────────────────┐
│ Page Title: Entries                                     │
│ Actions: [New Entry]                                    │
├──────────────────────────────────────────────────────────┤
│ Filter Bar                                              │
│ [Search] [Type] [Platform] [Source] [Topic] [Date]      │
├──────────────────────────────────────────────────────────┤
│ Entry Stream / Table                                    │
│ ------------------------------------------------------  │
│ Title                                                   │
│ Meta: type · source · platform · date · tags           │
│ Short preview                                            │
│ ------------------------------------------------------  │
│ ...                                                      │
└──────────────────────────────────────────────────────────┘
```

## 第一阶段建议
Entries 列表更适合做成：
- 表格与流式卡片的混合
- 不要完全做成资讯门户

---

## 八、Tags 页面线框

## 目标
Tags 页面用于维护知识分类体系。

## 页面结构

```text
┌──────────────────────────────────────────────────────────┐
│ Page Title: Tags                                        │
│ Actions: [New Tag]                                      │
├──────────────────────────────────────────────────────────┤
│ Filter / Search                                         │
├──────────────────────────────────────────────────────────┤
│ Tag List                                                │
│ Name | Group | Usage Count | Related Sources | Notes    │
├──────────────────────────────────────────────────────────┤
│ Tag Detail                                              │
│ - Description                                           │
│ - Related documents                                     │
│ - Related entries                                       │
│ - Related sources                                       │
└──────────────────────────────────────────────────────────┘
```

---

## 九、Settings 页面线框

## 目标
Settings 第一阶段不需要太重，只保留基础配置。

## 页面结构

```text
┌──────────────────────────────────────────────────────────┐
│ Page Title: Settings                                    │
├──────────────────────────────────────────────────────────┤
│ Sections                                                │
│ - Source categories                                     │
│ - Platforms                                             │
│ - Priority definitions                                  │
│ - Digest types                                          │
│ - Tag groups                                            │
└──────────────────────────────────────────────────────────┘
```

---

## 十、第一阶段优先实现顺序

为了避免一下铺太大，建议页面按这个顺序实现：

## 第一批
1. App Shell（Sidebar + Top Bar）
2. Dashboard
3. Sources
4. Documents
5. Digests

## 第二批
6. Watchlists
7. Entries
8. Tags

## 第三批
9. Settings
10. Reports

---

## 十一、实现建议

在 Vue 3 阶段，建议先做：
- 静态页面骨架
- 假数据填充
- 组件系统初稿

然后再接 Express API 和 SQLite。

原因：
- 可以更快验证 UI 是否合理
- 可以提早调整页面结构
- 不会一开始就被后端绑定住

---

## 十二、下一步建议

在这份页面线框之后，最适合继续推进的是：

### 1. component-inventory.md
列出要做的核心组件清单。

### 2. ui-content-model.md
定义页面里会出现哪些信息块和字段。

### 3. Vue 3 静态原型
先把 Dashboard / Sources / Documents / Digests 这四页做成静态页面。

当前最推荐的下一步是：

**component-inventory.md**

这样后面前端实现会非常顺。