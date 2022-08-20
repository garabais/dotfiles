-- require('lualine').setup {
--   options = {
--     icons_enabled = true,
--     theme = 'nord',
--     component_separators = { left = '', right = ''},
--     section_separators = { left = '', right = ''},
--     disabled_filetypes = {},
--     always_divide_middle = true,
--     globalstatus = false,
--   },
--   sections = {
--     lualine_a = {'mode'},
--     lualine_b = {'filename'},
--     lualine_c = {'diagnostics'},
--     lualine_x = {'encoding', 'fileformat'},
--     lualine_y = {'diff', 'branch'},
--     lualine_z = {'location'}
--   },
--   inactive_sections = {
--     lualine_a = {},
--     lualine_b = {},
--     lualine_c = {'filename'},
--     lualine_x = {'location'},
--     lualine_y = {},
--     lualine_z = {}
--   },
--   tabline = {},
--   extensions = {}
-- }

local gl = require('galaxyline')

local nord = {
	'#2E3440',
	'#3B4252',
	'#434C5E',
	'#4C566A',
	'#D8DEE9',
	'#E5E9F0',
	'#ECEFF4',
	'#8FBCBB',
	'#88C0D0',
	'#81A1C1',
	'#5E81AC',
	'#BF616A',
	'#D08770',
	'#EBCB8B',
	'#A3BE8C',
	'#B48EAD',
}

local colors = {
	black = nord[2],      -- nord01
	white = nord[6],      -- nord05
	dark_bg = nord[2],    -- nord01
	light_bg = nord[4],   -- nord03
	blue = nord[9],       -- nord08
	green = nord[15],     -- nord14
	magenta = nord[16],   -- nord15
	orange = nord[13],    -- nord12
	red = nord[12],       -- nord11
	yellow = nord[14],    -- nord13
	teal = nord[8],       -- nord07
	grey = nord[5],       -- nord04
	dark_blue = nord[11], -- nord10
	light_grey = '#aab2bf',
}

local condition = require('galaxyline.condition')
local gls = gl.section


gls.left[1] = {
	ViMode = {
		provider = function()
			-- auto change color according the vim mode

			local mode_color = {
				n = colors.blue,
				i = colors.green,
				v = colors.magenta,
				[''] = colors.magenta,
				V = colors.magenta,
				c = colors.magenta,
				no = colors.blue,
				s = colors.orange,
				S = colors.orange,
				[''] = colors.orange,
				ic = colors.yellow,
				R = colors.red,
				Rv = colors.red,
				cv = colors.blue,
				ce = colors.blue,
				r = colors.teal,
				rm = colors.teal,
				['r?'] = colors.teal,
				['!'] = colors.blue,
				t = colors.blue
			}

			local alias = {
					  n = 'NORMAL',
					  i = 'INSERT',
					  c = 'COMMAND',
					  V = 'VISUAL',
					  [''] = 'VISUAL',
					  v ='VISUAL',
					  ['r?'] = ':CONFIRM',
					  rm = '--MORE',
					  R  = 'REPLACE',
					  Rv = 'VIRTUAL',
					  s  = 'SELECT',
					  S  = 'SELECT',
					  ['r']  = 'HIT-ENTER',
					  [''] = 'SELECT',
					  t  = 'TERMINAL',
					  ['!']  = 'SHELL',
				  }

		
			local vim_mode = vim.fn.mode()

			-- vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim_mode])
			vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color[vim_mode])

			return '  ' .. alias[vim_mode] .. ' '

		end,
		highlight = {colors.black, colors.dark_bg}
	}
}

gls.left[2] = {
    FileIcon = {
        provider = {function() return '  ' end, 'FileIcon'},
        condition = buffer_not_empty,
        highlight = {
            require('galaxyline.providers.fileinfo').get_file_icon,
            colors.light_bg
        }
    }
}
		
gls.left[3] = {
    FileName = {
        provider = function()
			local file = vim.fn.expand('%:t')
			if vim.bo.readonly then return file .. '  ' end
			if vim.bo.modifiable and vim.bo.modified then
					vim.api.nvim_command('hi GalaxyFileName guifg=' .. colors.light_grey)
			end
			return file .. ' '
		end,
        condition = buffer_not_empty,
		highlight = {colors.white, colors.light_bg},
		separator = ' ',
        separator_highlight = {colors.light_bg, colors.dark_bg}
    }
}

gls.left[4] = {
    DiagnosticError = {
		provider = 'DiagnosticError',
		icon = ' ',
		highlight = {colors.red, colors.dark_bg}
	}
}

gls.left[5] = {
	DiagnosticWarn = {
		provider = 'DiagnosticWarn',
		icon = ' ',
		highlight = {colors.yellow, colors.dark_bg}
	}
}

gls.left[6] = {
    DiagnosticHint = {
		provider = 'DiagnosticHint',
		icon = ' ',
		highlight = {colors.dark_blue, colors.dark_bg}
	}
}

gls.left[7] = {
    DiagnosticInfo = {
		provider = 'DiagnosticInfo',
		icon = ' ',
		highlight = {colors.blue, colors.dark_bg}
	}
}

gls.right[1] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.check_git_workspace,
        icon = '+',
        highlight = {colors.green, colors.dark_bg},
        separator = ' ',
        separator_highlight = {colors.light_bg, colors.dark_bg}
    }
}
gls.right[2] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.check_git_workspace,
        icon = '~',
        highlight = {colors.yellow, colors.dark_bg}
    }
}
gls.right[3] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.check_git_workspace,
        icon = '-',
        highlight = {colors.red, colors.dark_bg}
    }
}

gls.right[4] = {
    GitBranch = {
        -- provider = {function() return ' ' end, 'GitBranch'},
		provider = {function() return ' ' end, 'GitBranch'},
        condition = condition.check_git_workspace,
        highlight = {colors.grey, colors.dark_bg},
		separator = ' ',
        separator_highlight = {colors.grey, colors.dark_bg}
    }
}

gls.right[5] = {
    PerCent = {
        provider = function()
			local current_line = vim.fn.line('.')
			local total_line = vim.fn.line('$')
			local result,_ = math.modf((current_line/total_line)*100)
			return ' '.. result .. '% '
		end,
		separator = ' ',
        separator_highlight = {colors.grey, colors.dark_bg},
		highlight = 'GalaxyViMode'
    }
}
