local llm = require("llm")
local openai = require("llm.providers.openai")

return {
	code = {
		provider = openai,
		mode = llm.mode.BUFFER,
		builder = function(input)
			return {
				messages = {
					{
						role = "system",
						content = "You are a 10x super elite programmer. Continue only with code. Do not write tests, examples, or output of code unless explicitly asked for.",
					},
					{
						role = "user",
						content = input,
					},
				},
			}
		end,
	},
	doc = {
		provider = openai,
		mode = llm.mode.BUFFER,
		builder = function(input)
			return {
				messages = {
					{
						role = "system",
						content = "You are a 10x super elite programmer. Do not write tests, examples, or output of code unless explicitly asked for. Write documentation for this",
					},
					{
						role = "user",
						content = input,
					},
				},
			}
		end,
	},
	ru = {
		provider = openai,
		hl_group = "SpecialComment",
		builder = function(input)
			return {
				messages = {
					{
						role = "system",
						content = "Translate to Russian",
					},
					{
						role = "user",
						content = input,
					},
				},
			}
		end,
		mode = llm.mode.REPLACE,
	},
	en = {
		provider = openai,
		hl_group = "SpecialComment",
		builder = function(input)
			return {
				messages = {
					{
						role = "system",
						content = "Translate to English",
					},
					{
						role = "user",
						content = input,
					},
				},
			}
		end,
		mode = llm.mode.REPLACE,
	},
}
