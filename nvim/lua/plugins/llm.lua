local leader_v = require("utils.map").leader_v
local leader = require("utils.map").leader

return {
	"gsuuon/llm.nvim",
	config = function()
		-- local openai = require("llm.providers.openai")
		-- local util = require("llm.util")
		-- local llm = require("llm")
		--
		-- llm.setup({
		-- 	hl_group = "Substitute",
		-- 	prompts = util.module.autoload("utils.prompts"),
		-- 	default_prompt = {
		-- 		mode = llm.mode.BUFFER,
		-- 		provider = openai,
		-- 		builder = function(input)
		-- 			return {
		-- 				temperature = 0.3,
		-- 				max_tokens = 120,
		-- 				messages = {
		-- 					{
		-- 						role = "system",
		-- 						content = "You are helpful assistant.",
		-- 					},
		-- 					{
		-- 						role = "user",
		-- 						content = input,
		-- 					},
		-- 				},
		-- 			}
		-- 		end,
		-- 	},
		-- })
		-- leader_v("x", "", "LLM")
		-- leader("x", "", "LLM")
		-- leader_v("xl", "<cmd>Llm<cr>", "default llm")
		-- leader("xl", "<cmd>Llm<cr>", "default llm")
		-- leader_v("xd", "<cmd>Llm doc<cr>", "llm write doc")
		-- leader_v("xr", "<cmd>Llm ru<cr>", "translate to russian")
		-- leader_v("xe", "<cmd>Llm en<cr>", "translate to english")
		-- leader_v("xc", "<cmd>Llm code<cr>", "llm write code")
		-- leader_v("xs", "<cmd>LlmSelect<cr>", "Select llm answer")
		-- leader_v("xd", "<cmd>LlmDelete<cr>", "Delete llm answer")
	end,
}
