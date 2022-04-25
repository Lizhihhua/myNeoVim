local cmp = require("cmp")
local types = require("cmp.types")
local str = require("cmp.utils.str")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

luasnip.config.setup({
    region_check_events = "CursorMoved",
    delete_check_events = "TextChanged",
})

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
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
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
            -- with_text = false,
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function (entry, vim_item)
                -- Get the full snippet (and only keep first line)
                vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                local word = entry:get_insert_text()
                if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
                    word = vim.lsp.util.parse_snippet(word)
                end
                    word = str.oneline(word)
                if
                    entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
                    and string.sub(vim_item.abbr, -1, -1) == "~"
                then
                    word = word .. "~"
                end
                vim_item.abbr = word
                vim_item.menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    path = "[Path]",
                })[entry.source.name]

                return vim_item   
            end,
        })
        -- fields = { "kind", "abbr", "menu" },
        -- format = function(entry, vim_item)
        -- -- Kind icons
        --     vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        -- -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        --     vim_item.menu = ({
        --         buffer = "[Buffer]",
        --         nvim_lsp = "[LSP]",
        --         path = "[Path]",
        --     })[entry.source.name]
        --     return vim_item
        -- end,
    },
    sources = {
        { name = "buffer" ,  keyword_length = 2 },
        { name = "nvim_lsp", keyword_length = 2 },
        { name = "luasnip", keyword_length = 2 },
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
