#!/bin/bash

# Build the PreTeXt project
echo "Building PreTeXt project..."
pretext build web

# Copy custom CSS and assets to output directory
echo "Copying custom CSS and assets..."
mkdir -p output/web/external
cp assets/custom-theme.css output/web/external/
cp assets/wisp.jpg output/web/external/
cp assets/logo.png output/web/external/
cp assets/favicon.png output/web/

# Inject CSS link and favicon into all HTML files
echo "Injecting custom CSS and favicon into HTML files..."
for file in output/web/*.html; do
  # Check if the file already has the custom CSS link
  if ! grep -q "custom-theme.css" "$file"; then
    # Insert the link tag after the existing CSS links in the <head>
    sed -i 's|</head>|<link rel="stylesheet" type="text/css" href="external/custom-theme.css">\n</head>|' "$file"
  fi
  
  # Check if the file already has the favicon
  if ! grep -q "favicon.png" "$file"; then
    # Insert the favicon link in the <head>
    sed -i 's|</head>|<link rel="icon" type="image/png" href="favicon.png">\n</head>|' "$file"
  fi
  
  # Update footer with custom branding
  if grep -q "ptx-content-footer" "$file"; then
    # Replace footer content with eigenscribe copyright
    sed -i 's|<footer class="ptx-content-footer">.*</footer>|<footer class="ptx-content-footer"><span class="copyright">eigenscribe © 2025</span></footer>|' "$file"
  fi
  
  # Remove all content from page footer and replace with custom branding
  if grep -q 'id="ptx-page-footer"' "$file"; then
    # Use perl for multiline replacement - match everything up to </body>
    perl -i -0pe 's|<div id="ptx-page-footer" class="ptx-page-footer">.*?</div>\s*</body>|<div id="ptx-page-footer" class="ptx-page-footer" style="background: rgba(0, 0, 0, 0.7); border-top: 1px solid rgba(255, 255, 255, 0.1); backdrop-filter: blur(10px); padding: 2rem 1rem;"><div style="display: flex; align-items: center; justify-content: center; gap: 0.75rem;"><img src="external/logo.png" alt="eigenscribe logo" style="width: 35px; height: 35px; filter: drop-shadow(0 0 8px rgba(0, 232, 255, 0.5));"><p style="font-family: Aclonica, sans-serif; background: linear-gradient(130deg, #00ffee, #0a95eb); -webkit-background-clip: text; background-clip: text; -webkit-text-fill-color: transparent; font-size: 1rem; margin: 0;">eigenscribe © 2025</p></div></div>\n</body>|gs' "$file"
  fi
done

echo "Build complete! Custom styling and assets applied."
