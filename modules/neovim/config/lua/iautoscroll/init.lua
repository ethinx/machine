-- Credit
-- Author: Yu Yuwei <acevery@gmail.com>
-- URL: https://forums.gentoo.org/viewtopic-t-708346-start-0.html
--
-- Have used the snippet for many years and trying NeoVim recently, so make this lua copy
-- The latest version may be https://github.com/acevery/vim/blob/master/plugin/iautoscroll.vim

if vim.g.iscroll_mode == nil or vim.api.nvim_get_var("iscroll_mode") ~= "off" then
	vim.api.nvim_create_autocmd("CursorMovedI", { command = [[:lua require('iautoscroll').scroll()]] })
end

local M = {}

function M.scroll()
	local winht = vim.fn.winheight(vim.fn.winnr())

	if winht <= 20 then -- dirty hack, avoid inifity scrolling in float windows like telescope
		return
	end

	local cursor_line_no = vim.fn.winline()

	if cursor_line_no == winht then
		if vim.g.iscroll_mode == "center" then
			vim.cmd([[normal zz]])
		elseif vim.g.iscroll_mode == "top" then
			vim.cmd([[normal zt]])
		else
			vim.cmd([[normal zz]])
		end
	end
end

return M
