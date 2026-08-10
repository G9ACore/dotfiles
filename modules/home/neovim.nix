{
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
    extraLuaConfig = ''
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "Normal",   { bg = "NONE" })
          vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
        end,
      })
    '';
  };
}
