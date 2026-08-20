{...}: {
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
      clipboard = "unnamedplus"; # системный буфер через wl-clipboard, он уже есть
      splitright = true;
      splitbelow = true;
    };

    globals.mapleader = " ";

    # --- Прозрачный фон (перенесено из старого конфига) ---
    extraConfigLua = ''
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          for _, group in ipairs({ "Normal", "NormalNC", "NormalFloat", "SignColumn", "EndOfBuffer" }) do
            vim.api.nvim_set_hl(0, group, { bg = "none" })
          end
        end,
      })
    '';

    # --- Подсветка синтаксиса ---
    plugins.treesitter = {
      enable = true;
      settings.highlight.enable = true;
      settings.indent.enable = true;
    };

    # --- LSP ---
    plugins.lsp = {
      enable = true;
      servers = {
        nixd.enable = true; # LSP для .nix (по конфигу самого репозитория)
        lua-ls.enable = true;
        bashls.enable = true;
        pyright.enable = true;
        # добавляй сюда другие: rust-analyzer, tsserver, clangd и т.п.
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

    # --- Форматирование (alejandra для .nix — как в твоём devShell) ---
    plugins.conform-nvim = {
      enable = true;
      settings.formatters_by_ft = {
        nix = ["alejandra"];
        lua = ["stylua"];
        python = ["black"];
      };
    };

    # --- Автодополнение ---
    plugins.cmp = {
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
    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp-path.enable = true;
    plugins.cmp-buffer.enable = true;

    # --- Fuzzy-поиск файлов/текста ---
    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
        "<leader>fh" = "help_tags";
      };
    };

    # --- Файловое дерево ---
    plugins.neo-tree = {
      enable = true;
    };
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
    ];

    # --- Статусбар, git, мелкие удобства ---
    plugins.lualine.enable = true;
    plugins.gitsigns.enable = true;
    plugins.comment.enable = true; # gcc / gc — комментировать строки
    plugins.nvim-autopairs.enable = true;
    plugins.which-key.enable = true; # подсказки биндов при вводе <leader>
    plugins.web-devicons.enable = true;
  };
}
