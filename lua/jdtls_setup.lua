local M = {}

local function get_jdtls_paths()
	local mason_path = vim.fn.stdpath("data") .. "/mason/"
	mason_path = string.gsub(mason_path, [[\]], "/")

	local jdtls_path = mason_path .. "packages/jdtls"

	local launcher_jar =
		vim.fn.glob(string.gsub(jdtls_path, [[\]], "/") .. "/plugins/org.eclipse.equinox.launcher_*.jar")

	local extended_bundles = {}

	vim.list_extend(
		extended_bundles,
		vim.split(vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/*.jar", true), "\n")
	)

	vim.list_extend(
		extended_bundles,
		vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar", true), "\n")
	)

	vim.list_extend(
		extended_bundles,
		vim.split(vim.fn.glob(mason_path .. "packages/vscode-java-decompiler/server/*.jar", true), "\n")
	)

	return jdtls_path, launcher_jar, extended_bundles
end

local function on_attach(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

	vim.keymap.set("n", "<leader>ev", require("jdtls").extract_variable, opts)
	vim.keymap.set("n", "<leader>ec", require("jdtls").extract_constant, opts)
	vim.keymap.set("n", "<leader>em", require("jdtls").extract_method, opts)

	local dap_status, dap = pcall(require, "dap")
	local jdap_status, jdap = pcall(require, "jdtls.dap")

	vim.lsp.codelens.refresh()
	require("jdtls.setup").add_commands()

	if dap_status and jdap_status then
		jdap.setup_dap()
		jdap.setup_dap_main_class_configs()
	end
end

function M:setup()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local os_name = vim.loop.os_uname().sysname
	local jdtls_path, launcher_jar, extended_bundles = get_jdtls_paths()
	local base_data = string.gsub(vim.fn.stdpath("data"), [[\]], "/")
	local workspace_dir = base_data .. "/jdtls-workspace/" .. project_name

	local config = {
		cmd = {
			"java", -- replace this with ur java path if it's not in ur env path
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xmx1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",

			"-jar",
			launcher_jar,

			"-configuration",
			jdtls_path .. "/config_" .. (os_name == "Windows_NT" and "win" or os_name == "Linux" and "linux" or "mac"),

			"-data",
			workspace_dir,
		},

		root_dir = require("jdtls.setup").find_root({
			".git",
			"pom.xml",
			"build.gradle",
			"settings.gradle",
			"mvnw",
			"gradlew",
			".project",
			".classpath",
		}),

		init_options = {
			bundles = extended_bundles,
		},

		settings = {
			java = {
				referencesCodeLens = {
					enabled = true,
				},
				implementationsCodeLens = {
					enabled = true,
				},
				signatureHelp = { enabled = true },
			},
		},

		capabilities = require("blink.cmp").get_lsp_capabilities(),
		on_attach = on_attach,
	}

	require("jdtls").start_or_attach(config)
end

return M
