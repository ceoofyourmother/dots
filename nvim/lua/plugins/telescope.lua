return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
   cmd = "Telescope",
   keys = {
	{
            "<leader><space>",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "Find files"
        },
	{
	    "<leader>gf",
	    function ()
		    require("telescope.builtin").git_files()
	    end,
	    desc = "Find git files"
	},
	{
		"<leader>ss", 
		function ()
			require("telescope.builtin").grep_string({search = vim.fn.input("o que procuras? >")});	
	end,
	},
	}
}
