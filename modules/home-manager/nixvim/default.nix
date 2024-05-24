{ inputs, ... }:
{
  imports = [ # Nixvim module import
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    enableMan = true;

    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };

    opts = {
      updatetime = 100;
      number = true;
      fileencoding = "utf-8";
      shiftwidth = 2;
    };

    globals.mapleader = " ";
    clipboard.register = "unnamedplus";

    # Lazy load
    plugins.lazy = {
      enable = true;
    };

    # LSP/languages
    plugins.lsp = {
      enable = true;
      servers = {
	tsserver.enable = true;
	lua-ls.enable = true;
	rust-analyzer.enable = true;
	nixd.enable = true;
      };
    };
    plugins.lsp-lines.enable = true;
    plugins.lsp-format.enable = true;
    plugins.nix.enable = true;

    # Flash
    plugins.flash = {
      enable = true;
    };

    # Airline
    plugins.airline = {
      enable = true;
      settings = {
        symbols =   {
          branch = "";
          colnr = " ℅:";
          readonly = "";
          linenr = " :";
          maxlinenr = "☰ ";
          dirty= "⚡";
        };
      };
    };

    # Neoscroll
    plugins.neoscroll = {
      enable = true;
      settings = {
        cursor_scrolls_alone = true;
        easing_function = "quadratic";
        hide_cursor = true;
        mappings = [
          "<C-u>"
          "<C-d>"
          "<C-b>"
          "<C-f>"
          "<C-y>"
          "<C-e>"
          "zt"
          "zz"
          "zb"
        ];
        respect_scrolloff = false;
        stop_eof = true;
      };
    };

    # Syntax
    plugins.autoclose.enable = true;
    plugins.telescope.enable = true;
    plugins.chadtree = {
      enable = true;
      theme = {
        iconColourSet = "github";
        iconGlyphSet = "devicons";
        textColourSet = "nord";
      };
    };
    plugins.yanky.enable = true;
    plugins.comment.enable = true;
    plugins.cursorline.enable = true;

    # Dashboard
    plugins.dashboard = {
      enable = true;
    };

    plugins.intellitab.enable = true;

    # Mini
    plugins.mini = {
      enable = true;
      modules = {
        animate = {};
      };
    };

    # Which-key
    plugins.which-key = {
      enable = true;
      triggersNoWait = [
        " "
        "`"
        "'"
        "g'"
        "\""
        "z="
      ];
    };

    #Snippets
    plugins.luasnip.enable = true;
    plugins.friendly-snippets.enable = true;

    # CMP plugins
    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp_yanky.enable = true;
    plugins.cmp = {
      enable = true;
      extraOptions.mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };
      extraOptions.sources = [
        {
          name = "nvim_lsp";
        }
        {
          name = "luasnip";
        }
        {
          name = "path";
        }
        {
          name = "buffer";
        }
      ];
    };
    plugins.bufferline = {
      enable = true;
    };
    plugins.treesitter = {
      enable = true;
      indent = true;
    };
    keymaps = [
      {
        key = ";";
        action = ":";
      }
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>qa<cr>";
        options.desc = "Quit All";
      }
      {
        mode = "n";
        key = "<C-s>";
        action = "<cmd>w<cr>";
        options.desc = "Save Buffer";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>CHADopen<cr>";
        options.desc = "Open CHAD tree";
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.remap = true;
        options.desc = "Go to Left Window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.remap = true;
        options.desc = "Go to Lower Window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.remap = true;
        options.desc = "Go to Upper Window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.remap = true;
        options.desc = "Go to Right Window";
      }
      {
        mode = "n";
        key = "<C-Up>";
        action = "<cmd>resize +2<cr>";
        options.desc = "Increase Window Height";
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = "<cmd>resize -2<cr>";
        options.desc = "Decrease Window Height";
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = "<cmd>vertical resize +2<cr>";
        options.desc = "Increase Window Width";
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = "<cmd>vertical resize -2<cr>";
        options.desc = "Decrease Window Width";
      }
      {
        mode = "n";
        key = "<A-j>";
        action = "<cmd>m .+1<cr>==";
        options.desc = "Move Down";
      }
      {
        mode = "n";
        key = "<A-k>";
        action = "<cmd>m .-2<cr>==";
        options.desc = "Move Up";
      }
      {
        mode = "i";
        key = "<A-j>";
        action = "<esc><cmd>m .+1<cr>==gi";
        options.desc = "Move Down";
      }
      {
        mode = "i";
        key = "<A-k>";
        action = "<esc><cmd>m .-2<cr>==gi";
        options.desc = "Move Up";
      }
      {
        mode = "v";
        key = "<A-j>";
        action = ":m '>+1<cr>gv=gv";
        options.desc = "Move Down";
      }
      {
        mode = "v";
        key = "<A-k>";
        action = ":m '<-2<cr>gv=gv";
        options.desc = "Move Up";
      }
      {
        mode = "i";
        key = "<Tab>";
        action = "<CMD>lua require(\"intellitab\").indent()<CR>";
        options.noremap = true;
      }
      {
        mode = ["n" "x" "o"];
        key = "s";
        action = "function() require(\"flash\").jump() end";
        lua = true;
        options.desc = "Flash";
      }
      {
        mode = ["n" "x" "o"];
        key = "S";
        action = "function() require(\"flash\").treesitter() end";
        lua = true;
        options.desc = "Flash Treesitter";
      }
      {
        mode = ["o"];
        key = "r";
        action = "function() require(\"flash\").remote() end";
        lua = true;
        options.desc = "Remote Flash";
      }
      {
        mode = ["o"];
        key = "R";
        action = "function() require(\"flash\").treesitter_search() end";
        lua = true;
        options.desc = "Treesitter Remote Flash";
      }
    ];
  };
}
