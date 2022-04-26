local cmp = require("cmp")
local lspkind = require("lspkind")

--   פּ ﯟ   some other good icons
local kind_icons = {
Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

cmp.setup {
    -- 片段补全
    snippet = {
    -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    completion = {
        ---@usage The minimum length of a word to complete on.
        keyword_length = 2,
    },
    -- 补全菜单排序
    sorting = {
        comparators = {
            -- The built-in comparators:
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.offset,
            cmp.config.compare.score,
            cmp.config.compare.length,
            cmp.config.compare.order,
            cmp.config.compare.exact,
            cmp.config.compare.sort_text,
        },
    },
    mapping = cmp.mapping.preset.insert (
    {
        ["<UP>"] = cmp.mapping.select_prev_item(),
        ["<DOWN>"] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            before = function (entry, vim_item)
                -- Get the full snippet (and only keep first line)
                vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                vim_item.menu = ({
                    buffer = "[Buffer]",
                    vsnip = "[Snippet]",
                    nvim_lsp = "[LSP]",
                    path = "[Path]",
                })[entry.source.name]

                return vim_item   
            end,
        })
    },
    sources = {
        { name = "buffer" },
        { name = "vsnip" },
        { name = "nvim_lsp" },
        { name = "path" },
    },
    flags = {
        debounce_text_changes = 150,
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = false,
    },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
    {
        { name = 'cmdline' , keyword_length = 2}
    },
    {
        { name = 'path' }
    }),
    sorting = {
        comparators = {
            -- The built-in comparators:
            cmp.config.compare.recently_used,
            cmp.config.compare.offset,
            cmp.config.compare.score,
            cmp.config.compare.length,
            cmp.config.compare.order,
            cmp.config.compare.exact,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
        },
    },
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig').clangd.setup {
    cmd = {
        'clangd',
        '--header-insertion=never',
        '--clang-tidy',
        '--completion-style=bundled',
        '--pretty',
        '--background-index'
    },
    capabilities = capabilities
}
require('lspconfig').jedi_language_server.setup {
    capabilities = capabilities
}
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--     properties = { "documentation", "detail", "additionalTextEdits" },
-- }
-- local signature_config = {
--     log_path = "C:/Users/lizhh/tmp/sig.log",
--     debug = true,
--     hint_enable = false,
--     handler_opts = { border = "single" },
--     max_width = 80,
-- }
-- require("lsp_signature").setup(signature_config)
-- -- clangd, jedi函数显示参数窗口
-- require("lspconfig").clangd.setup({ capabilities = capabilities })
-- require("lspconfig").jedi_language_server.setup({ capabilities = capabilities })
