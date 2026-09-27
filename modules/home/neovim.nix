{
  pkgs, # Добавляем pkgs, так как некоторые утилиты (типа ruff) понадобятся глобально, если их нет в devShell
  ...
}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globalOpts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      signcolumn = "yes";
      updatetime = 250;
      mouse = "a";
      clipboard = "unnamedplus";
      splitright = true;
      splitbelow = true;
      smartindent = false;
      cindent = false;
      autoindent = true;
      # Исправлено: langmap объявляем прямо в основном сете globalOpts
      langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz";
    };

    # Настройки табов для разных языков (PEP8 для Python требует 4 пробела)
    autoCmd = [
      {
        event = "FileType";
        pattern = ["nix" "lua" "bash"];
        command = "setlocal shiftwidth=2 tabstop=2 expandtab";
      }
      {
        event = "FileType";
        pattern = ["python" "rust" "c" "cpp"];
        command = "setlocal shiftwidth=4 tabstop=4 expandtab";
      }
      # Автоматический пинок для basedpyright при переключении буферов
      {
        event = "BufEnter";
        pattern = "*.py";
        command = "lua if vim.lsp.get_clients then for _, client in ipairs(vim.lsp.get_clients({name = 'basedpyright'})) do client.request('workspace/didChangeConfiguration', { settings = client.config.settings }, function() end, 0) end end";
      }
    ];

    globals.mapleader = " ";

    plugins = {
      direnv.enable = true;

      # --- Подсветка синтаксиса ---
      treesitter = {
        enable = true;
        settings.highlight.enable = true;
        settings.indent.enable = true; # Для Python лучше включить, помогает с отступами структур
      };

      # --- LSP ---
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          lua_ls.enable = true;
          bashls.enable = true;

          # Для Python: pyright хорош для типов, но ruff_lsp идеален для линтинга в реальном времени
          basedpyright = {
            enable = true;
            settings = {
              basedpyright = {
                analysis = {
                  # Варианты: "off" (только синтаксис), "basic", "standard"
                  typeCheckingMode = "standard";

                  # Отключаем ругань на отсутствие type stubs у сторонних библиотек (типа playwright)
                  reportMissingTypeStubs = "none";

                  # Правильно прокидываем пути из devenv / direnv
                  extraPaths = {
                    __raw = ''
                      (function()
                        local paths = {}
                        local pythonpath = os.getenv("PYTHONPATH")
                        if pythonpath then
                          for path in string.gmatch(pythonpath, "[^:]+") do
                            table.insert(paths, path)
                          end
                        end
                        return paths
                      end)()
                    '';
                  };
                };
              };
            };
          };

          ruff.enable = true;
        };

        keymaps = {
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
          };
          lspBuf = {
            "gd" = "definition";
            "gr" = "references";
            "K" = "hover";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
          };
        };
      };

      # --- Форматирование (Используем Ruff вместо Black) ---
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
          formatters_by_ft = {
            nix = ["alejandra"];
            lua = ["stylua"];
            # ruff_organize_imports отсортирует импорты, ruff_format — причешет код
            python = ["ruff_organize_imports" "ruff_format"];
          };
        };
      };

      # --- Автодополнение ---
      cmp = {
        enable = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;

      # --- Дебаггер (Исправлено: теперь внутри общего сета plugins) ---
      dap.enable = true;
      dap-ui.enable = true;
      dap-python = {
        enable = true;
        adapterPythonPath = "${pkgs.python3.withPackages (ps: [ps.debugpy])}/bin/python";
      };

      # --- Fuzzy-поиск ---
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
        };
      };

      # --- Файловое дерево ---
      neo-tree.enable = true;

      # --- Дополнительные плагины для уровня IDE ---
      lualine.enable = true;
      gitsigns.enable = true;
      comment.enable = true;
      nvim-autopairs.enable = true;
      which-key.enable = true;
      web-devicons.enable = true;

      # Умное переключение виртуальных окружений (.venv) для LSP.
      # Автоматически подхватывает окружение, активированное через direnv/devenv.
      venv-selector = {
        enable = true;
        settings = {
          stay_on_this_version = true; # Не сбрасывать при переключении буферов
        };
      };
    };

    # --- Горячие клавиши ---
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
      }
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<CR>";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<CR>";
      }
      # Навигация по окнам (Прекрасно работает в Niri при разделении экрана внутри Neovim)
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
      }

      # Горячие клавиши отладчика (DAP)
      {
        mode = "n";
        key = "<F5>";
        action = "<cmd>lua require('dap').continue()<CR>";
        options.desc = "Запустить / Продолжить отладку";
      }
      {
        mode = "n";
        key = "<F10>";
        action = "<cmd>lua require('dap').step_over()<CR>";
        options.desc = "Шаг через (Step over)";
      }
      {
        mode = "n";
        key = "<F11>";
        action = "<cmd>lua require('dap').step_into()<CR>";
        options.desc = "Шаг в (Step into)";
      }
      {
        mode = "n";
        key = "<F12>";
        action = "<cmd>lua require('dap').step_out()<CR>";
        options.desc = "Шаг из (Step out)";
      }
      {
        mode = "n";
        key = "<leader>b";
        action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
        options.desc = "Поставить/убрать точку останова";
      }
      # Быстрый выбор venv вручную, если direnv еще не отработал
      {
        mode = "n";
        key = "<leader>vs";
        action = "<cmd>VenvSelect<CR>";
        options.desc = "Выбрать виртуальное окружение Python";
      }
    ];

    extraConfigLua = ''
      local dap, dapui = require("dap"), require("dapui")

      -- Автоматическое открытие интерфейса DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      if dap.configurations.python then
        for _, config in ipairs(dap.configurations.python) do
          -- 1. Динамический выбор интерпретатора проекта
          config.pythonPath = function()
            if os.getenv("VIRTUAL_ENV") then
              return os.getenv("VIRTUAL_ENV") .. "/bin/python"
            elseif os.getenv("PRJ_ROOT") then
              return os.getenv("PRJ_ROOT") .. "/.devenv/state/venv/bin/python"
            else
              return "python3"
            end
          end

          config.console = "integratedTerminal"
        end
      end
    '';
  };
}
