if isdirectory(expand('~/.vim/bundle/telescope.nvim'))

lua << EOF
  local actions = require('telescope.actions')
  local previewers = require('telescope.previewers')
-- 禁用以下檔案的預覽 
  local _bad = { '.*%.csv', '.*%.lua' } -- 將不要預覽的檔案類型放入此處
  local bad_files = function(filepath)
    for _, v in ipairs(_bad) do
      if filepath:match(v) then
        return false
      end
    end

    return true
  end

  local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}
    if opts.use_ft_detect == nil then opts.use_ft_detect = true end
    opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
    previewers.buffer_previewer_maker(filepath, bufnr, opts)
  end



  require('telescope').setup{
    defaults = {
      layout_config = {
          vertical = { width = 0.8 },
        },
      buffer_previewer_maker = new_maker,
      mappings = {
          i = {
              ["<esc>"] = actions.close
            },
        },
    },
  pickers = {
      find_files = {
        prompt = "Find Files: ",
        preview_maker = new_maker,
        theme = "dropdown",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      },
      flutter = {},
    },
  }
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('flutter')

EOF




  " Find files using Telescope command-line sugar.
  nnoremap <space>f     <cmd>Telescope find_files<cr>
  nnoremap <space>r     <cmd>Telescope live_grep<cr>
  nnoremap <space>rb    <cmd>Telescope current_buffer_fuzzy_find<cr>
  nnoremap <space>rs    <cmd>Telescope grep_string<cr>
  nnoremap <space>ft    <cmd>Telescope treesitter<cr>
  nnoremap <space>fb    <cmd>Telescope buffers<cr>
  nnoremap <space>fh    <cmd>Telescope help_tags<cr>
  nnoremap <space>fe    <cmd>Telescope file_browser<cr>
  nnoremap <space>a     <cmd>Telescope lsp_workspace_diagnostics<cr>
  nnoremap <space>fc    <cmd>Telescope flutter commands<cr>
  nnoremap <space>c     <cmd>Telescope commands<cr>


endif
