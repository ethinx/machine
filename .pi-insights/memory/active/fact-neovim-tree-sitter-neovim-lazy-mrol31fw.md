---
id: fact-neovim-tree-sitter-neovim-lazy-mrol31fw
kind: fact
state: active
weight: 0.9
topics:
  - Neovim
  - nvim-treesitter
  - Nix flakes
relations:
  related_to:[]
  refines:[]
  supersedes:
    - fact-neovim-tree-sitter-nix-mroi1wss
  superseded_by:[]
created_at: 2026-07-17T06:55:35.179Z
updated_at: 2026-07-17T06:55:35.179Z
last_accessed_at: 2026-07-17T06:55:35.179Z
access_count: 0
sources:
  - kind: session
    session_ref: "019f6e7e-1d44-74de-b09a-e2f8e775c22e"
    excerpt: "用户：先 revert，清理再试；Neovim 配置还是在 Vim 里面控制。"
    timestamp: 2026-07-17T06:55:35.179Z
    content_hash: sha256:5bey5Zue6YCA5bCGIG52aW0tdHJlZXNp
review_note: ""
---
# Summary
Neovim Tree-sitter 继续由 Neovim/Lazy 管理

# Fact
已回退将 nvim-treesitter 与 grammar 迁移到 Nix 的方案；`modules/neovim/config/lua/plugins.lua` 和 `editor/treesitter.lua` 继续负责插件、`:TSUpdate` 与 parser 安装，Nix 仅保留 `pkgs.tree-sitter` 运行依赖。遇到 `mv cannot stat ...-master` 时优先清理 Neovim 本地缓存和 parser 状态后重试。

# Context
用户明确偏好 Neovim 配置继续在 Vim/Lua 内控制，并决定先用清理本地状态的最小方案排查新机器上的安装错误。因此先前的 Nix 声明式 grammar 管理事实已不再适用。
