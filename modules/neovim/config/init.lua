require("basic")
require("autocmd")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local lazy_lockfile = vim.env.NVIM_LAZY_LOCKFILE
if lazy_lockfile == "" then
  error("NVIM_LAZY_LOCKFILE must not be empty")
end

if lazy_lockfile == nil then
  lazy_lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json"
  if not vim.uv.fs_stat(lazy_lockfile) then
    vim.fn.mkdir(vim.fs.dirname(lazy_lockfile), "p")
    local source_lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json"
    local copied, copy_error = vim.uv.fs_copyfile(source_lockfile, lazy_lockfile)
    if not copied then
      error(string.format("failed to initialize lazy lockfile from %s: %s", source_lockfile, copy_error))
    end
  end

  local chmod_ok, chmod_error = vim.uv.fs_chmod(lazy_lockfile, 420)
  if not chmod_ok then
    error(string.format("failed to make lazy lockfile writable at %s: %s", lazy_lockfile, chmod_error))
  end
end

require('lazy').setup("plugins", { lockfile = lazy_lockfile })

require("keymaps")
require("iautoscroll")
