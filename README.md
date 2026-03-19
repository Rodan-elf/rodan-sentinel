# RODAN SENTINEL

```
  ██████╗  ██████╗ ██████╗  █████╗ ███╗   ██╗    ███████╗███████╗███╗   ██╗████████╗██╗███╗   ██╗███████╗██╗
  ██╔══██╗██╔═══██╗██╔══██╗██╔══██╗████╗  ██║    ██╔════╝██╔════╝████╗  ██║╚══██╔══╝██║████╗  ██║██╔════╝██║
  ██████╔╝██║   ██║██║  ██║███████║██╔██╗ ██║    ███████╗█████╗  ██╔██╗ ██║   ██║   ██║██╔██╗ ██║█████╗  ██║
  ██╔══██╗██║   ██║██║  ██║██╔══██║██║╚██╗██║    ╚════██║██╔══╝  ██║╚██╗██║   ██║   ██║██║╚██╗██║██╔══╝  ██║
  ██║  ██║╚██████╔╝██████╔╝██║  ██║██║ ╚████║    ███████║███████╗██║ ╚████║   ██║   ██║██║ ╚████║███████╗███████╗
  ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚══════╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝
```

> Autonomous endpoint security stack for macOS. Install once. Never think about it again.

![macOS](https://img.shields.io/badge/macOS-10.15%2B-black?logo=apple&style=flat-square)
![Apple Silicon](https://img.shields.io/badge/Apple_Silicon-Ready-red?logo=apple&style=flat-square)
![Intel](https://img.shields.io/badge/Intel-Ready-blue?logo=intel&style=flat-square)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)
![Cost](https://img.shields.io/badge/cost-free-brightgreen?style=flat-square)
![Tools](https://img.shields.io/badge/tools-4-orange?style=flat-square)

---

## What is this?

RODAN SENTINEL is a one command setup script that deploys four battle-tested, open source security tools on macOS. No dashboards to monitor. No logs to parse. No paid subscriptions.

The stack runs silently in the background and fires an alert the moment something suspicious happens. Network connection from an unknown binary. A process trying to install a LaunchAgent at 3am. Spyware activating your camera. You get notified. You decide.

Zero maintenance. Maximum coverage.

---

## Deploy

```bash
curl -fsSL https://raw.githubusercontent.com/Rodan-elf/rodan-sentinel/main/setup.sh | bash
```

Or manually:

```bash
git clone https://github.com/Rodan-elf/rodan-sentinel.git
cd rodan-sentinel
chmod +x setup.sh
./setup.sh
```

---

## Arsenal

### LuLu > Network Firewall
Every process on your Mac that tries to make an outbound connection goes through LuLu first. Unknown binary phones home? LuLu intercepts it and asks you: allow or block? You answer once and it remembers. Nothing leaves your machine without your permission.

- Intercepts outbound connections in real time
- Blocks unknown or suspicious processes immediately
- Rule-based >> you build your own allow/block list over time
- Catches malware C2 callbacks, data exfiltration, reverse shells

> https://objective-see.org/products/lulu.html

---

### BlockBlock > Persistence Sentinel
Malware that can't survive a reboot is dead. So every piece of malware tries to install itself somewhere that runs at startup > a LaunchAgent, a login item, a cron job, a browser extension. BlockBlock watches every single one of those vectors and alerts you the instant anything tries to register itself for persistence.

- Monitors LaunchAgents, LaunchDaemons, login items, startup scripts
- Catches browser extension injections
- Shows the exact binary trying to persist and its path
- Zero false negatives on persistence > if it tries to start at boot, BlockBlock sees it

> https://objective-see.org/products/blockblock.html

---

### OverSight > Camera & Mic Watchdog
Spyware and stalkerware activate your camera and microphone silently. OverSight sits in your menu bar and fires an alert the instant any application activates either device. It even catches the advanced technique where malware piggybacks on a legitimate audio stream to avoid detection.

- Real-time alerts on camera activation
- Real-time alerts on microphone activation
- Identifies the exact process accessing the hardware
- Menu bar icon > near-zero resource usage

> https://objective-see.org/products/oversight.html

---

### Malwarebytes > Threat Scanner
The most actively maintained macOS malware scanner. Detects Mac-specific malware, adware, ransomware, and PUPs. Apple Silicon native. Free for on-demand scanning — no subscription, no telemetry, no bullshit.

- Detects macOS malware, adware, spyware, ransomware
- Apple Silicon (M1/M2/M3) native binary
- Up-to-date threat signatures
- Free for manual scans

> https://www.malwarebytes.com

---

## Threat coverage

| Attack vector | LuLu | BlockBlock | OverSight | Malwarebytes |
|---|:---:|:---:|:---:|:---:|
| C2 callbacks / reverse shells | X | | | X |
| Data exfiltration | X | | | X |
| Persistence via LaunchAgents | | X | | X |
| Persistence via login items | | X | | X |
| Browser extension injection | | X | | X |
| Camera spyware | X | | X | X |
| Microphone spyware | X | | X | X |
| Ransomware | X | X | | X |
| Adware | X | X | | X |

---

## Post-install

After running the script, each tool needs to be opened once and granted macOS permissions:

```
1. Open LuLu      >> complete setup wizard > grant Full Disk Access
2. Open BlockBlock >> follow the setup assistant > grant Full Disk Access
3. OverSight       >> already running in menu bar > allow notifications
4. Malwarebytes    >> open > run a baseline scan
```

All four tools require Full Disk Access or Accessibility permissions to function. macOS will prompt you >> allow everything.

---

## Why these tools?

LuLu, BlockBlock, and OverSight are built by **Patrick Wardle** > former NSA hacker, macOS security researcher, and founder of Objective-See. All source code is public and auditable. No telemetry. No cloud. No subscriptions.

Malwarebytes has the most up-to-date macOS threat database and has been actively maintained since 2008.

This is what security professionals actually run on their own machines.

---

## Requirements

- macOS 10.15 (Catalina) or newer
- Apple Silicon (M1/M2/M3) or Intel >> both supported
- [Homebrew](https://brew.sh) >> auto-installed if missing
- Admin password for system permissions

---

## License

MIT >> free to use, fork and distribute.

---

*Built by [Rodan-elf](https://github.com/Rodan-elf) as a practical demonstration of macOS endpoint hardening using 100% free and open source tooling.*
