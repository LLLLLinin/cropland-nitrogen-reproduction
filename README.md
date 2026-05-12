# Cropland Nitrogen Reproduction

本仓库用于复现 Nature Food 论文 **Optimized agricultural management reduces global cropland nitrogen losses to air and water** 中的部分主要图表。项目内容包括复现所需数据、R 语言绘图脚本、复现结果图以及项目说明文件。

论文链接：  
https://www.nature.com/articles/s43016-024-01076-w

---

## 1. Project Overview

农业生产过程中氮肥的大量使用会导致氮素向空气和水体流失，例如 N₂O 排放、NH₃ 挥发、氮径流和氮淋失等。原论文从全球尺度分析了优化农业管理措施对减少耕地氮损失的作用。

本项目基于原论文公开数据和补充材料，对论文中的部分图表进行复现，主要包括：

- Figure 1：不同农业管理措施对氮损失的影响及全球样点分布；
- Figure 2：不同管理措施和场地条件对多种氮损失路径的参数估计结果；
- Figure 3：基于公开补充数据进行的部分复现结果。

其中，Figure 1 和 Figure 2 已完成主要复现；Figure 3 由于完整原始数据获取有限，目前仅完成部分复现和结果展示。

---

## 2. Repository Structure

本仓库按照 `data/`、`script/`、`result/` 和 `README.md` 的结构进行整理，方便查看数据、运行代码和检查结果。

```text
cropland-nitrogen-reproduction/
│
├── data/
│   ├── figure1/
│   │   ├── You_paper3_S2.xlsx
│   │   └── metaresult_paper3.csv
│   │
│   ├── figure2/
│   │   └── 43016_2024_1076_MOESM10_ESM.xlsx
│   │
│   └── figure3/
│       └── 43016_2024_1076_MOESM11_ESM.xlsx
│
├── script/
│   ├── figure1/
│   │   └── Figure1_N.R
│   │
│   ├── figure2/
│   │   └── Figure2_N_losses.R
│   │
│   └── figure3/
│       └── README_Figure3.md
│
├── result/
│   ├── figure1/
│   │   └── Figure1_N.tiff
│   │
│   ├── figure2/
│   │   └── Figure2_paper3.tiff
│   │
│   └── figure3/
│       └── figure3.tiff
│
└── README.md
```

各文件夹说明如下：

| Folder | Description |
|---|---|
| `data/` | 存放复现所需的原始数据、补充数据和整理后的分析数据 |
| `script/` | 存放用于复现图表的 R 语言代码 |
| `result/` | 存放运行代码后生成的复现结果图 |
| `README.md` | 项目说明、运行方法、复现结果和小组分工 |

---

## 3. Data Description

### Figure 1

`data/figure1/` 中包含 Figure 1 复现所需的数据文件：

- `You_paper3_S2.xlsx`：用于绘制全球样点分布及管理措施分类的数据；
- `metaresult_paper3.csv`：用于绘制不同农业管理措施对氮损失影响的汇总数据。

### Figure 2

`data/figure2/` 中包含 Figure 2 复现所需的数据文件：

- `43016_2024_1076_MOESM10_ESM.xlsx`：论文补充材料数据，用于分析不同管理措施和场地条件对氮损失的影响。

### Figure 3

`data/figure3/` 中包含 Figure 3 部分复现所需的公开补充数据：

- `43016_2024_1076_MOESM11_ESM.xlsx`：论文补充材料数据，用于 Figure 3 的部分结果整理和展示。

---

## 4. Script Description

### Figure 1

代码路径：

```text
script/figure1/Figure1_N.R
```

该脚本用于复现 Figure 1，主要包括：

- 读取样点和管理措施数据；
- 绘制全球样点分布图；
- 绘制不同农业管理措施对 N₂O emission、NH₃ emission、N runoff 和 N leaching 的影响；
- 合并多个子图并输出 `.tiff` 格式结果图。

输出结果保存至：

```text
result/figure1/Figure1_N.tiff
```

### Figure 2

代码路径：

```text
script/figure2/Figure2_N_losses.R
```

该脚本用于复现 Figure 2，主要包括：

