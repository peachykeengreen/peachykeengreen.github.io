#!/usr/bin/env bash
# gen.sh - Rebuild Peachy Keen Green Hugo Website
#
# Usage:
#   ./gen.sh           Clean dest/ (preserving dest/images/ and dest/css/) and build static site
#   ./gen.sh --no-clean Build static site without cleaning dest/

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
  if [ -d "dest" ]; then
    echo "🧹 Cleaning dest/ (preserving dest/images/ and dest/css/)..."
    find dest -mindepth 1 ! -path 'dest/images*' ! -path 'dest/css*' -delete 2>/dev/null || true
  fi
fi

# Rebuild Hugo static site into dest/
hugo build

echo "=================================================="
echo "✅ Build Complete! Generated site is ready in dest/"
echo "=================================================="
