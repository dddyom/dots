-- TypeScript/JavaScript LSP с Vue plugin из Mason
local vue_language_server_path = vim.fn.expand("$MASON")
	.. "/packages/vue-language-server/node_modules/@vue/language-server"

-- Плагин типизации для Vue в tsserver
local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

return {
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
	},

	init_options = {
		plugins = {
			vue_plugin,
		},
	},
}
