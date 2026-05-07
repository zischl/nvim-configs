return {
	"Civitasv/cmake-tools.nvim",
	dependencies = {},
	opts = {

		cmake_command = "cmake",
		ctest_command = "ctest",
		cmake_use_native_terminal = false,
		cmake_regenerate_on_save = true,
		cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=2" },
		cmake_build_directory = "build/${variant:buildType}",

		cmake_notifications = {
			runner = { enabled = true, quickfix = { show = "never" } },
			executor = { enabled = true, quickfix = { show = "never" } },
		},

		cmake_executor = {
			name = "terminal",
			opts = {},
		},
		cmake_runner = {
			name = "terminal",
			opts = {},
		},

		cmake_terminal = { focus = false },
		cmake_variants_message = {
			short = { show = true },
			long = { show = true, max_length = 41 },
		},

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
