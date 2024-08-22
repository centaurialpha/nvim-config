local icons = {
  Array = " ",
  Boolean = " ",
  Class = " ",
  Codeium = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Copilot = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = " ",
  Key = " ",
  Keyword = " ",
  Method = " ",
  Module = " ",
  Namespace = " ",
  Null = " ",
  Number = " ",
  Object = " ",
  Operator = " ",
  Package = " ",
  Property = " ",
  Reference = " ",
  Snippet = " ",
  String = " ",
  Struct = " ",
  Text = " ",
  TypeParameter = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = "menu,menuone,noinsert" },
      mapping = cmp.mapping.preset.insert {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        -- Scroll the documentation window [b]ack / [f]orward
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ["<C-y>"] = cmp.mapping.confirm { select = true },
        -- If you prefer more traditional completion keymaps,
        -- you can uncomment the following lines
        --['<CR>'] = cmp.mapping.confirm { select = true },
        --['<Tab>'] = cmp.mapping.select_next_item(),
        --['<S-Tab>'] = cmp.mapping.select_prev_item(),


        -- Manually trigger a completion from nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ["<C-space>"] = cmp.mapping.complete {},

        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
      },
      sources = {
        {
          name = "lazydev",
          group_index = 0,
        },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      },
    }
    --require("luasnip.loaders.from_vscode").lazy_load()

    --local lspkind = require("lspkind")

    --local select_opts = { behavior = cmp.SelectBehavior.Select }

    --cmp.setup({
    --  completion = {
    --    completeopt = "menu,menuone,noinsert",
    --    -- autocomplete = false,
    --  },
    --  window = {
    --    documentation = false,
    --  },

    --  snippet = {
    --    expand = function(args)
    --      luasnip.lsp_expand(args.body)
    --    end,
    --  },
    --  formatting = {
    --    format = function(_, item)
    --      if icons[item.kind] then
    --        item.kind = icons[item.kind] .. item.kind
    --      end
    --      return item
    --    end,
    --  },
    --  mapping = {
    --    ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
    --    ["<Down>"] = cmp.mapping.select_next_item(select_opts),

    --    ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
    --    ["<C-n>"] = cmp.mapping.select_next_item(select_opts),

    --    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    --    ["<C-d>"] = cmp.mapping.scroll_docs(4),

    --    ["<C-e>"] = cmp.mapping.abort(),
    --    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    --    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    --    ["<C-f>"] = cmp.mapping(function(fallback)
    --      if luasnip.jumpable(1) then
    --        luasnip.jump(1)
    --      else
    --        fallback()
    --      end
    --    end, { "i", "s" }),

    --    ["<C-b>"] = cmp.mapping(function(fallback)
    --      if luasnip.jumpable(-1) then
    --        luasnip.jump(-1)
    --      else
    --        fallback()
    --      end
    --    end, { "i", "s" }),

    --    ["<Tab>"] = cmp.mapping(function(fallback)
    --      local col = vim.fn.col(".") - 1

    --      if cmp.visible() then
    --        cmp.select_next_item(select_opts)
    --      elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    --        fallback()
    --      else
    --        cmp.complete()
    --      end
    --    end, { "i", "s" }),

    --    ["<S-Tab>"] = cmp.mapping(function(fallback)
    --      if cmp.visible() then
    --        cmp.select_prev_item(select_opts)
    --      else
    --        fallback()
    --      end
    --    end, { "i", "s" }),
    --  },
    --})
  end,
}
