# BeerDirect UI 方向研究：Mintlify 路线

## 说明

经过前一轮 UI 研究，BeerDirect 当前决定采用 **Mintlify 风格方向** 作为主要 UI 参考。

这里说的“采用 Mintlify 风格”，不是照搬对方页面，而是吸收其最适合 BeerDirect 的几个核心特征：

- 清晰的文档层级
- 适合知识系统的导航结构
- 强可读性
- 轻技术感
- 干净的卡片和信息块
- 对长文档、说明文字、结构化资料很友好

BeerDirect 的定位是：

- 啤酒情报研究后台
- 来源管理系统
- 文档与摘要管理系统
- 知识沉淀与检索工作台

因此，相比纯营销站风格或纯仪表盘风格，Mintlify 更适合作为主方向。

---

## 一、为什么 Mintlify 适合 BeerDirect

## 1. BeerDirect 本质上是“知识系统”，不是普通后台

BeerDirect 不是单纯的数据后台，也不是普通 CRM。

它的核心对象是：
- 来源
- 文档
- 摘要
- 技术资料
- 平台观察记录
- 标签与主题

这意味着很多页面的核心任务不是“操作”，而是：
- 阅读
- 理解
- 比较
- 检索
- 归档

Mintlify 的优势正好在这里。

---

## 2. Mintlify 的信息层级很适合文档和研究场景

BeerDirect 后面会有很多内容是：
- Markdown 摘要
- PDF 提炼
- 技术主题页
- 来源说明页
- 标签聚合页

这些页面如果用太强的“仪表盘风格”，会牺牲阅读体验。

Mintlify 则更适合：
- 左侧导航
- 中间正文
- 右侧目录 / 辅助信息
- 清晰的 section 层级
- 适合长文本和结构化内容的排版

---

## 3. 它比 Notion 更“系统”，比 Linear 更“可读”

### 和 Notion 比
- Mintlify 更技术文档化
- 结构更清晰
- 边界感更强
- 更适合系统型知识库

### 和 Linear 比
- Mintlify 没那么冷
- 阅读压力更小
- 长内容承载能力更强

对于 BeerDirect，这种平衡非常合适。

---

## 二、BeerDirect 不应该照搬 Mintlify 的部分

虽然整体方向选 Mintlify，但 BeerDirect 不能完全照搬。

## 1. 不要做成纯开发者文档站
Mintlify 很强的一个特征是“开发文档站感”。

BeerDirect 虽然也有技术内容，但还包括：
- 行业情报
- 品牌观察
- 平台动态
- PDF 摘要
- 研究工作流

所以 BeerDirect 不能太像 API docs 网站。

## 2. 不要过度轻量到失去后台操作感
BeerDirect 仍然需要：
- 列表页
- 表格页
- 标签页
- 管理页
- 状态页

所以不能只保留“阅读感”，还要加入适量的后台管理骨架。

## 3. 不要太白、太软
BeerDirect 的内容密度比一般品牌文档更高。

建议整体保留 Mintlify 的清晰感，但让信息密度略高一点，结构更有骨架。

---

## 三、BeerDirect 适合吸收的 Mintlify 特征

## 1. 页面结构
推荐采用三段式思路：
- 左侧：全局导航
- 中间：主内容区
- 右侧：页面目录 / 元信息 / 快速操作

不是所有页面都要三栏，但文档页和摘要页尤其适合。

## 2. 文本层级
Mintlify 很适合借鉴的部分包括：
- 标题层级清晰
- 段落密度舒适
- 小标题强于正文但不夸张
- 提示块、说明块、引用块都很清楚

## 3. 内容块组件
BeerDirect 应重点借鉴这些 UI 模块：
- 信息卡片
- 标签组
- 状态块
- 提示块
- Callout
- 目录索引块
- 文档元信息块

## 4. 色彩策略
不要太花。

建议：
- 中性色为主
- 一种主品牌色做强调
- 状态色克制使用
- 让标签和状态有区分，但不刺眼

## 5. 导航方式
BeerDirect 非常适合：
- 左侧主导航
- 子层级折叠
- 清晰的信息架构

