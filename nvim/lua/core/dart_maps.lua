vim.api.nvim_create_autocmd("FileType", {
	pattern = "dart",
	callback = function()
		vim.api.nvim_create_user_command("FRUN", function()
			if os.getenv("TMUX") == nil then
				vim.notify("You are not running inside tmux. Please start tmux and try again.", vim.log.levels.ERROR)
				return
			end
			local project_root = require("core.utils").get_project_root()
			local command = "tmux split-window -p 20 'zsh -c \"cd " .. project_root .. " && flutter run\"'"

			local handle = io.popen(command)
			if handle ~= nil then
				handle:close()
			end
		end, { nargs = 0 })

		vim.api.nvim_create_user_command("FlutterInput", function(input)
			local send_command = "tmux send-keys -t ! '" .. input.args .. "' Enter"
			os.execute(send_command)
		end, { nargs = 1 })
		vim.keymap.set("n", "<leader>r", function()
			vim.cmd("FlutterInput r")
			vim.notify("Hot reload. 🔥🔥🔥", vim.log.levels.INFO)
		end, {
			desc = "Hot reload. 🔥🔥🔥",
			noremap = true,
			silent = true,
		})
		vim.keymap.set("n", "<leader>R", function()
			vim.cmd("FlutterInput R")
			vim.notify("Hot restart. 🔥🔥🔥", vim.log.levels.INFO)
		end, {
			desc = "Hot restart. 🔥🔥🔥",
			noremap = true,
			silent = true,
		})

		vim.keymap.set("n", "<leader>s", function()
			vim.cmd("FlutterInput q")
			vim.notify("Stop app. ", vim.log.levels.INFO)
		end, {
			desc = "Stop app",
			noremap = true,
			silent = true,
		})
	end,
})
