return {
    'neovim/nvim-lspconfig',
    dependencies = {
        {'williamboman/mason.nvim', config = true},
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function ()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('pearl-lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, {buffer = event.buf, desc = 'LSP: ' .. desc})
                end

		        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
		        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
		        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
		        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
		        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
		        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
		        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
		        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', {'n', 'x'})
		        map('K', vim.lsp.buf.hover, 'Hover Documentation')
		        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
		        map('<leader>lsh', vim.lsp.buf.signature_help, '[S]ignature [H]elp')


		        local client = vim.lsp.get_client_by_id(event.data.client_id)
		        if client and client.server_capabilities.documentHighlightProvider then
		            local highlight_augroup = vim.api.nvim_create_augroup('pearl-lsp-highlight', { clear = false } )
		            vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
		            })
		            vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
		            })
		            vim.api.nvim_create_autocmd('LspDetach', {
		                group = vim.api.nvim_create_augroup('pearl-lsp-detach', { clear = true }),
		                callback = function(event2)
		                    vim.lsp.buf.clear_references()
		                    vim.api.nvim_clear_autocmds { group = 'pearl-lsp-highlight', buffer = event2.buf }
		                end,
		            })
		        end
            end,
            })
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

	local servers = {
		clangd = {},
		pyright = {},
		cmake = {},
		bashls = {},
		--texlab = {
		--        settings = {
		--            filetypes = {'tex'}
		--        }
		--    },

		lua_ls = {
            settings = {
                Lua = {
                    completion = {callSnippet = 'Replace',},
                    runtime = { version = 'LuaJIT', },
                    diagnostics = { disable = { 'missing=fields' }, globals = {'vim'} },
                    format = { enable = false, },
                },
            },
		},
		gopls = {},

	}
    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {'stylua', 'prettier'})
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }
    require('mason-lspconfig').setup {
        automatic_enable = false,
        handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                require('lspconfig')[server_name].setup(server)
            end,
        },
    }
    end,
}
