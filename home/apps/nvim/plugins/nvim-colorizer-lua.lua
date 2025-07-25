require('colorizer').setup({
  -- A list of filetypes to automatically attach to
  filetypes = { 'css', 'javascript', 'html', 'lua', 'python', 'nix'},

  -- The default options for the attach_to_buffer command
  user_default_options = {
    mode = 'background', -- 'background' or 'virtualtext'
    
    -- Other options for more control
    -- css = true,
    -- tailwind = true,
  }
})
