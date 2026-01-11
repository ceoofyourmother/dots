return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "saghen/blink.cmp",
            "SmiteshP/nvim-navic",
        },
        opts = {
            diagnostics = {
                virtual_text = true,
                signs = false,
                underline = true,
                update_in_insert = false,
            },
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = { callSnippet = "Replace" },
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                            },
                        },
                    },
                },

                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            diagnostics = {
                                disabled = { "unresolved-proc-macro" },
                            },
                            cargo = {
                                allFeatures = true,
                            },
                            checkOnSave = {
                                command = "clippy",
                                extraArgs = { "--no-deps" },
                            },
                            imports = {
                                granularity = {
                                    group = "item",
                                },
                            },
                        },
                    },
                },

                tsserver = {}, -- TypeScript / JavaScript
            },
        },

        config = function(_, opts)
            local navic = function(client, buf)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, buf)
                end
            end

            local on_attach = function(client, buf)
                navic(client, buf)

                local map = vim.keymap.set
                map("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Goto Definition" })
                -- map("n", "K", vim.lsp.buf.hover, { buffer = buf })
                -- map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buf })
            end

            vim.diagnostic.config(opts.diagnostics)

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- Defaults para TODOS os LSPs
            vim.lsp.config("*", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            for server, server_opts in pairs(opts.servers) do
                server_opts.capabilities = vim.tbl_deep_extend(
                    "force",
                    capabilities,
                    server_opts.capabilities or {}
                )

                local user_on_attach = server_opts.on_attach
                server_opts.on_attach = function(client, buf)
                    on_attach(client, buf)
                    if user_on_attach then
                        user_on_attach(client, buf)
                    end
                end

                require("lspconfig")[server].setup(server_opts)
            end
        end,
    },

    {
        "j-hui/fidget.nvim",
        event = "BufReadPre",
        config = function()
            require("fidget").setup({})
        end,
    },
}

