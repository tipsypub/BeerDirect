# BeerDirect DESIGN.md

## 1. Visual Theme & Atmosphere

BeerDirect is a research-oriented beer intelligence workspace.

The interface should feel:
- calm
- structured
- readable
- technical but not cold
- document-first
- information-dense without feeling crowded

This is **not** a flashy beer brand website, not an e-commerce storefront, and not a noisy analytics dashboard.

It should feel like a hybrid of:
- a modern documentation system
- an internal research tool
- a structured knowledge base

The overall direction is inspired by **Mintlify**, but adapted for a denser internal admin and knowledge workflow.

### Core mood
- Quiet intelligence
- Research-first clarity
- Minimal but not sterile
- Serious, but approachable

### Avoid
- overly playful startup gradients
- loud beer packaging aesthetics
- rustic bar / pub visuals
- heavy enterprise dashboard clutter
- oversized KPI-centric BI design

---

## 2. Color Palette & Roles

Use mostly neutral colors with one restrained brand accent.

### Base neutrals
- Background Primary: `#FAFAF7`
- Background Secondary: `#F4F4EF`
- Surface Primary: `#FFFFFF`
- Surface Secondary: `#F7F7F2`
- Border Subtle: `#E7E7DE`
- Border Strong: `#D8D8CC`
- Text Primary: `#1E1F1A`
- Text Secondary: `#5F6257`
- Text Tertiary: `#8A8D81`

### Brand accent
Primary accent should suggest beer research without becoming decorative.

Use one of these families consistently:
- Hop Green: `#4E7A5D`
- Amber Gold: `#B07A2A`

Preferred default for BeerDirect:
- Primary Accent: `#4E7A5D`
- Accent Soft: `#E7F0EA`
- Accent Strong: `#355540`

### Semantic colors
- Info: `#3E6F9E`
- Success: `#3E7A59`
- Warning: `#A9741D`
- Danger: `#B14D43`

### Usage rules
- Accent color should be used sparingly for active states, links, key badges, and selected navigation.
- Do not flood the interface with green or gold.
- Large surfaces should remain neutral.
- Semantic colors should only indicate meaning, not decoration.

---

## 3. Typography Rules

Typography should favor readability and structured research work.

### Font families
- UI Sans: Inter, ui-sans-serif, system-ui, sans-serif
- Monospace: JetBrains Mono, ui-monospace, SFMono-Regular, monospace

### Hierarchy
- Page Title: 30px / 700 / tight
- Section Title: 22px / 650
- Subsection Title: 18px / 650
- Card Title: 16px / 600
- Body Large: 16px / 400 / 1.7
- Body Standard: 14px / 400 / 1.7
- Body Small: 13px / 400 / 1.6
- Meta / Label: 12px / 500 / uppercase optional only when necessary

### Writing feel
- Prefer sentence case over all caps.
- Avoid heavy editorial serif usage.
- Use monospace only for code, paths, tags with technical meaning, IDs, and structured snippets.

### Readability rules
- Long-form text should never feel cramped.
- Paragraph width should remain comfortable.
- Documentation and digest pages should optimize for reading over compactness.

---

## 4. Layout Principles

BeerDirect is primarily a knowledge management and research interface.

### Core layout model
Use a documentation-informed application shell:
- Left sidebar for global navigation
- Main content area in center
- Optional right sidebar for table of contents, metadata, quick actions, or related links

### Density
- Moderate information density
- More compact than a marketing site
- More breathable than a spreadsheet-heavy admin

### Width
- Standard content pages: 960px to 1120px readable center column
- Document / digest reading pages: keep line length comfortable
- Dense management pages may expand wider when needed

### Spacing scale
Use a clean 4/8-based spacing rhythm.

Suggested spacing:
- 4px, 8px, 12px, 16px, 24px, 32px, 40px, 48px

### Surfaces
- Use soft layered surfaces instead of sharp, heavy boxes everywhere
- Cards should feel light and structured
- Avoid excessive drop shadows

---

## 5. Navigation Patterns

Navigation should reflect a document intelligence workspace.

### Primary navigation
Left sidebar sections:
- Dashboard
- Sources
- Watchlists
- Documents
- Digests
- Entries
- Tags
- Reports
- Settings

### Secondary navigation
Use sub-navigation when needed for:
- source categories
- document types
- platforms
- report types

### Active state
- clear but quiet
- tinted background or subtle left border
- use brand accent without looking loud

### Avoid
- oversized icon-heavy nav
- excessive badges everywhere
- too many floating menus

---

## 6. Component Stylings

## Buttons
### Primary button
- filled with brand accent
- medium border radius
- compact, not oversized
- should feel deliberate and quiet

### Secondary button
- neutral surface
- subtle border
- no aggressive shadows

### Ghost button
- for inline page actions
- minimal emphasis

