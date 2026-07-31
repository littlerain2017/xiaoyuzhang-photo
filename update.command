#!/bin/bash
# 一键更新摄影网站:优化照片 → 生成 manifest → 推送上线
# 用法:往 photos/ 里放好照片后,双击本文件(或终端运行 ./update.command)
set -e
cd "$(dirname "$0")"

mkdir -p originals
shopt -s nullglob

echo "— 规范文件名(.jpeg/.JPG → .jpg)—"
for f in photos/*.jpeg photos/*.JPG photos/*.JPEG; do
  [ -e "$f" ] || continue
  new="photos/$(basename "${f%.*}").jpg"
  [ -e "$new" ] || mv "$f" "$new" && echo "  重命名 $(basename "$f") → $(basename "$new")"
done

echo "— 优化过大的照片(长边>2400px 或 >2MB)—"
for f in photos/*.jpg; do
  [ -e "$f" ] || continue
  base=$(basename "$f")
  w=$(sips -g pixelWidth "$f" | awk '/pixelWidth/{print $2}')
  h=$(sips -g pixelHeight "$f" | awk '/pixelHeight/{print $2}')
  size=$(stat -f%z "$f")
  long=$(( w > h ? w : h ))
  if [ "$long" -gt 2400 ] || [ "$size" -gt 2000000 ]; then
    [ -e "originals/$base" ] || cp "$f" "originals/$base"
    sips -Z 2400 -s format jpeg -s formatOptions 82 "$f" --out "$f" >/dev/null
    echo "  压缩 $base ($(( size / 1024 / 1024 ))MB → $(( $(stat -f%z "$f") / 1024 ))KB)"
  fi
done

echo "— 生成 photos/manifest.json —"
python3 - <<'PY'
import json, os, re
files = os.listdir('photos')
nums_by_key = {}
for f in files:
    m = re.match(r'^([a-z0-9]+)-(\d+)\.jpg$', f)
    if m:
        nums_by_key.setdefault(m.group(1), set()).add(int(m.group(2)))
manifest = {}
for k, nums in sorted(nums_by_key.items()):
    n = 0
    while n + 1 in nums:
        n += 1
    manifest[k] = n
    missing = sorted(set(range(1, max(nums) + 1)) - nums)
    if missing:
        print(f'  ⚠️  {k} 缺号 {missing} — 网站只会显示前 {n} 张,请补齐编号')
manifest['cover'] = os.path.exists('photos/cover.jpg')
with open('photos/manifest.json', 'w') as fp:
    json.dump(manifest, fp, ensure_ascii=False, indent=1)
print('  ' + json.dumps(manifest, ensure_ascii=False))
PY

echo "— 推送上线 —"
git add -A
if git diff --cached --quiet; then
  echo "  没有变化,无需推送"
else
  git -c user.name="littlerain2017" -c user.email="littlerain381@gmail.com" \
      commit -m "content: update photos $(date +%Y-%m-%d)" -q
  git push -q
  echo "  ✅ 已推送,1-2 分钟后生效:https://littlerain2017.github.io/xiaoyuzhang-photo/"
fi
echo "完成。"
