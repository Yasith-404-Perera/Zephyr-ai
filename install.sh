#!/usr/bin/env bash
set -euo pipefail

ZEPHYR_VERSION="${ZEPHYR_VERSION:-latest}"
ZEPHYR_NODE_MIN="18"

# ── Colors ──────────────────────────────────────────────
BOLD='\033[1m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# ── Logo ────────────────────────────────────────────────
echo ""
echo -e "${BLUE}   ███████╗███████╗██████╗ ██╗  ██╗██╗   ██╗██████╗${NC}"
echo -e "${BLUE}   ╚══███╔╝██╔════╝██╔══██╗██║  ██║╚██╗ ██╔╝██╔══██╗${NC}"
echo -e "${CYAN}     ███╔╝ █████╗  ██████╔╝███████║ ╚████╔╝ ██████╔╝${NC}"
echo -e "${CYAN}    ███╔╝  ██╔══╝  ██╔═══╝ ██╔══██║  ╚██╔╝  ██╔══██╗${NC}"
echo -e "${GREEN}   ███████╗███████╗██║     ██║  ██║   ██║   ██║  ██║${NC}"
echo -e "${GREEN}   ╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝${NC}"
echo ""
echo -e "${BOLD}Zephyr — AI terminal agent${NC}"
echo ""

# ── Pre-flight checks ──────────────────────────────────
if ! command -v node &>/dev/null; then
  echo -e "${RED}Error: Node.js is not installed.${NC}"
  echo "Zephyr requires Node.js v${ZEPHYR_NODE_MIN}+."
  echo ""
  echo "Install Node.js via your package manager or https://nodejs.org"
  exit 1
fi

NODE_VERSION=$(node -v | sed 's/v//' | cut -d. -f1)
if [ "$NODE_VERSION" -lt "$ZEPHYR_NODE_MIN" ]; then
  echo -e "${RED}Error: Node.js v$(node -v) is too old.${NC}"
  echo "Zephyr requires Node.js v${ZEPHYR_NODE_MIN}+."
  exit 1
fi

if ! command -v npm &>/dev/null; then
  echo -e "${RED}Error: npm is not installed.${NC}"
  exit 1
fi

# ── Install ─────────────────────────────────────────────
echo -e "${CYAN}Installing Zephyr...${NC}"

if [ "$ZEPHYR_VERSION" = "latest" ]; then
  npm install -g zephyr-ai
else
  npm install -g "zephyr-ai@${ZEPHYR_VERSION}"
fi

echo ""
echo -e "${GREEN}✔ Zephyr installed successfully!${NC}"
echo ""
echo -e "Run ${BOLD}zephyr${NC} to start."
echo -e "Run ${BOLD}zephyr login${NC} to configure your API provider."
echo -e "Run ${BOLD}zephyr doctor${NC} to verify your setup."
echo ""