Avoid flashy gradients or overly rounded CTA buttons.

---

## Cards
Cards should feel like structured information containers.

### Style
- light surface
- subtle border
- small to medium radius
- minimal shadow or no shadow

### Use cases
- summary cards
- metadata blocks
- related document lists
- recent activity items
- grouped source records

Cards should prioritize clarity over decoration.

---

## Tables
Tables are important but should not dominate the entire product style.

### Rules
- clean row dividers
- soft hover state
- compact but readable cell spacing
- tags and statuses should remain legible
- support filtering and sorting

### Use tables for
- source management
- watchlists
- entries index
- tags index

### Avoid
- overly dense enterprise grid aesthetics
- dark zebra striping
- heavy boxed spreadsheet look

---

## Tags & Badges
Tags are central to BeerDirect.

### Tag style
- small
- subtle tint background
- soft border
- low saturation
- clearly readable text

### Tag types
- topic tags
- platform tags
- source type tags
- priority tags
- processing status tags

Priority badges should be distinct but not alarming.

Example:
- P1: muted green tint
- P2: muted amber tint
- P3: neutral gray tint

---

## Callouts
Use callouts heavily in digest and document pages.

### Types
- Key takeaway
- Warning
- Source note
- Processing note
- Related idea

### Style
- left border or subtle tinted block
- compact but visually distinct
- never overly decorative

---

## Inputs & Filters
Inputs should feel clean and tool-like.

### Style
- neutral background
- soft border
- clear focus ring in brand accent
- compact radius

### Filter bars
Use horizontal filter blocks with:
- search input
- select controls
- tag filters
- date filters

Keep them simple and highly scannable.

---

## 7. Page Type Guidance

## Dashboard
Should not feel like a BI analytics dashboard.

Use:
- concise summary cards
- recent documents
- recent digests
- recent entries
- activity by category

Focus on “what changed recently” rather than heavy charts.

## Sources page
Should mix admin utility with readability.

Use:
- filter bar
- structured list/table
- rich detail drawer or detail page
- visible source metadata

## Watchlists page
Should emphasize grouped monitoring targets.

Use:
- platform grouping
- account type badges
- watch reason tags
- compact list or table

## Documents page
Should feel like a document management workspace.

Use:
- title
- source
- document type
- processing state
- related digest status

## Digest page
This is one of the most important page types.

Should feel closest to Mintlify-style reading pages.

Use:
- strong heading hierarchy
- metadata strip near top
- clean markdown rendering
- callouts for key findings
- visible page references
- related docs and tags in sidebar

## Entries page
Should feel like a research log.

Use:
- structured stream/list
- strong title line
- type + source + date + platform metadata
- compact preview content

---

## 8. Depth & Elevation

Depth should be minimal and controlled.

### Rules
- prefer borders over strong shadows
- shadows should be soft and rare
- use layering mainly through tone differences, not heavy elevation

### Surface hierarchy
- app background: neutral soft
- cards and panels: white or near-white
- active or selected panels: lightly tinted

Avoid glossy or dramatic depth.

---

## 9. Responsive Behavior

BeerDirect is desktop-first, but should remain usable on smaller screens.

### Desktop
- full sidebar visible
- optional right metadata column on document pages

### Tablet
- collapsible sidebar
- right sidebar may move below content

### Mobile
- focus on reading and key actions
- lists stack vertically
- filters become drawers or collapsible panels

### Touch behavior
- maintain adequate hit targets
- do not rely on hover for critical meaning

---

## 10. Do's and Don'ts

## Do
- prioritize readability
- build pages like a research workspace
- keep hierarchy calm and explicit
- use whitespace to separate meaning, not just for aesthetic emptiness
- make metadata, tags, and relationships easy to scan
- let documents and digests feel elegant and usable

## Don't
- make it look like a beer e-commerce site
- overuse dark mode-only cyber aesthetics
- overuse charts where lists and summaries are better
- make every page a dense admin grid
- use loud gradients, giant hero sections, or startup-marketing fluff
- turn the UI into a generic API docs clone

---

## 11. Agent Prompt Guide

When generating BeerDirect UI, use prompts like:

- Build a Vue 3 admin page for a research-oriented beer knowledge system using a Mintlify-inspired interface with calm neutral tones, subtle green accent, clean documentation-style layout, and strong readability.
- Create a document detail page that feels like a modern knowledge base, with left navigation, central reading area, right metadata sidebar, subtle borders, structured callouts, and compact tags.
- Design a source management page that combines admin utility with documentation elegance, using a clean filter bar, soft table styling, low-saturation tags, and precise hierarchy.

### Quick style shorthand
- Mintlify-inspired
- documentation-first
- internal research workspace
- neutral warm background
- subtle hop-green accent
- structured, readable, calm
