local neorg_dir = vim.fn.expand("~") .. "/brain/"

require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          brain = neorg_dir,
        },
        default_workspace = "brain",
      },
    },
    ["core.export"] = {},
    ["external.templates"] = {
      config = {
        templates_dir = vim.fn.stdpath("config") .. "/templates/norg",
        keywords = {
          NOW = function()
            return require("luasnip").text_node(os.date("%Y-%m-%dT%H:%M:%S"))
          end,
        },
      },
    },
  },
})

local group = vim.api.nvim_create_augroup("NeorgLoadTemplateGroup", { clear = true })

local is_buffer_empty = function(buffer)
  local content = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
  return not (#content > 1 or content[1] ~= "")
end

local callback = function(args)
  vim.schedule(function()
    if not is_buffer_empty(args.buf) then
      return
    end

    if string.find(args.file, "/journal/") then
      vim.api.nvim_cmd({ cmd = "Neorg", args = { "templates", "fload", "journal" } }, {})
    else
      vim.api.nvim_cmd({ cmd = "Neorg", args = { "inject-metadata" } }, {})
    end
  end)
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufNew" }, {
  desc = "Load template on new norg files",
  pattern = "*.norg",
  callback = callback,
  group = group,
})
