local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
        "--depth",
        "1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim", tag = "v0.1.3" }) -- Useful lua functions used by lots of plugins
	use({ "windwp/nvim-autopairs", commit = "ae5b41c" }) -- Autopairs, integrates with both cmp and treesitter

    -- comment
	use({ "numToStr/Comment.nvim", tag = "v0.8.0" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "e9062e2" })

    use({ "nvim-tree/nvim-web-devicons", commit = "eb8f80f" })
	use({ "nvim-tree/nvim-tree.lua", commit = "904f95c" })

    -- buffer line
	use({ "akinsho/bufferline.nvim", tag = "v4.3.0" })
    -- status line
	use({ "nvim-lualine/lualine.nvim", commit = "45e27ca" })

	use({ "akinsho/toggleterm.nvim", tag = "v2.7.1" })

	use({ "lukas-reineke/indent-blankline.nvim", tag = "v2.20.7" })
	-- use({ "goolord/alpha-nvim", commit = "e4fcte2" })
    use({ "folke/which-key.nvim", tag = "v1.5.1" })

    -- close buffer without messing up window arrangement
	use({ "moll/vim-bbye", commit = "v1.0.1" })

	-- Colorschemes
	use({ "folke/tokyonight.nvim", tag = "v1.*" })
	use({ "lunarvim/darkplus.nvim" })

	-- Cmp
	use({ "hrsh7th/nvim-cmp", commit = "c4e491a" }) -- The completion plugin
	-- use({ "hrsh7th/cmp-buffer", commit = "" }) -- buffer completions
	-- use({ "hrsh7th/cmp-path", commit = "" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "3cf38d9c957e95c397b66f91967758b31be4abe6" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" }) -- a bunch of snippets to use

	-- LSP
	use({ "neovim/nvim-lspconfig", tag = "*" }) -- enable LSP
	use({ "williamboman/mason.nvim", tag = "v1.*" }) -- simple to use language server installer
	use({ "williamboman/mason-lspconfig.nvim", tag = "v1.*" })
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "db09b6c" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate", commit = "5ed1758" })

    use({"github/copilot.vim", tag = "*"})

	-- use({ "simrat39/rust-tools.nvim" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", tag = "*" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.9.0",
	})

	-- Git
	use({ "lewis6991/gitsigns.nvim", tag = "*" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