- 读取论文补充数据；
- 分别绘制 N₂O emission、NH₃ emission、N runoff 和 N leaching 的参数估计结果；
- 合并四个子图并输出 `.tiff` 格式结果图。

输出结果保存至：

```text
result/figure2/Figure2_paper3.tiff
```

### Figure 3

Figure 3 当前仅完成部分复现。由于原作者未提供完整原始数据，本项目主要基于公开补充材料进行部分结果整理和展示。

输出结果保存至：

```text
result/figure3/figure3.tiff
```

---

## 5. Required R Packages

运行本项目中的 R 脚本前，需要安装以下 R 包：

```r
install.packages(c(
  "ggplot2",
  "data.table",
  "ggpubr",
  "readxl",
  "maps",
  "gridExtra"
))
```

部分脚本还可能使用 R 自带的 `grid` 包。

---

## 6. How to Reproduce

### Step 1. Clone the repository

```bash
git clone https://github.com/D2RS-2026spring/cropland-nitrogen-reproduction.git
cd cropland-nitrogen-reproduction
```

### Step 2. Open R or RStudio

建议使用 RStudio 打开本项目文件夹，并将工作目录设置为仓库根目录：

```r
setwd("your/path/to/cropland-nitrogen-reproduction")
```

### Step 3. Run the scripts

运行 Figure 1 复现代码：

```r
source("script/figure1/Figure1_N.R")
```

运行 Figure 2 复现代码：

```r
source("script/figure2/Figure2_N_losses.R")
```

运行后，复现结果图将保存到对应的 `result/` 文件夹中。

> 注意：如果脚本中仍存在本地绝对路径，例如 `D:/...`，需要将其修改为相对路径，例如：
>
> ```r
> readxl::read_xlsx("data/figure2/43016_2024_1076_MOESM10_ESM.xlsx", sheet = 1)
> ```
>
> 输出路径也建议统一修改为：
>
> ```r
> ggsave("result/figure2/Figure2_paper3.tiff", ...)
> ```

---

## 7. Reproduction Results

| Figure | Reproduction status | Output file |
|---|---|---|
| Figure 1 | Completed | `result/figure1/Figure1_N.tiff` |
| Figure 2 | Completed | `result/figure2/Figure2_paper3.tiff` |
| Figure 3 | Partially completed | `result/figure3/figure3.tiff` |

Figure 1 和 Figure 2 的图表结构、主要变量和整体趋势与原论文保持一致。Figure 3 由于完整原始数据不足，目前仅基于公开补充材料进行部分复现。

---

## 8. Group Information

小组名称：全球耕地氮损失复现小组

小组成员：

| GitHub ID | Name | Student ID | Contribution |
|---|---|---|---|
| @1712203708-a11y | 高欣昱 | 2025303110014 | 整理 Figure 1 相关数据，参与 Figure 1 复现和结果检查 |
| @l110095 | 李安琪 | 2025303110095 | 整理 README 文档，补充仓库结构和可复现性说明 |
| @LLLLLinin | 林蓉 | 2025303110070 | 整理 Figure 2 数据，参与 Figure 2 复现结果检查 |
| @Q110112 | 马文倩 | 2025303110112 | 整理 R 脚本文件，检查代码路径和运行说明 |
| @liuhui0411 | 刘慧 | 2025303110089 | 整理 Figure 3 补充数据和部分复现结果，参与项目最终检查 |

---

## 9. Notes

1. 本仓库中的数据主要来自原论文正文、公开补充材料以及原作者公开资料。
2. Figure 1 和 Figure 2 已完成主要复现。
3. Figure 3 由于缺少完整原始数据，目前仅进行部分复现。
4. 为保证仓库结构清晰，数据、代码和结果图分别存放在 `data/`、`script/` 和 `result/` 文件夹中。
5. 每位组员均使用自己的 GitHub 账号提交本人负责的部分，以保证项目贡献记录完整。

---

## 10. Reference

Optimized agricultural management reduces global cropland nitrogen losses to air and water.  
Nature Food, 2024.  
https://www.nature.com/articles/s43016-024-01076-w
