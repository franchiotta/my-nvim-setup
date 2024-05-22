local java_bin = '/Users/fchiotta/.sdkman/candidates/java/17.0.6-oracle/bin/java'
local jdtls_root_path = '/Users/fchiotta/.local/share/nvim/mason/packages/jdtls'
local jdtls_launcher_version = '1.6.800.v20240330-1250'

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h')

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  cmd = {
    java_bin,
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', string.format('%s/plugins/org.eclipse.equinox.launcher_%s.jar', jdtls_root_path, jdtls_launcher_version),
    '-configuration', string.format('%s/config_mac', jdtls_root_path),
    '-data', workspace_dir
  },
  --root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),
  root_dir = "/Users/fchiotta/workspace/adevinta/serenity/serenity-module-moderation",

  -- Here you can configure eclipse.jdt.ls specific settings
  settings = {
    java = {
        configuration = {
            runtimes = {
              {
                name = "JavaSE_1_8",
                path = "/Library/Java/JavaVirtualMachines/jdk1.8.0_261.jdk/Contents/Home/",
              },
              {
                name = "JavaSE-11",
                path = "/Library/Java/JavaVirtualMachines/jdk-11.0.16.jdk/Contents/Home/",
              },
              {
                name = "JavaSE-17",
                path = "/Library/Java/JavaVirtualMachines/jdk-17.0.4.1.jdk/Contents/Home/",
              },
            }
        }
    }
  }
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
