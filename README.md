# xiaoyuzhang · Photography

Xiaoyu Zhang 个人摄影作品集网站。纯静态（HTML/CSS/JS），零构建，零依赖。

## 设计方向

- 参照 [julienbelmonte.com](https://www.julienbelmonte.com/) 的纯白极简 editorial 风格
- 纯白底 `#ffffff`、黑字 `#111`、无 accent 色
- 字体 Helvetica Neue（= Neue Haas Grotesk / Helvetica 一类中性 grotesque）
- 无 hero，直接进 3 列横幅网格；hover 淡出标题
- 顶部极简导航（Work / Series / About / Contact + Instagram）

## 本地预览

直接双击 `index.html`，或起一个本地服务器：

```bash
cd ~/xiaoyuzhang-photo
python3 -m http.server 8000
# 浏览器打开 http://localhost:8000
```

## 部署（上线）

纯静态站，任选其一，拖一下就上线：

- **Vercel** — `npx vercel` 或把目录拖到 vercel.com
- **GitHub Pages** — push 到仓库，Settings → Pages 选 root
- **Netlify** — 把目录拖进 netlify.com/drop

## 联系方式（已填入页面）

- Email: littlerain381@gmail.com
- Instagram: [@xyzhang2017](https://instagram.com/xyzhang2017)
- Based in Beijing 北京

## 日常更新流程（记住这一个就够）

1. 照片放进 `photos/`，命名规则：
   - 封面轮播：`cover-1.jpg` ~ `cover-6.jpg`（≥2 张时自动每 6 秒淡切轮播，几张都行）
   - 项目照片：`{项目名}-{序号}.jpg`，如 `talk-1.jpg`、`talk-2.jpg`、`rain-1.jpg`
   - **宽幅作品：`widescreen-1.jpg`、`widescreen-2.jpg`…** 见下方 Widescreen 板块
   - 序号必须从 1 连续编号，断号的部分不会显示
2. **双击 `update.command`**（或终端运行 `./update.command`），它会自动：
   - 把 `.jpeg` / `.JPG` 统一改名为 `.jpg`
   - 压缩过大的照片（长边 >2400px 或 >2MB；原件自动备份到 `originals/`，不会上传）
   - 重新生成 `photos/manifest.json`（网站按它显示每个项目的实际张数）
   - 提交并推送，1–2 分钟后线上生效

线上地址：**https://littlerain2017.github.io/xiaoyuzhang-photo/**
仓库：https://github.com/littlerain2017/xiaoyuzhang-photo

## Widescreen 板块

三列网格之下有一个独立的宽幅区，专放 2.56:1 一类的超宽画幅。它不进网格，避免被 16:10 的取景框裁掉两侧。

- 命名 `widescreen-1.jpg` 起，连续编号；放进 `photos/` 后跑一次 `update.command` 即可
- 版面为**通栏连续堆叠**：满幅贴到视口两边，缝隙 2–6px，多张连读像一条胶片
- 一张都没有时整块自动隐藏，不会留下空标题
- 点任意一张进幻灯片，从该张开始翻
- 压缩上限比普通照片高（长边 3200px / 3MB，普通照片是 2400px / 2MB），因为通栏满幅需要更高分辨率

> 注意：本地双击 `index.html` 预览时，浏览器会拦截 `manifest.json` 的读取，Widescreen 板块和网格缩略图都不会出现。要在本地看效果，用 README 上面那条 `python3 -m http.server` 起服务器访问。线上不受影响。

## 项目名（网格从左到右）

talk / rain / clutter / black&white / p5 / p6 / p7 / p8 / p9（后五个待定名）

> black&white 的照片命名用 `blackwhite-1.jpg`（文件名不能带 `&`）

## 待办 / 后续

- [ ] 后六个项目定名（改 index.html 里的 `data-project` 和 title，photos 命名跟着改）
- [ ] 字体内联（Neue Haas 为付费商用字，暂用系统 Helvetica Neue 栈）
- [ ] 可选：绑定自己的域名

## 结构

```
xiaoyuzhang-photo/
├── index.html          # 整站（HTML/CSS/JS 单文件）
├── update.command      # 一键更新脚本（双击运行）
├── photos/             # 网页用照片 + manifest.json（提交上线）
├── originals/          # 压缩前的原件备份（gitignore，不上传）
└── README.md
```
