---
id: fact-macos-gui-path-homebrew-nix-profiles-mrsp857l
kind: fact
state: active
weight: 0.84
topics:
  - PATH
  - macOS
  - nix-darwin
  - Homebrew
  - Pi Insight
  - sim-use
  - pi-subagents
relations:
  related_to:[]
  refines:
    - fact-macos-gui-path-homebrew-nix-cli-mrswdcgr
  supersedes:[]
  superseded_by:[]
created_at: 2026-07-20T04:02:36.512Z
updated_at: 2026-07-20T07:22:36.508Z
last_accessed_at: 2026-07-20T04:02:36.512Z
access_count: 0
sources:
  - kind: session
    session_ref: "019f688e-d1e1-7d46-83c2-8d01fa76d93f"
    excerpt: "用户提供 Pi Insight session，要求确认 sim-use PATH 问题是否来自 machine flake；诊断确认 guiPath 缺少 /opt/homebrew/bin。"
    timestamp: 2026-07-20T04:02:36.512Z
    content_hash: sha256:YGRhcndpbi9lbnYubml4YCDnmoQgYGd1
review_note: ""
---
# Summary
macOS GUI PATH 显式覆盖系统、Homebrew、Nix 与用户 CLI

# Fact
`darwin/env.nix` 的 `guiPath` 以 macOS 系统目录开头，并显式包含 `/usr/local/bin`、`/opt/homebrew/bin`、稳定的 Nix profile 路径以及 `/Users/${username}/.local/bin`；该值同时用于 `launchd.user.envVariables.PATH` 和持久化的 `launchctl config user path`。因此通过 LaunchServices 启动的 Pi Insight 可发现 Homebrew 的 `sim-use` 和用户级安装的 `pi`，同时系统工具保持优先。

# Context
Pi Insight 的 GUI/Agent Host 及 pi-subagents 直接继承 launchd PATH，不会依赖交互式 shell 初始化。先前静态 `guiPath` 补了 Homebrew 但遗漏了 Home Manager 已声明的 `$HOME/.local/bin`，导致 pi-subagents 以 `spawn("pi")` 启动时 ENOENT；中央修复是在 machine flake 中补入用户 CLI 路径，而不是创建 `/usr/local/bin/pi` 临时软链。
