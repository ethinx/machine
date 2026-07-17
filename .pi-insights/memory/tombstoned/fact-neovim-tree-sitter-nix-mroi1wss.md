---
id: fact-neovim-tree-sitter-nix-mroi1wss
kind: fact
state: tombstoned
weight: 0.86
topics:
  - Neovim
  - nvim-treesitter
  - Nix flakes
relations:
  related_to:[]
  refines:[]
  supersedes:[]
  superseded_by:
    - fact-neovim-tree-sitter-neovim-lazy-mrol31fw
created_at: 2026-07-17T05:30:43.659Z
updated_at: 2026-07-17T06:55:35.180Z
last_accessed_at: 2026-07-17T05:30:43.659Z
access_count: 0
sources:
  - kind: session
    session_ref: "019f6e7e-1d44-74de-b09a-e2f8e775c22e"
    excerpt: "用户反馈新机器 build flakes 后 nvim-treesitter 在 gowork/dockerfile/lua/gomod 安装时出现 `mv cannot stat ...-master`；已改为 Nix 声明式 grammar 管理并完成构建与隔离运行验证。"
    timestamp: 2026-07-17T05:30:43.659Z
    content_hash: sha256:YG1vZHVsZXMvbmVvdmltL2RlZmF1bHQu
review_note: ""
---
# Summary
Neovim Tree-sitter 改由 Nix 声明式管理

# Fact
`modules/neovim/default.nix` 通过 `pkgs.vimPlugins.nvim-treesitter.withPlugins` 同时固定 nvim-treesitter 与 29 个所需 grammar；Lua 配置不再调用 `treesitter.install()` 或 Lazy 的 `:TSUpdate`，从而避免 GitHub archive 的 `master`/`main` 目录名变化导致 `mv cannot stat`。

# Context
新机器首次启动时，旧的运行时下载器假设 archive 解压目录以 `-master` 结尾，但相关 grammar 仓库已返回 `-main`。将插件与 grammar 一起交给 flake/nixpkgs 构建后，Neovim 启动不再联网下载或本地编译 parser，插件和 grammar 版本也由同一 Nix derivation 保持一致。
