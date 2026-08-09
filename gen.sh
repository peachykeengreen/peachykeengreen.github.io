#!/usr/bin/env bash
# gen.sh - Rebuild Peachy Keen Green Hugo Website
#
# Usage:
#   ./gen.sh           Clean docs/ (preserving static assets) and build static site
#   ./gen.sh --no-clean Build static site without cleaning docs/

set -e

# Determine Project Root Directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

CLEAN=true

for arg in "$@"; do
  case $arg in
    --no-clean)
      CLEAN=false
      shift
      ;;
    --new)
      NEW_TITLE="$2"
      shift 2
      ;;
    *)
      ;;
  esac
done

if [ -n "$NEW_TITLE" ]; then
  SLUG=$(echo "$NEW_TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-+|-+$//g')
  echo "✨ Creating new article bundle: src/$SLUG/index.md"
  hugo new "$SLUG/index.md"
  # Override title in index.md with exact provided title
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' -E "s/^title: .*/title: \"$NEW_TITLE\"/" "src/$SLUG/index.md"
  else
    sed -i -E "s/^title: .*/title: \"$NEW_TITLE\"/" "src/$SLUG/index.md"
  fi
  echo "✅ Created src/$SLUG/index.md with title \"$NEW_TITLE\""
  exit 0
fi

echo "=================================================="
echo "🌱 Peachy Keen Green - Site Generator"
echo "=================================================="

# Auto-bump CSS version in config/_default/hugo.toml if docs/css/styles.css changed
CSS_FILE="docs/css/styles.css"
HASH_FILE="docs/css/.styles_hash"
CONFIG_FILE="config/_default/hugo.toml"

if [ -f "$CSS_FILE" ]; then
  if command -v md5 >/dev/null 2>&1; then
    CURRENT_HASH=$(md5 -q "$CSS_FILE")
  elif command -v md5sum >/dev/null 2>&1; then
    CURRENT_HASH=$(md5sum "$CSS_FILE" | awk '{print $1}')
  else
    CURRENT_HASH=$(cksum "$CSS_FILE" | awk '{print $1}')
  fi

  PREV_HASH=""
  if [ -f "$HASH_FILE" ]; then
    PREV_HASH=$(cat "$HASH_FILE")
  fi

  if [ -z "$PREV_HASH" ]; then
    # Initialize hash file on first run without bumping version
    echo "$CURRENT_HASH" > "$HASH_FILE"
  elif [ "$CURRENT_HASH" != "$PREV_HASH" ]; then
    CURRENT_VER=$(grep -E '^\s*version\s*=' "$CONFIG_FILE" | sed -E 's/.*"([^"]+)".*/\1/')
    if [ -n "$CURRENT_VER" ]; then
      MAJOR=$(echo "$CURRENT_VER" | cut -d. -f1)
      MINOR=$(echo "$CURRENT_VER" | cut -d. -f2)
      PATCH=$(echo "$CURRENT_VER" | cut -d. -f3)

      if [ -n "$PATCH" ]; then
        NEW_PATCH=$((PATCH + 1))
        NEW_VER="${MAJOR}.${MINOR}.${NEW_PATCH}"
      else
        NEW_VER="${CURRENT_VER}.1"
      fi

      if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' -E "s/version = \"[^\"]+\"/version = \"$NEW_VER\"/" "$CONFIG_FILE"
      else
        sed -i -E "s/version = \"[^\"]+\"/version = \"$NEW_VER\"/" "$CONFIG_FILE"
      fi

      echo "🎨 styles.css modified — bumped version to $NEW_VER in config/_default/hugo.toml"
      echo "$CURRENT_HASH" > "$HASH_FILE"
    fi
  fi
fi

if [ "$CLEAN" = true ]; then
  if [ -d "docs" ]; then
    echo "🧹 Cleaning docs/ (preserving docs/css/ and docs/favicon.svg)..."
    find docs -mindepth 1 ! -path 'docs/css*' ! -path 'docs/favicon.svg*' -delete 2>/dev/null || true
  fi
fi

# Rebuild Hugo static site into docs/
hugo build

echo "=================================================="
echo "✅ Build Complete! Generated site is ready in docs/"
echo "=================================================="