例如：
- Dashboard
- Sources
- Watchlists
- Documents
- Digests
- Entries
- Tags
- Reports
- Settings

---

## 四、BeerDirect 的页面如何应用 Mintlify 风格

## 1. Dashboard
不应做成传统 BI 风格。

更适合：
- 顶部简洁摘要区
- 中间近期活动 / 最近新增
- 下方按主题分组

目标：
- 一眼看清资料系统最近在发生什么
而不是塞满图表。

## 2. Sources 页面
适合：
- 左侧筛选
- 中间来源列表
- 详情页偏文档式布局

重点：
- 来源信息可读
- 分类和优先级清晰
- 不只是表格

## 3. Documents 页面
非常适合 Mintlify 风格。

可以做成：
- 文档列表页
- 文档详情页
- 详情页突出：
  - 文档元信息
  - 原始来源
  - 摘要
  - 标签
  - 相关文档

## 4. Digests 页面
这是最适合 Mintlify 的核心页面之一。

因为摘要本身就是文档内容。

建议：
- 目录清晰
- 引用块清晰
- 关键结论用 callout 强调
- 页码和来源定位明显

## 5. Watchlists 页面
这一页需要比 Mintlify 原生文档感更强一点的后台结构。

建议：
- 列表 + 过滤 + 标签
- 保留干净风格
- 但提高扫描效率

## 6. Entries 页面
适合“研究记录流”风格，而不是资讯门户风格。

建议：
- 标题清楚
- 类型标签清楚
- 来源清楚
- 时间、平台、主题一眼可见

---

## 五、BeerDirect 的视觉气质建议

如果按 Mintlify 路线继续，我建议 BeerDirect 的视觉气质定义为：

### 关键词
- calm
- structured
- research-oriented
- technical but readable
- quiet intelligence

中文可以理解成：
- 冷静
- 清晰
- 研究型
- 技术感但不压迫
- 像一个文档情报系统，而不是喧闹产品后台

---

## 六、品牌调性建议

BeerDirect 不需要很“啤酒包装化”的设计，也不需要做得像精酿电商。

更合适的是：
- 以中性、理性为主
- 用一条带温度的品牌色轻轻提醒“beer”属性

### 推荐方向
- 主体：中性灰、深墨色、暖白
- 品牌强调色：啤酒琥珀 / 酒花绿 二选一
- 状态色：沿用常规信息架构色

### 不建议
- 大面积金黄
- 大面积木纹、酒吧复古感
- 过于营销海报式精酿视觉

原因：
BeerDirect 是情报系统，不是酒吧菜单。

---

## 七、组件层面的具体建议

## 推荐重点组件
- Sidebar
- Page Header
- Section Header
- Tag
- Status Badge
- Filter Bar
- Data Card
- Metadata Panel
- Markdown Content Block
- Callout
- Related Links Block

## 表格建议
BeerDirect 不应过度依赖传统重表格。

更建议：
- 列表 + 卡片混合
- 表格只用于密度高的管理页
- 文档和摘要页尽量文档化

## 标签建议
标签会是系统重要元素。

建议：
- 小而清晰
- 低饱和底色
- 支持主题、来源类型、平台、优先级等不同语义

---

## 八、最终方向建议

如果 BeerDirect 采用 Mintlify 路线，我建议定义成：

**Mintlify as base, with slightly denser admin structure and a research-system identity.**

也就是：
- 以 Mintlify 为基础
- 增加一点后台管理骨架
- 保留文档和知识系统的阅读体验
- 不做成纯 docs site
- 不做成纯 dashboard

这是 BeerDirect 当前最适合的折中点。

---

## 九、下一步建议

既然 Mintlify 方向已经定下来，后续最应该做的不是继续看风格库，而是进入落地文件：

### 1. 生成 BeerDirect 的 `DESIGN.md`
把 UI 原则真正写成 AI 可用的设计说明。

### 2. 定义核心页面线框
至少先定义：
- Dashboard
- Sources
- Documents
- Digests
- Watchlists

### 3. 再进入 Vue 3 实现阶段
让前端生成和开发都围绕 `DESIGN.md` 进行。
