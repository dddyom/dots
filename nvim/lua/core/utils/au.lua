local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

local group = augroup("OoO")

-- Упрощённый хелпер для autocmd
local function au(typ, pattern, cmdOrFn, group_override)
	local grp = group_override or group
	if type(cmdOrFn) == "function" then
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = grp })
	else
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = grp })
	end
end

return {
	au = au,
	augroup = augroup,
}
