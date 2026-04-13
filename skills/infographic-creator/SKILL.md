---
name: infographic-creator
description: "Create beautiful infographics based on provided text content. Make sure to use this skill whenever a user requests to create an infographic, chart, diagram, data visualization, or wants to transform data and information into a visual structure, even if they don't explicitly use the word 'infographic'."
---

An infographic transforms data, information, and knowledge into perceptible visual language. It combines visual design and data visualization, using intuitive symbols to compress complex information and help the audience quickly understand and remember the key points.

`Infographic = Information Structure + Visual Expression`

This task uses [AntV Infographic](https://infographic.antv.vision/) to create visual infographics.

Before starting the task, you need to understand the AntV Infographic syntax specifications, including the template list, data structures, themes, etc.

## Anti-Patterns

- **Do not output JSON, explanatory text, or additional Markdown paragraphs.**
  - *Why*: The output must be directly executable by the AntV Infographic renderer. Any extra text breaks the parsing and execution flow. Only output a single `plain` code block containing the infographic syntax.
- **Do not use quotes or commas in the `palette` array.**
  - *Why*: The DSL expects raw color values separated by spaces. Quotes or commas will cause a rendering error. Use `palette #4f46e5 #06b6d4 #10b981`.
- **Do not mix different main data fields in `data`.**
  - *Why*: A template only supports its specific data structure. Mixing `lists`, `sequences`, `compares`, `values`, `root`, or `nodes` will cause the renderer to fail or ignore data. Stick to the single main data field matching the chosen template.

## Specifications

### AntV Infographic Syntax

The AntV Infographic syntax is a custom DSL used to describe the rendering configuration of infographics. It uses indentation to express structure, making it suitable for AI to directly generate and stream output. The core information includes:

1. template: Express the information structure using a template.
2. data: Infographic data, containing `title`, `desc`, and the main data field.
3. theme: Theme configuration, containing `palette`, fonts, stylization, etc.

For example:

```infographic
infographic list-row-horizontal-icon-arrow
data
  title Title
  desc Description
  lists
    - label Label
      value 12.5
      desc Explanation
      icon document text
theme
  palette #3b82f6 #8b5cf6 #f97316
```

### Strict Syntax Rules

- The first line must be `infographic <template-name>`.
- Only write the template name itself in the template list; when actually outputting, the first line must explicitly write the `infographic` prefix.
- Use `data` / `theme` blocks, with a uniform two-space indentation within the block.
- Key-value pairs are written as `key space value`; object arrays use `-` as an item prefix.
- `icon` uses icon keywords, such as `star fill`, `mingcute/server-line`.
- `value` should try to use pure numbers; numerical units are preferred to be expressed in `label` or `desc`.
- `palette` is recommended to use inline simple array syntax, such as `palette #4f46e5 #06b6d4 #10b981`.
- The color values in `palette` are raw values, without quotes and commas.
- `data` only contains one main data field matching the template, avoid mixing `lists`, `sequences`, `compares`, `values`, `root`, `nodes` at the same time.

Main data field selection rules:

- `list-*` → `lists`
- `sequence-*` → `sequences`, optional `order asc|desc`
- `sequence-interaction-*` → `sequences` + `relations`
  - `sequences` represents the lane list
  - Each lane must contain a `label`
  - The `children` of each lane represent the node list
  - Every item under `children` must be written as an object item and contain a `label`
  - Nodes can optionally have `id`, `icon`, `step`, `desc`, `value`
  - `step` is used to represent the time level; the same `step` is at the same height
- `compare-*` → `compares`
  - `compare-binary-*` / `compare-hierarchy-left-right-*`
    - The first level of `compares` must and can only have two root nodes, representing the two sides of the comparison respectively
    - Both root nodes should contain `children`
    - The real comparison items are written under their respective `children`
    - Every item under `children` must be written as an object item and contain a `label`
    - Even if each side has only 1 metric, it must be written as an object item inside `children`
  - `compare-swot`
    - `compares` can directly contain multiple root nodes
    - Each root node can optionally have `children`
  - `compare-quadrant-*`
    - `compares` directly contains 4 quadrant root nodes
- `hierarchy-structure` → `items`
- `hierarchy-*` → Single `root`, recursively nested through `children`
- `relation-*` → `nodes` + `relations`
  - Simple relationships can also directly use arrow syntax to express relationships
- `chart-*` → `values`
  - `chart-line-plain-text` / `chart-bar-plain-text` / `chart-column-simple` all use a single ordered sequence of `values`
  - Each data point uses `label` to represent the category, and `value` to represent the numerical value
  - The order of line charts is expressed by the arrangement order of items in `values`
- When the structure cannot be clearly judged, use `items` as a fallback

Theme rules:

- `theme` is used for custom themes, such as `palette`, `base`, `stylize`
- Use `theme.base.text.font-family` to specify the font, such as `851tegakizatsu`
- Use `theme.stylize` to select built-in styles and pass parameters
  - `rough`: hand-drawn effect
  - `pattern`: pattern fill
  - `linear-gradient` / `radial-gradient`: gradient style
- Only output the Infographic syntax itself, do not output JSON, explanatory text, or additional Markdown paragraphs

## Data Syntax Examples

Provide concise but complete positive examples by template category:

- `list-*` templates

```infographic
infographic list-grid-badge-card
data
  title Feature List
  lists
    - label Fast
      icon flash fast
    - label Secure
      icon shield check
```

- `sequence-*` templates

```infographic
infographic sequence-ascending-steps
data
  title Release Process
  sequences
    - label Requirement Confirmation
    - label Development Implementation
    - label Release to Production
  order asc
```

- `sequence-interaction-*` templates

```infographic
infographic sequence-interaction-compact-animated-badge-card
data
  title Login Verification Process
  sequences
    - label User
      children
        - label Initiate Login
          id user-login
          step 0
        - label Receive Result
          id user-result
          step 2
    - label Server
      children
        - label Verify Credentials
          id server-verify
          step 1
        - label Return Result
          id server-return
          step 2
  relations
    user-login - Submit Account Password -> server-verify
    server-verify - Generate Result -> server-return
    server-return - Return Result -> user-result
```

- `hierarchy-*` templates

```infographic
infographic hierarchy-tree-curved-line-rounded-rect-node
data
  title Organizational Structure
  root
    label Company
    children
      - label Product Department
      - label Technology Department
```

- `compare-swot` templates

```infographic
infographic compare-swot
data
  title Product SWOT
  compares
    - label Strengths
      children
        - label High Brand Awareness
    - label Weaknesses
      children
        - label High Cost Pressure
```

- `compare-binary-*` templates

```infographic
infographic compare-binary-horizontal-simple-fold
data
  title Dining Table Price Comparison
  compares
    - label Original Price
      children
        - label Original Price
          value 500
          icon tag
    - label Actual Payment
      children
        - label Actual Payment
          value 450
          icon check bold
```

- `compare-quadrant-*` templates

```infographic
infographic compare-quadrant-quarter-simple-card
data
  title Task Priority
  compares
    - label High Value Low Cost
    - label High Value High Cost
    - label Low Value Low Cost
    - label Low Value High Cost
```

- `chart-line-plain-text` templates

```infographic
infographic chart-line-plain-text
data
  title Model A Accuracy Change
  desc Most obvious improvement in week 4
  values
    - label Week1
      value 86.5
    - label Week2
      value 87.3
    - label Week3
      value 89.1
    - label Week4
      value 91.2
theme
  palette #4f46e5 #db2777 #14b8a6
```

- `relation-*` templates

```infographic
infographic relation-dagre-flow-tb-simple-circle-node
data
  title System Relationship
  nodes
    - label API
    - id db
      label DB
  relations
    API - Read/Write -> db
```

- Fallback `items` examples

```infographic
infographic list-row-horizontal-icon-arrow
data
  title Key Points Summary
  items
    - label Efficiency First
      desc Focus on key actions
    - label Results Oriented
      desc Output actionable conclusions
```

### Available Templates

- chart-bar-plain-text
- chart-column-simple
- chart-line-plain-text
- chart-pie-compact-card
- chart-pie-donut-pill-badge
- chart-pie-donut-plain-text
- chart-pie-plain-text
- chart-wordcloud
- compare-binary-horizontal-badge-card-arrow
- compare-binary-horizontal-simple-fold
- compare-binary-horizontal-underline-text-vs
- compare-hierarchy-left-right-circle-node-pill-badge
- compare-quadrant-quarter-circular
- compare-quadrant-quarter-simple-card
- compare-swot
- hierarchy-mindmap-branch-gradient-capsule-item
- hierarchy-mindmap-level-gradient-compact-card
- hierarchy-structure
- hierarchy-tree-curved-line-rounded-rect-node
- hierarchy-tree-tech-style-badge-card
- hierarchy-tree-tech-style-capsule-item
- list-column-done-list
- list-column-simple-vertical-arrow
- list-column-vertical-icon-arrow
- list-grid-badge-card
- list-grid-candy-card-lite
- list-grid-ribbon-card
- list-row-horizontal-icon-arrow
- list-sector-plain-text
- list-waterfall-badge-card
- list-waterfall-compact-card
- list-zigzag-down-compact-card
- list-zigzag-down-simple
- list-zigzag-up-compact-card
- list-zigzag-up-simple
- relation-dagre-flow-tb-animated-badge-card
- relation-dagre-flow-tb-animated-simple-circle-node
- relation-dagre-flow-tb-badge-card
- relation-dagre-flow-tb-simple-circle-node
- sequence-ascending-stairs-3d-underline-text
- sequence-ascending-steps
- sequence-circular-simple
- sequence-color-snake-steps-horizontal-icon-line
- sequence-cylinders-3d-simple
- sequence-filter-mesh-simple
- sequence-funnel-simple
- sequence-horizontal-zigzag-underline-text
- sequence-mountain-underline-text
- sequence-pyramid-simple
- sequence-roadmap-vertical-plain-text
- sequence-roadmap-vertical-simple
- sequence-snake-steps-compact-card
- sequence-snake-steps-simple
- sequence-snake-steps-underline-text
- sequence-stairs-front-compact-card
- sequence-stairs-front-pill-badge
- sequence-timeline-rounded-rect-node
- sequence-timeline-simple
- sequence-zigzag-pucks-3d-simple
- sequence-zigzag-steps-underline-text
- sequence-interaction-default-badge-card
- sequence-interaction-default-animated-badge-card
- sequence-interaction-default-compact-card
- sequence-interaction-default-capsule-item
- sequence-interaction-default-rounded-rect-node

## Template Selection Suggestions

- Strict sequence, step advancement, stage evolution → `sequence-*`
- Multi-role or multi-system interaction → `sequence-interaction-*`
- Parallel key points enumeration → `list-row-*` / `list-column-*` / `list-grid-*`
- Comparison of two sides, plan comparison, before/after comparison → `compare-binary-*`
  - First determine who the two sides are
  - Then expand `children` separately for the two sides
- SWOT analysis → `compare-swot`
- Quadrant analysis → `compare-quadrant-*`
- Hierarchical tree structure → `hierarchy-tree-*`
- Statistical trends, single sequence changes → `chart-line-plain-text`
- Statistical comparison, single group numerical comparison → `chart-bar-plain-text` / `chart-column-simple`
- Node relationship, process dependency → `relation-*`
- Word frequency topic display → `chart-wordcloud`
- Mind map → `hierarchy-mindmap-*`

### Complete Output Example

```infographic
infographic list-row-horizontal-icon-arrow
data
  title Product Growth Key Points
  desc Focus on three stages: acquisition, conversion, and repurchase
  lists
    - label Acquisition
      desc Multi-channel delivery and content reach
      icon rocket launch
    - label Conversion
      desc Optimize path and reduce churn
      icon chart line
    - label Repurchase
      desc Member privileges and tiered operations
      icon repeat
theme
  palette #3b82f6 #8b5cf6 #f97316
```

## Output Format

Only output a single `plain` code block, do not add any explanatory text:

```infographic
infographic list-row-horizontal-icon-arrow
data
  title Title
  desc Description
  lists
    - label Item
      value 12.5
      desc Explanation
      icon document text
theme
  palette #3b82f6 #8b5cf6 #f97316
```

## Self-Check List

Before outputting, check the following items:

- Is the first line `infographic <template-name>`?
- Have you only used one main data field matching the template?
- Is `palette` an array of raw color values without quotes and commas?
- Are the lane nodes of `sequence-interaction-*` all written as `children -> - label ...`?
- For `compare-binary-*` / `compare-hierarchy-left-right-*`, are there only two root nodes, and is the content of both sides placed under their respective `children`?
- Does every item under `children` explicitly contain a `label`?
- Does `chart-line-plain-text` use a single ordered sequence of `values`?
- Is there no JSON, explanatory text, or extra code blocks in the output?

## Generation Process

### Step 1: Understand User Needs

Before creating an infographic, first understand the user's needs and the information they want to express, in order to determine the template and data structure.

If the user provides a clear description of the content, it should be decomposed into a clear and concise structure.

Otherwise, you need to clarify with the user (e.g., "Please provide a clear and concise content description.", "Which template do you want to use?")

- Extract key information structures (title, desc, items, etc.).
- Clarify required data fields (title, desc, items, label, value, icon, etc.).
- Choose an appropriate template.
- Use AntV Infographic syntax to describe the infographic content `{syntax}`.

**Key Note**: You must respect the language input by the user. For example, if the user inputs Chinese, the text in the syntax must also be Chinese.

### Step 2: Render Infographic

After obtaining the final AntV Infographic syntax, you can generate a complete HTML file according to the following steps:

1. Create a complete HTML file containing the following structure:
   - DOCTYPE and HTML meta (charset: utf-8)
   - Title: `{title} - Infographic`
   - Include AntV Infographic script: `https://unpkg.com/@antv/infographic@latest/dist/infographic.min.js`
   - Create a container div with id `container`
   - Initialize Infographic (`width: '100%'`, `height: '100%'`)
   - Replace `{title}` with the actual title
   - Replace `{syntax}` with the actual AntV Infographic syntax
   - Add SVG export functionality: `const svgDataUrl = await infographic.toDataURL({ type: 'svg' });`

Reference HTML template:

```html
<div id="container"></div>
<script src="https://unpkg.com/@antv/infographic@latest/dist/infographic.min.js"></script>
<script>
 const infographic = new AntVInfographic.Infographic({
    container: '#container',
    width: '100%',
    height: '100%',
  });
  infographic.render(`{syntax}`);
  document.fonts?.ready.then(() => {
    infographic.render(`{syntax}`);
  }).catch((error) => console.error('Error waiting for fonts to load:', error));
</script>
```

2. Use the Write tool to generate an HTML file, named `<title>-infographic.html`

3. Present it to the user:
   - Provide the generated file path and prompt: "Open directly with a browser to view and save SVG"
   - Output the syntax and prompt: "Let me know if you need to adjust the template/color scheme/content"

**Note:** The HTML file must contain:

- **SVG export functionality via `toDataURL`**: This is essential because users often need to embed the resulting infographic in presentations or documents. Providing the export functionality allows them to easily download the final result as a scalable vector graphic.
- **Responsive container with both width and height set to 100%**: This ensures the visualization adapts correctly to whatever browser window size the user opens it in.
