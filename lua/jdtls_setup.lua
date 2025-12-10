local M = {}

local function get_jdtls_paths()
  local mason_path = vim.fn.stdpath("data") .. "/mason/"
  local jdtls_path = string.gsub(mason_path, [[\]], "/") .. "packages/jdtls"

  local launcher_jar = vim.fn.glob(string.gsub(jdtls_path, [[\]], "/") .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  -- for later use, idk how to do this yet
  local extended_bundles = nil

  return jdtls_path, launcher_jar, extended_bundles
end

function M:setup()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local os_name = vim.loop.os_uname().sysname
  local jdtls_path, launcher_jar, extended_bundles = get_jdtls_paths()

  local workspace_dir = vim.fn.stdpath("data") ..
      package.config:sub(1, 1) .. "jdtls-workspace" .. package.config:sub(1, 1) .. project_name


  local config = {
    cmd = {
      "C:/Program Files/Java/jdk-21.0.2/bin/java.exe",
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

    root_dir = require("jdtls.setup").find_root({ ".git", "pom.xml", "build.gradle", "settings.gradle", "mvnw", "gradlew" }),


    init_options = {
      bundles = extended_bundles,
    },

    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = require("jdtls.dap").on_attach,
  }

  require("jdtls").start_or_attach(config)
end

return M
