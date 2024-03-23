{
  osConfig,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      conform-nvim
      nvim-lint
      markdown-preview-nvim
      headlines-nvim

      # theme
      catppuccin-nvim

      # UI
      bufferline-nvim
      gitsigns-nvim
      edgy-nvim
      dashboard-nvim
      toggleterm-nvim
      trouble-nvim
      lualine-nvim
      which-key-nvim
      nvim-web-devicons
      mini-nvim
      noice-nvim
      nui-nvim
      nvim-notify
      nvim-lsp-notify
      neo-tree-nvim
      nvim-navic
      dressing-nvim
      aerial-nvim

      # project management
      project-nvim
      neoconf-nvim
      persistence-nvim

      # smart typing
      indent-blankline-nvim
      guess-indent-nvim
      vim-illuminate

      # LSP
      nvim-lspconfig
      rust-tools-nvim
      crates-nvim
      null-ls-nvim
      nvim-lightbulb # lightbulb for quick actions
      # nvim-code-action-menu # code action menu
      neodev-nvim
      SchemaStore-nvim # load known formats for json and yaml

      # cmp plugins
      nvim-cmp # completion plugin
      cmp-buffer # buffer completions
      cmp-path # path completions
      cmp_luasnip # snipper completions
      cmp-nvim-lsp # LSP completions

      # snippets
      luasnip # snippet engine
      friendly-snippets # a bunch of snippets to use

      # search functionality
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      nvim-spectre
      flash-nvim

      # treesitter
      nvim-treesitter-context
      nvim-ts-autotag
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars

      # comments
      nvim-ts-context-commentstring
      todo-comments-nvim

      # leap
      vim-repeat
      leap-nvim
      flit-nvim

      # DAP
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text

      # neotest
      neotest
      neotest-rust

      lazy-nvim
      vim-startuptime
    ];
    extraPackages = with pkgs; [
      gcc
      # LazyVim defaults
      stylua
      shfmt

      # Markdown extra
      nodePackages.markdownlint-cli
      marksman

      # Docker extra
      nodePackages.dockerfile-language-server-nodejs
      hadolint
      docker-compose-language-service

      # JSON and YAML extras
      nodePackages.vscode-json-languageserver
      nodePackages.yaml-language-server

      # Custom
      editorconfig-checker
      shellcheck
    ];

    extraLuaConfig = ''
         vim.g.mapleader = " "
         require("lazy").setup({
           spec = {
             { "LazyVim/LazyVim", import = "lazyvim.plugins" },
             -- import any extras modules here
             { import = "lazyvim.plugins.extras.dap.core" },
      { import = "lazyvim.plugins.extras.dap.nlua" },
             { import = "lazyvim.plugins.extras.ui.edgy" },
             { import = "lazyvim.plugins.extras.editor.aerial" },
             { import = "lazyvim.plugins.extras.editor.leap" },
             { import = "lazyvim.plugins.extras.editor.navic" },
             { import = "lazyvim.plugins.extras.lang.docker" },
             { import = "lazyvim.plugins.extras.lang.json" },
             { import = "lazyvim.plugins.extras.lang.markdown" },
             { import = "lazyvim.plugins.extras.lang.rust" },
             { import = "lazyvim.plugins.extras.lang.yaml" },
             { import = "lazyvim.plugins.extras.test.core" },
             { import = "lazyvim.plugins.extras.ui.mini-animate" },
             -- import/override with your plugins
             { import = "plugins" },
           },
           defaults = {
      lazy = false,
      version = false,
           },
           performance = {
             reset_packpath = false,
             rtp = {
                 reset = false,
               }
             },
           dev = {
             path = "${pkgs.vimUtils.packDir osConfig.home-manager.users.bcampbell.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
      patterns = {"folke", "nvim-telescope", "hrsh7th", "akinsho", "stevearc", "LazyVim", "catppuccin", "saadparwaiz1", "nvimdev", "rafamadriz", "lewis6991", "lukas-reineke", "nvim-lualine", "L3MON4D3", "williamboman", "echasnovski", "nvim-neo-tree", "MunifTanjim", "mfussenegger", "rcarriga", "neovim", "nvim-pack", "nvim-treesitter", "windwp", "JoosepAlviste", "nvim-tree", "nvim-lua", "RRethy", "dstein64", "Saecki", "ggandor", "iamcco", "nvim-neotest", "rouge8", "theHamsta", "SmiteshP", "jbyuki", "simrat39", "b0o", "tpope", "kosayoda" },
           },
           install = {
             -- Safeguard in case we forget to install a plugin with Nix
             missing = false,
           },
         })
    '';
  };
  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;
  };
}
