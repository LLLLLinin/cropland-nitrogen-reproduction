# Nature Food Figure 1–3 Reproduction

本仓库包含 Nature Food 论文  
**Optimized agricultural management reduces global cropland nitrogen losses to air and water** (2024) 的复现代码、复现结果图和部分原始数据。

**论文链接：**  
https://www.nature.com/articles/s43016-024-01076-w

## 仓库结构说明

- `figure1/` :  
  - `Figure1_N.R` - Figure 1 复现代码  
  - `Figure1_N.tiff` - Figure 1 复现结果图  
  - `You_paper3_S2.xlsx` - Figure 1 使用的补充数据  
  - `metaresult_paper3.csv` - Figure 1 分析结果数据
- `figure2/` :  
  - `Figure2_N_losses.R` - Figure 2 复现代码  
  - `Figure2_paper3.tiff` - Figure 2 复现结果图  
  - `43016_2024_1076_MOESM10_ESM.xlsx` - Figure 2 使用的补充数据
- `figure3/` :  
  - `figure3.tiff` - Figure 3 部分复现结果图  
  - `43016_2024_1076_MOESM11_ESM.xlsx` - Figure 3 使用的补充数据
- `README.md` - 仓库说明文件

> 注：Figure 1 和 Figure 2 已完全复现；Figure 3 尚未完全复现，目前仅为部分复现结果。

## 小组信息

**小组名称：** 全球耕地氮损失复现小组  

**小组成员：**  
- @1712203708-a11y（高欣昱，2025303110014）  
- @l110095（李安琪，2025303110095）  
- @LLLLLinin（林蓉，2025303110070）  
- @Q110112（马文倩，2025303110112）  
- @liuhui0411（刘慧，2025303110089）

## 复现说明

1. **Figure 1 和 Figure 2** 已成功复现，图表结构和主要趋势与论文一致。  
2. **Figure 3** 目前仅完成部分复现，涉及全球尺度数据整合和空间映射，复现难度较高。  
3. 所有复现图表均使用 R 语言绘制，生成图为 `.tiff` 格式，方便保持原始分辨率。  
4. 数据来源参照论文公开信息及补充材料，包括公开数据库（气候、土壤、肥料输入、农田氮利用效率、土地利用数据、FAO/FAOSTAT 等）。

## 使用说明

- 打开对应 `figureX/` 文件夹可找到 R 代码和生成的 `.tiff` 图像  
- 打开对应 `.xlsx` 或 `.csv` 文件可查看用于复现的原始数据  
- 可通过 R 运行代码文件生成对应的图像
