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

## 待办 / 后续

- [ ] 用真实作品图替换 `assets/images/` 的占位（现在是 CSS 渐变占位）
- [ ] 确认「Series」之外要不要加的第 5 个板块（问卷里勾的 Other）
- [ ] 字体内联：把 Helvetica Neue / Neue Haas 的 woff2 用 `@font-face` data URI 内联，锁死跨设备一致（当前依赖访客系统字体）
- [ ] 单个作品详情页（点进去看整组照片）
- [ ] 图片懒加载 + 响应式尺寸（`srcset` / `loading="lazy"`）
- [ ] 可选：favicon、OG 分享卡、SEO meta

## 结构

```
xiaoyuzhang-photo/
├── index.html          # 主页（当前 CSS/JS 内联，落地后可拆分）
├── assets/
│   └── images/         # 作品图
└── README.md
```
