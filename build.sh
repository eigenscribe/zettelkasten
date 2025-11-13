#!/bin/bash
# ==========================================
# PreTeXt Build + Custom Styling Script
# For eigenscribe/zettelkasten
# ==========================================
set -e  # stop on errors

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}Building PreTeXt project...${NC}"

# ----------------------------------------------------------
# 1. Build PreTeXt (if installed)
# ----------------------------------------------------------
if ! command -v pretext &> /dev/null; then
    echo -e "${YELLOW}⚠️  PreTeXt CLI not found — skipping build.${NC}"
    echo "You can install it with:"
    echo "   python3 -m pip install pretext"
else
    # Use the updated CLI syntax (works with PreTeXt ≥ 1.0)
    pretext build web || { echo -e "${RED}❌ Build failed.${NC}"; exit 1; }
fi

# ----------------------------------------------------------
# 2. Copy custom CSS and assets
# ----------------------------------------------------------
echo -e "${GREEN}Copying custom CSS and assets...${NC}"
mkdir -p output/web/external

cp assets/custom-theme.css output/web/external/ 2>/dev/null || true
cp assets/wisp.jpg output/web/external/ 2>/dev/null || true
cp assets/logo.png output/web/external/ 2>/dev/null || true
cp assets/favicon.png output/web/ 2>/dev/null || true
cp assets/force-dark.js output/web/external/ 2>/dev/null || true

# ----------------------------------------------------------
# 3. Inject CSS, JS, and custom footer
# ----------------------------------------------------------
echo -e "${GREEN}Injecting custom CSS, favicon, and footer...${NC}"

for file in output/web/*.html; do
  [ -f "$file" ] || continue  # Skip if not a file

  # Inject custom CSS
  if ! grep -q "custom-theme.css" "$file"; then
    sed -i 's|</head>|<link rel="stylesheet" type="text/css" href="external/custom-theme.css">\n</head>|' "$file"
  fi

  # Inject dark mode JS
  if ! grep -q "force-dark.js" "$file"; then
    sed -i 's|</head>|<script src="external/force-dark.js"></script>\n</head>|' "$file"
  fi

  # Inject favicon
  if ! grep -q "favicon.png" "$file"; then
    sed -i 's|</head>|<link rel="icon" type="image/png" href="favicon.png">\n</head>|' "$file"
  fi

  # Replace footer text (simplified footer)
  if grep -q "ptx-content-footer" "$file"; then
    sed -i 's|<footer class="ptx-content-footer">.*</footer>|<footer class="ptx-content-footer"><span class="copyright">eigenscribe © 2025</span></footer>|' "$file"
  fi

  # Replace PreTeXt page footer with custom HTML block
  if grep -q 'id="ptx-page-footer"' "$file"; then
    perl -i -0pe 's|<div id="ptx-page-footer" class="ptx-page-footer">.*?</div>\s*</body>|<div id="ptx-page-footer" class="ptx-page-footer" style="background: rgba(0, 0, 0, 0.7); border-top: 1px solid rgba(255, 255, 255, 0.1); backdrop-filter: blur(10px); padding: 2rem 1rem;"><div style="display: flex; align-items: center; justify-content: center; gap: 0.75rem;"><img src="external/logo.png" alt="eigenscribe logo" style="width: 35px; height: 35px; filter: drop-shadow(0 0 8px rgba(0, 232, 255, 0.5));"><p style=\"font-family: Aclonica, sans-serif; background: linear-gradient(130deg, #00ffee, #0a95eb); -webkit-background-clip: text; background-clip: text; -webkit-text-fill-color: transparent; font-size: 1rem; margin: 0;\">eigenscribe © 2025</p></div></div>\n</body>|gs' "$file"
  fi
done

# ----------------------------------------------------------
# 4. Publish to docs/ and git
# ----------------------------------------------------------
echo -e "${GREEN}Copying site to docs/ and pushing to main...${NC}"

rm -rf docs
mkdir -p docs
cp -r output/web/* docs/
cp -r output/web/mathjax docs/mathjax 2>/dev/null || true

git add -A docs
git commit -m "Publish site: update docs/ from output/web" || echo "No changes to commit"
git push origin main

# ----------------------------------------------------------
# 5. Fix MathJax paths for GitHub Pages
# ----------------------------------------------------------
echo -e "${GREEN}Fixing MathJax paths for GitHub Pages...${NC}"
find docs -name "*.html" -exec sed -i 's|src="/mathjax/|src="mathjax/|g' {} +

# ----------------------------------------------------------
# 6. Wrap up
# ----------------------------------------------------------
echo -e "${GREEN}✅ Build complete! Custom styling and assets applied.${NC}"