local p = require('warpcode.utils.keymap-actions')

return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    event = 'VeryLazy',
    dependencies = {
      -- {
      --   'zbirenbaum/copilot.lua',
      -- }, -- or github/copilot.vim
      {
        'github/copilot.vim',
        event = 'InsertEnter',
        lazy = false,
        autoStart = true,
        config = function()
          -- Work has a paid sub, but my personal account doesn't
          -- Only enable auto suggestions for the paid account
          vim.g.copilot_enabled = os.getenv('IS_WORK') == '1'

          -- Use 'node' from the system's PATH, assuming it's correctly set up
          -- via nvm or a system package manager.
          vim.g.copilot_node_command = 'node'

          vim.g.copilot_workspace_folders = { '~/src', '/workdir' }

          --Remove default mappings
          -- vim.g.copilot_no_tab_map = true

          -- vim.keymap.set('i', '<C-Tab>', 'copilot#Accept("\\<CR>")', {
          --   expr = true,
          --   replace_keycodes = false
          -- })

          -- when is work, add /src to the workspace folders
          p.addCall('ai.previous', function()
            vim.fn['copilot#Previous']()
          end)
          p.addCall('ai.next', function()
            vim.fn['copilot#Next']()
          end)
          p.addCall('ai.suggest', function()
            vim.fn['copilot#Suggest']()
          end)
          p.addCall('ai.suggest_dismiss', function()
            vim.fn['copilot#Dismiss']()
          end)
          p.addCall('ai.accept', function()
            vim.fn['copilot#Accept']()
          end)
          p.addCall('ai.accept_line', function()
            vim.fn['copilot#AcceptLine']()
          end)
          -- p.addCall('ai.chat', function() vim.cmd [[execute "insert \<Plug>(copilot-previous)"]] end)

          -- vim.cmd [[execute "insert \<Plug>delimitMateCR"]]
          vim.keymap.set('i', '<leader>sa', '<Plug>(copilot-suggest)')
          vim.keymap.set('i', '[[', '<Plug>(copilot-previous)')
          vim.keymap.set('i', ']]', '<Plug>(copilot-next)')
          vim.keymap.set('i', '<C-h>', '<Plug>(copilot-dismiss)')
          vim.keymap.set('i', '<C-;>', '<Plug>(copilot-accept-line)')

          local group = vim.api.nvim_create_augroup('warpcode-workkspace-folder', { clear = true })
          vim.api.nvim_create_autocmd({ 'BufEnter' }, {
            desc = 'When entering a buffer, set the workspace folder',
            group = group,
            callback = function()
              local util = require('lspconfig.util')
              vim.b.workspace_folder = vim.fs.dirname(vim.fs.find('.git', { path = vim.fn.getcwd(), upward = true })[1])
            end,
          })
        end,
      },
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = {
      chat_autocomplete = false,
      question_header = '## User ',
      answer_header = '## Copilot ',
      error_header = '## Error ',
      context = 'buffers',
      -- prompts = {
      --   -- Code related prompts
      --   Explain = 'Please explain how the following code works.',
      --   Review = 'Please review the following code and provide suggestions for improvement.',
      --   Tests = 'Please explain how the selected code works, then generate unit tests for it.',
      --   Refactor = 'Please refactor the following code to improve its clarity and readability.',
      --   FixCode = 'Please fix the following code to make it work as intended.',
      --   FixError = 'Please explain the error in the following text and provide a solution.',
      --   BetterNamings = 'Please provide better names for the following variables and functions.',
      --   Documentation = 'Please provide documentation for the following code.',
      --   SwaggerApiDocs = 'Please provide documentation for the following API using Swagger.',
      --   SwaggerJsDocs = 'Please write JSDoc for the following API using Swagger.',
      --   -- Text related prompts
      --   Summarize = 'Please summarize the following text.',
      --   Spelling = 'Please correct any grammar and spelling errors in the following text.',
      --   Wording = 'Please improve the grammar and wording of the following text.',
      --   Concise = 'Please rewrite the following text to make it more concise.',
      -- },
      auto_follow_cursor = false, -- Don't follow the cursor after getting response
      show_help = false, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
      mappings = {
        -- Use tab for completion
        complete = {
          detail = 'Use @<Tab> or /<Tab> for options.',
          insert = '<Tab>',
        },
        -- Close the chat
        close = {
          normal = 'q',
          insert = '<C-c>',
        },
        -- Reset the chat buffer
        reset = {
          normal = '<C-x>',
          insert = '<C-x>',
        },
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = '<CR>',
          insert = '<C-CR>',
        },
        -- Accept the diff
        accept_diff = {
          normal = '<C-y>',
          insert = '<C-y>',
        },
        -- Yank the diff in the response to register
        yank_diff = {
          normal = 'gmy',
        },
        -- Show the diff
        show_diff = {
          normal = 'gmd',
        },
        -- Show the prompt
        show_info = {
          normal = 'gmp',
        },
        -- Show the user selection
        show_context = {
          normal = 'gms',
        },
        -- Show help
        show_help = {
          normal = 'gmh',
        },
      },
    },
    config = function(_, opts)
      local chat = require('CopilotChat')
      local select = require('CopilotChat.select')
      -- Use unnamed register for the selection
      -- opts.selection = select.unnamed
      --
      -- -- Override the git prompts message
      -- opts.prompts.Commit = {
      --   prompt = 'Write commit message for the change with commitizen convention',
      --   selection = select.gitdiff,
      -- }
      -- opts.prompts.CommitStaged = {
      --   prompt = 'Write commit message for the change with commitizen convention',
      --   selection = function(source)
      --     return select.gitdiff(source, true)
      --   end,
      -- }
      --
      -- opts.system_prompt = require('CopilotChat.config.prompts').COPILOT_INSTRUCTIONS

      chat.setup(opts)
      -- Setup the CMP integration
      -- require('CopilotChat.integrations.cmp').setup()

      vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = '*', range = true })

      -- Inline chat with Copilot
      vim.api.nvim_create_user_command('CopilotChatInline', function(args)
        chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = 'float',
            relative = 'cursor',
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = '*', range = true })

      -- Restore CopilotChatBuffer
      vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = '*', range = true })

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          -- local ft = vim.bo.filetype
          -- if ft == 'copilot-chat' then
          --   vim.bo.filetype = 'markdown'
          -- end
        end,
      })
    end,
    keys = {
      -- Show help actions with telescope
      {
        '<leader>ah',
        function()
          require('CopilotChat').select_prompt()
          -- local actions = require('CopilotChat.actions')
          -- require('CopilotChat.integrations.telescope').pick(actions.help_actions())
        end,
        desc = 'CopilotChat - Help actions',
      },
      -- Show prompts actions with telescope
      {
        '<leader>ap',
        function()
          require('CopilotChat').select_prompt()
          -- local actions = require('CopilotChat.actions')
          -- require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = 'CopilotChat - Prompt actions',
      },
      {
        '<leader>ap',
        ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
        mode = 'x',
        desc = 'CopilotChat - Prompt actions',
      },
      -- Code related commands
      { '<leader>ae', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
      { '<leader>at', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
      { '<leader>ar', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
      { '<leader>aR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
      { '<leader>an', '<cmd>CopilotChatBetterNamings<cr>', desc = 'CopilotChat - Better Naming' },
      -- Chat with Copilot in visual mode
      {
        '<leader>av',
        ':CopilotChatVisual',
        mode = 'x',
        desc = 'CopilotChat - Open in vertical split',
      },
      {
        '<leader>ax',
        ':CopilotChatInline<cr>',
        mode = 'x',
        desc = 'CopilotChat - Inline chat',
      },
      -- Custom input for CopilotChat
      {
        '<leader>ai',
        function()
          local input = vim.fn.input('Ask Copilot: ')
          if input ~= '' then
            vim.cmd.CopilotChat(input)
          end
        end,
        desc = 'CopilotChat - Ask input',
      },
      -- Generate commit message based on the git diff
      {
        '<leader>am',
        '<cmd>CopilotChatCommit<cr>',
        desc = 'CopilotChat - Generate commit message for all changes',
      },
      {
        '<leader>aM',
        '<cmd>CopilotChatCommitStaged<cr>',
        desc = 'CopilotChat - Generate commit message for staged changes',
      },
      -- Quick chat with Copilot
      {
        '<leader>aq',
        function()
          local input = vim.fn.input('Quick Chat: ')
          if input ~= '' then
            vim.cmd.CopilotChatBuffer(input)
          end
        end,
        desc = 'CopilotChat - Quick chat',
      },
      -- Debug
      { '<leader>ad', '<cmd>CopilotChatDebugInfo<cr>', desc = 'CopilotChat - Debug Info' },
      -- Fix the issue with diagnostic
      { '<leader>af', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
      -- Clear buffer and chat history
      { '<leader>al', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
      -- Toggle Copilot Chat Vsplit
      { '<leader>av', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },
      -- Copilot Chat Models
      { '<leader>a?', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
    },
    -- build = 'make tiktoken', -- Only on MacOS or Linux
  },
}
