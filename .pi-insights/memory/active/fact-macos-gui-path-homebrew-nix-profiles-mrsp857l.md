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
relations:
  related_to:[]
  refines:[]
  supersedes:[]
  superseded_by:[]
created_at: 2026-07-20T04:02:36.512Z
updated_at: 2026-07-20T04:02:36.512Z
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
macOS GUI PATH 显式包含 Homebrew 与 Nix profiles

# Fact
`darwin/env.nix` 的 `guiPath` 以 macOS 系统目录开头，并显式包含 `/usr/local/bin`、`/opt/homebrew/bin` 及稳定的 Nix profile 路径；该值同时用于 `launchd.user.envVariables.PATH` 和持久化的 `launchctl config user path`。因此通过 LaunchServices 启动的 Pi Insight 等 GUI agent 可发现 Homebrew 安装的 `sim-use`，同时系统工具保持优先。

# Context
2026-07-20 的 Pi Insight session 中 `sim-use: command not found`，原因是此前为修复 Nix Node PATH 而新增的静态 `guiPath` 漏掉了 `/opt/homebrew/bin`，覆盖了 `/etc/paths.d/homebrew` 通常提供的效果。修复是在 machine flake 中补入该目录，而不是给 Pi Insight 添加 shellCommandPrefix 或 path_helper patch。
