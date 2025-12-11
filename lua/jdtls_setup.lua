local M = {}

local function get_jdtls_paths()
	local mason_path = vim.fn.stdpath("data") .. "/mason/"
	local jdtls_path = string.gsub(mason_path, [[\]], "/") .. "packages/jdtls"

	local launcher_jar =
		vim.fn.glob(string.gsub(jdtls_path, [[\]], "/") .. "/plugins/org.eclipse.equinox.launcher_*.jar")

	local extended_bundles = {
		mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
	}

	return jdtls_path, launcher_jar, extended_bundles
end

local function on_attach(client, bufnr)
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

	local jdap = require("jdtls.dap")
	local dap = require("dap")
	if dap then
		jdap.setup_dap()
		jdap.setup_dap_main_class_configs()
	end
end

function M:setup()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local os_name = vim.loop.os_uname().sysname
	local jdtls_path, launcher_jar, extended_bundles = get_jdtls_paths()
	local workspace_dir = vim.fn.stdpath("data")
		.. package.config:sub(1, 1)
		.. "jdtls-workspace"
		.. package.config:sub(1, 1)
		.. project_name

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

		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		on_attach = on_attach,
	}

	require("jdtls").start_or_attach(config)
end

return M
