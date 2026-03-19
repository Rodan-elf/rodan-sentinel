#!/bin/bash

# =============================================================================
#
#   ██████╗  ██████╗ ██████╗  █████╗ ███╗   ██╗    ███████╗███████╗███╗   ██╗████████╗██╗███╗   ██╗███████╗██╗
#   ██╔══██╗██╔═══██╗██╔══██╗██╔══██╗████╗  ██║    ██╔════╝██╔════╝████╗  ██║╚══██╔══╝██║████╗  ██║██╔════╝██║
#   ██████╔╝██║   ██║██║  ██║███████║██╔██╗ ██║    ███████╗█████╗  ██╔██╗ ██║   ██║   ██║██╔██╗ ██║█████╗  ██║
#   ██╔══██╗██║   ██║██║  ██║██╔══██║██║╚██╗██║    ╚════██║██╔══╝  ██║╚██╗██║   ██║   ██║██║╚██╗██║██╔══╝  ██║
#   ██║  ██║╚██████╔╝██████╔╝██║  ██║██║ ╚████║    ███████║███████╗██║ ╚████║   ██║   ██║██║ ╚████║███████╗███████╗
#   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚══════╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝
#
#   Autonomous macOS Endpoint Security Stack
#   by Rodan-elf — https://github.com/Rodan-elf/rodan-sentinel
#
#   Tools: LuLu · BlockBlock · OverSight · Malwarebytes
#   Target: macOS 10.15+ · Intel & Apple Silicon
# =============================================================================

set -e

# ── ANSI colors ───────────────────────────────────────────────────────────────
R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
B='\033[0;34m'
C='\033[0;36m'
W='\033[1;37m'
DIM='\033[2m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Helpers ───────────────────────────────────────────────────────────────────
log()     { echo -e "${DIM}[$(date +%H:%M:%S)]${RESET} $1"; }
ok()      { echo -e "  ${G}[+]${RESET} $1"; }
warn()    { echo -e "  ${Y}[!]${RESET} $1"; }
info()    { echo -e "  ${C}[*]${RESET} $1"; }
abort()   { echo -e "\n${R}[FATAL]${RESET} $1\n"; exit 1; }
section() {
  echo ""
  echo -e "${BOLD}${W}  :: $1${RESET}"
  echo -e "${DIM}  $(printf '─%.0s' {1..60})${RESET}"
  echo ""
}

# ── Boot screen ───────────────────────────────────────────────────────────────
clear
echo ""
echo -e "${R}${BOLD}"
echo '  ██████╗  ██████╗ ██████╗  █████╗ ███╗   ██╗'
echo '  ██╔══██╗██╔═══██╗██╔══██╗██╔══██╗████╗  ██║'
echo '  ██████╔╝██║   ██║██║  ██║███████║██╔██╗ ██║'
echo '  ██╔══██╗██║   ██║██║  ██║██╔══██║██║╚██╗██║'
echo '  ██║  ██║╚██████╔╝██████╔╝██║  ██║██║ ╚████║'
echo '  ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝'
echo -e "${RESET}${W}${BOLD}"
echo '  ███████╗███████╗███╗   ██╗████████╗██╗███╗   ██╗███████╗██╗'
echo '  ██╔════╝██╔════╝████╗  ██║╚══██╔══╝██║████╗  ██║██╔════╝██║'
echo '  ███████╗█████╗  ██╔██╗ ██║   ██║   ██║██╔██╗ ██║█████╗  ██║'
echo '  ╚════██║██╔══╝  ██║╚██╗██║   ██║   ██║██║╚██╗██║██╔══╝  ██║'
echo '  ███████║███████╗██║ ╚████║   ██║   ██║██║ ╚████║███████╗███████╗'
echo '  ╚══════╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝'
echo -e "${RESET}"
echo -e "  ${DIM}Autonomous Endpoint Security Stack for macOS${RESET}"
echo -e "  ${DIM}by${RESET} ${C}Rodan-elf${RESET}  ${DIM}·${RESET}  ${B}https://github.com/Rodan-elf${RESET}"
echo ""
echo -e "  ${Y}  100% Free  ·  100% Open Source  ·  Apple Silicon Ready${RESET}"
echo ""
echo -e "${DIM}  $(printf '═%.0s' {1..70})${RESET}"
sleep 1

# ── System recon ──────────────────────────────────────────────────────────────
section "SYSTEM RECON"

OS=$(sw_vers -productVersion)
ARCH=$(uname -m)
HOST=$(hostname)

info "Host         : ${W}${HOST}${RESET}"
info "OS           : ${W}macOS ${OS}${RESET}"
info "Architecture : ${W}${ARCH}${RESET}"

MAJOR=$(echo "$OS" | cut -d. -f1)
MINOR=$(echo "$OS" | cut -d. -f2)
if [[ "$MAJOR" -lt 10 ]] || [[ "$MAJOR" -eq 10 && "$MINOR" -lt 15 ]]; then
  abort "macOS 10.15 (Catalina) or newer required. Aborting deployment."
