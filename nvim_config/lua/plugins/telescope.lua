return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end
        },
        {'nvim-telescope/telescope-ui-select.nvim' },
        {'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
        require('telescope').setup{
            defaults = {
                mappings = {
                    i = {
                        ['<C-k>'] = require('telescope.actions').move_selection_previous,
                        ['<C-j>'] = require('telescope.actions').move_selection_next,
                        ['<C-l>'] = require('telescope.actions').select_default,
                    },
                },
            },
            pickers = {
                find_files = {
                    file_ignore_patterns = {'node_modules', '.git', '.venv'},
                    hidden = true,
                },
            },
            live_grep = {
                    file_ignore_patterns = {'node_modules', '.git', '.venv'},
                additional_args = function(_)
                    return {'--hidden' }
                end,
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        }
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
        pcall(require('telescope').load_extension, 'find_files')

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>ss', builtin.help_tags, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        -- vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })
        vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open files'
            }
        end, {desc = '[S]earch [/] in Open Files' })
        vim.keymap.set('n', '<leader>sds', function()
            builtin.lsp_document_symbols {
                symbols = {'Class', 'Function', 'Method', 'Constructor', 'Interface', 'Module', 'Property'},
            }
        end, {desc = '[S]earch LSP document for [S]ymbols'})
        vim.keymap.set('n', '<leader>gf', builtin.git_files, {desc = 'Search [G]it [F]iles'})
        vim.keymap.set('n', '<leader>gc', builtin.git_commits, {desc = 'Search [G]it [C]ommits'})
        -- vim.keymap.set('n', '<leader>gcf', builtin.git_bcommits, {desc = 'Search [G]it [C]ommits for current [F]ile' })
        vim.keymap.set('n', '<leader>gb', builtin.git_branches, {desc = 'Search [G]it [B]ranches' })
        vim.keymap.set('n', '<leader>gs', builtin.git_status, {desc = 'Search [G]it [S]tatus' })
    end,
}
