-----------------------------------------------------------------------------
-- Имя текущей tmux-сессии
-----------------------------------------------------------------------------
local tmux_session_name = function()
	return vim.fn.system("tmux display-message -p '#S'"):gsub("\n", "")
end

return { tmux_session_name }
