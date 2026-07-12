vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.python3_host_prog = "/usr/bin/python3" -- for beancount

local options = {
  backspace = "indent,eol,start",
  hlsearch = true,
  incsearch = true,
  history = 300,
  fileencodings = { "ucs-bom", "utf-8", "cp936", "gb18030", "big5", "euc-jp", "euc-kr", "latin1" },
  encoding = "utf8",
  -- termencoding = "utf-8",
  autoread = true,
  whichwrap = "s,<,>,[,]",
  backup = false,
  wb = false,
  swapfile = false,
  showcmd = true,
  showmatch = true,
  matchtime = 5,
  ignorecase = true,
  smartcase = true,
  number = true,
  completeopt = { "menu", "noselect" },

  syntax = "on",
  mouse = "",

  foldenable = true,
  fdm = "indent",
  foldlevel = 999,
  splitright = true,

  lazyredraw = true,
  signcolumn = "yes",

  -- list = true,
  -- listchars = 'tab:»·,trail:·,nbsp:·,extends:>,precedes:<',
  tags = "./.tags;,.tags",

  ffs = "unix,dos,mac",
  suffixes = ".bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class",

  tabstop = 4,
  shiftwidth = 4,
  expandtab = true,
  smarttab = true,
  autoindent = true,
  termguicolors = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.filetype = "on"
vim.opt.filetype.plugin = "on"
vim.opt.filetype.indent = "on"

vim.opt.errorformat:append("[%f:%l] -> %m,[%f:%l]:%m")
vim.opt.formatoptions = vim.opt.formatoptions:append("m")
vim.opt.formatoptions = vim.opt.formatoptions:append("B")

vim.opt.wildignore = "*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib"
vim.opt.wildignore = vim.opt.wildignore + "*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex"
vim.opt.wildignore = vim.opt.wildignore + "*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz"
vim.opt.wildignore = vim.opt.wildignore + "*DS_Store*,*.ipch"
vim.opt.wildignore = vim.opt.wildignore + "*.gem"
vim.opt.wildignore = vim.opt.wildignore + "*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso"
vim.opt.wildignore = vim.opt.wildignore + "*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**"
vim.opt.wildignore = vim.opt.wildignore + "*/.nx/**,*.app,*.git,.git"
vim.opt.wildignore = vim.opt.wildignore + "*.wav,*.mp3,*.ogg,*.pcm"
vim.opt.wildignore = vim.opt.wildignore + "*.mht,*.suo,*.sdf,*.jnlp"
vim.opt.wildignore = vim.opt.wildignore + "*.chm,*.epub,*.pdf,*.mobi,*.ttf"
vim.opt.wildignore = vim.opt.wildignore + "*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc"
vim.opt.wildignore = vim.opt.wildignore + "*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps"
vim.opt.wildignore = vim.opt.wildignore + "*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu"
vim.opt.wildignore = vim.opt.wildignore + "*.gba,*.sfc,*.078,*.nds,*.smd,*.smc"
vim.opt.wildignore = vim.opt.wildignore + "*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android"

if string.match(vim.env.TERM, "256color") and vim.env.TMUX ~= "" then
  -- vim.go.t_ut = ""
end
