local leader = require("utils.map").leader
local leader_v = require("utils.map").leader_v

return {
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup()
			leader("cc", "<cmd>ChatGPT<CR>", "ChatGPT")
			leader("ce", "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction")
			leader_v("ce", "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction")
			leader("cg", "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction")
			leader_v("cg", "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction")
			leader("ct", "<cmd>ChatGPTRun translate<CR>", "Translate")
			leader_v("ct", "<cmd>ChatGPTRun translate<CR>", "Translate")
			leader("ck", "<cmd>ChatGPTRun keywords<CR>", "Keywords")
			leader_v("ck", "<cmd>ChatGPTRun keywords<CR>", "Keywords")
			leader("cd", "<cmd>ChatGPTRun docstring<CR>", "Docstring")
			leader_v("cd", "<cmd>ChatGPTRun docstring<CR>", "Docstring")
			leader("ca", "<cmd>ChatGPTRun add_tests<CR>", "Add Tests")
			leader_v("ca", "<cmd>ChatGPTRun add_tests<CR>", "Add Tests")
			leader("co", "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code")
			leader_v("co", "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code")
			leader("cs", "<cmd>ChatGPTRun summarize<CR>", "Summarize")
			leader_v("cs", "<cmd>ChatGPTRun summarize<CR>", "Summarize")
			leader("cf", "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs")
			leader_v("cf", "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs")
			leader("cx", "<cmd>ChatGPTRun explain_code<CR>", "Explain Code")
			leader_v("cx", "<cmd>ChatGPTRun explain_code<CR>", "Explain Code")
			leader("cr", "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit")
			leader_v("cr", "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit")
			leader("cl", "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis")
			leader_v("cl", "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis")
		end,
	},
	{
		"piersolenski/wtf.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		event = "VeryLazy",
		opts = { language = "russian", search_engine = "stack_overflow" },
		keys = {
			{
				"gw",
				mode = { "n" },
				function()
					require("wtf").ai()
				end,
				desc = "Debug diagnostic with AI",
			},
			{
				mode = { "n" },
				"gW",
				function()
					require("wtf").search()
				end,
				desc = "Search diagnostic with Google",
			},
		},
	},
}
