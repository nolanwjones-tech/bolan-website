#!/bin/sh
# Builds the deployable site/ folder from body.html (the preview source).
set -e
cd "$(dirname "$0")"
STYLE_AND_HEAD=$(sed -n '1,/<\/style>/p' body.html)
CONTENT=$(sed -n '/<\/style>/,$p' body.html | tail -n +2)
head_meta() { # $1 = page description
  cat <<H
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="$1">
<meta property="og:title" content="Bolan LLC">
<meta property="og:description" content="$1">
<meta property="og:type" content="website">
<link rel="icon" href="favicon.svg" type="image/svg+xml">
<link rel="canonical" href="https://bolansolutions.com/">
<meta property="og:url" content="https://bolansolutions.com/">
H
}
DESC="Bolan LLC is a Wyoming company developing home goods and software for businesses."
{ head_meta "$DESC"; echo "$STYLE_AND_HEAD"; echo '</head>'; echo '<body>'; echo "$CONTENT"; echo '</body>'; echo '</html>'; } > site/index.html

# Sub-pages reuse the header, styles and footer, with their own main content.
page() { # $1 file, $2 title, $3 main-content file
  HEADER=$(echo "$CONTENT" | sed -n '/<div class="wrap">/,/<\/header>/p' | sed 's|href="#|href="index.html#|g')
  FOOTER=$(echo "$CONTENT" | sed -n '/<footer>/,$p')
  { head_meta "$DESC"; echo "$STYLE_AND_HEAD" | sed "s|<title>Bolan LLC</title>|<title>$2 · Bolan LLC</title>|"
    echo '</head>'; echo '<body>'; echo "$HEADER"; cat "$3"; echo "$FOOTER"; echo '</body>'; echo '</html>'; } > "site/$1"
}
page privacy.html "Privacy" pages/privacy.html
page 404.html "Page not found" pages/404.html

