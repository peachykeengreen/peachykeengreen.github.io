#!/usr/bin/env bash
# gen.sh - Rebuild Peachy Keen Green Hugo Website
#
# Usage:
#   ./gen.sh           Clean docs/ (preserving docs/images/ and docs/css/) and build static site
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
    *)
      ;;
  esac
done

echo "=================================================="
echo "🌱 Peachy Keen Green - Site Generator"
echo "=================================================="

if [ "$CLEAN" = true ]; then
  if [ -d "docs" ]; then
    echo "🧹 Cleaning docs/ (preserving docs/images/ and docs/css/)..."
    find docs -mindepth 1 ! -path 'docs/images*' ! -path 'docs/css*' -delete 2>/dev/null || true
  fi
fi

# Rebuild Hugo static site into docs/
hugo build

echo "=================================================="
echo "✅ Build Complete! Generated site is ready in docs/"
echo "=================================================="
