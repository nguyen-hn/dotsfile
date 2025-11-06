return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {
                {
                    'L3MON4D3/LuaSnip',
                    build = (function()
                        return 'make install_jsregexp'
                    end)(),
                    dependencies = {
                        {
                            'rafamadriz/friendly-snippets',
                            config = function()
                                require('luasnip.loaders.from_vscode').lazy_load({ paths = "~/.config/nvim/my_snippets" })
                            end,
                        },
                    },
                },
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
            },
        },
        config = function ()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            local select_opts = { behavior = cmp.SelectBehavior.Select }
            luasnip.config.setup {}
            local kind_icons = {
                Text = '󰉿',
                Method = 'm',
                Function = '󰊕',
                Constructor = '',
                Field = '',
                Variable = '󰆧',
                Class = '󰌗',
                Interface = '',
                Module = '',
                Property = '',
                Unit = '',
                Value = '󰎠',
                Enum = '',
                Keyword = '󰌋',
                Snippet = '',
                Color = '󰏘',
                File = '󰈙',
                Reference = '',
                Folder = '󰉋',
                EnumMember = '',
                Constant = '󰇽',
                Struct = '',
                Event = '',
                Operator = '󰆕',
                TypeParameter = '󰊄',
            }

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                completion = { completeopt = 'menu,menuone,noinsert' },
                mapping = cmp.mapping.preset.insert {
                    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
                    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-y>'] = cmp.mapping.confirm { select = true },
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({select = true}),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' } ),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' } ),
                    ['<C-Space>'] = cmp.mapping.complete {},
                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumable() then
                            luasnip.expand_or_jump()
                        end
                    end, {'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumable(-1) then
                            luasnip.jump(-1)
                        end
                    end, {'i', 's' }),
                },
                sources = {
                    {
                        name = 'lazydev',
                        group_index = 0,
                    },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' }
                },
                formatting = {
                    fields = { 'kind', 'abbr', 'menu'},
                    format = function (entry, vim_item)
                        vim_item.kind = string.format('%s', kind_icons[vim_item])
                        vim_item.menu = ({
                            nvim_lsp = '[LSP]',
                            luasnip = '[Snippet]',
                            buffer = '[Buffer]',
                            path = '[Path]',
                        })[entry.source.name]
                        return vim_item
                    end,
                },
            }
        end
    },
    {
        "Exafunction/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({
            })
        end
    }
}
