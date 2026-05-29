return {
	"Civitasv/cmake-tools.nvim",
	dependencies = {},
	opts = {

		cmake_regenerate_on_save = true,
		cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
		cmake_build_directory = "build/${variant:buildType}",

		cmake_dap_configuration = {
			name = "cpp",
			type = "codelldb",
			request = "launch",
			stopOnEntry = false,
			runInTerminal = true,
			console = "integratedTerminal",
		},
	},
}