fi

ok "Target cleared >> proceeding"

# ── Homebrew ──────────────────────────────────────────────────────────────────
section "PACKAGE MANAGER"

if command -v brew &>/dev/null; then
  ok "Homebrew already deployed ($(brew --version | head -1))"
else
  warn "Homebrew not found >> deploying now..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ "$ARCH" == "arm64" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  ok "Homebrew deployed"
fi

# ── Install helper ────────────────────────────────────────────────────────────
deploy_tool() {
  local cask="$1"
  local label="$2"
  if brew list --cask "$cask" &>/dev/null; then
    warn "${label} already installed >> skipping"
  else
    log "Deploying ${label}..."
    brew install --cask "$cask"
    ok "${label} armed"
  fi
}

# ── [1/4] LuLu ────────────────────────────────────────────────────────────────
section "[1/4] LULU >> NETWORK FIREWALL"
echo -e "  ${DIM}Every outbound connection goes through LuLu."
echo -e "  Unknown binary phones home? Blocked. You decide what gets through."
echo -e "  Allow once, block forever. Your network, your rules.${RESET}"
echo ""
deploy_tool "lulu" "LuLu"
info "Required → System Settings › Privacy & Security › Full Disk Access"

# ── [2/4] BlockBlock ──────────────────────────────────────────────────────────
section "[2/4] BLOCKBLOCK >> PERSISTENCE SENTINEL"
echo -e "  ${DIM}Malware needs to survive reboots. BlockBlock makes sure it can't."
echo -e "  Watches every LaunchAgent, login item and startup vector."
echo -e "  Anything tries to persist >> you get an alert. Immediately.${RESET}"
echo ""
deploy_tool "blockblock" "BlockBlock"
info "Follow the setup assistant on first launch"

# ── [3/4] OverSight ───────────────────────────────────────────────────────────
section "[3/4] OVERSIGHT >> CAMERA & MIC WATCHDOG"
echo -e "  ${DIM}Fires the instant any process activates your camera or microphone."
echo -e "  Catches spyware piggybacking on trusted apps."
echo -e "  Sits silently in your menu bar. Watching.${RESET}"
echo ""
deploy_tool "oversight" "OverSight"
info "Launches automatically in menu bar >> look for the eye icon"

# ── [4/4] Malwarebytes ────────────────────────────────────────────────────────
section "[4/4] MALWAREBYTES >> THREAT SCANNER"
echo -e "  ${DIM}Battle-tested macOS malware, adware and ransomware scanner."
echo -e "  Apple Silicon native. Actively maintained threat database."
echo -e "  Free for on-demand scans. No subscription required.${RESET}"
echo ""
deploy_tool "malwarebytes" "Malwarebytes"
info "Open Malwarebytes and run a baseline scan now"

# ── Mission complete ───────────────────────────────────────────────────────────
echo ""
echo -e "${DIM}  $(printf '═%.0s' {1..70})${RESET}"
echo ""
echo -e "${G}${BOLD}"
echo '  ███████╗███████╗███╗   ██╗████████╗██╗███╗   ██╗███████╗██╗'
echo '  ██╔════╝██╔════╝████╗  ██║╚══██╔══╝██║████╗  ██║██╔════╝██║'
echo '  ███████╗█████╗  ██╔██╗ ██║   ██║   ██║██╔██╗ ██║█████╗  ██║'
echo '  ╚════██║██╔══╝  ██║╚██╗██║   ██║   ██║██║╚██╗██║██╔══╝  ██║'
echo '  ███████║███████╗██║ ╚████║   ██║   ██║██║ ╚████║███████╗███████╗'
echo '  ╚══════╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝'
echo -e "${RESET}"
echo -e "  ${G}${BOLD}ONLINE --- ALL SYSTEMS ARMED${RESET}"
echo ""
echo -e "  ${G}[+]${RESET} ${BOLD}LuLu${RESET}          ${DIM}→${RESET}  outbound network firewall active"
echo -e "  ${G}[+]${RESET} ${BOLD}BlockBlock${RESET}    ${DIM}→${RESET}  persistence vectors locked"
echo -e "  ${G}[+]${RESET} ${BOLD}OverSight${RESET}     ${DIM}→${RESET}  camera & microphone guarded"
echo -e "  ${G}[+]${RESET} ${BOLD}Malwarebytes${RESET}  ${DIM}→${RESET}  threat scanner ready"
echo ""
echo -e "${DIM}  $(printf '─%.0s' {1..70})${RESET}"
echo ""
echo -e "  ${Y}[!]${RESET} Open each app once and complete setup in System Settings"
echo -e "  ${Y}[!]${RESET} Grant Full Disk Access to LuLu and BlockBlock"
echo -e "  ${Y}[!]${RESET} Run a Malwarebytes scan to establish a clean baseline"
echo ""
echo -e "  ${DIM}github.com/Rodan-elf/rodan-sentinel${RESET}"
echo ""
