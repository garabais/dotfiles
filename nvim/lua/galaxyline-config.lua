
local gl = require('galaxyline')

local colors = {
	bg = '#282c34',
	fg = '#aab2bf',
	section_bg = '#38393f',
	blue = '#61afef',
	green = '#98c379',
	light_green = '#B5CEA8',
	purple = '#c678dd',
	orange = '#e5c07b',
	red = '#D16969',
	red1 = '#e06c75',
	red2 = '#be5046',
	magenta = '#D16D9E',
	yellow = '#e5c07b',
	dark_yellow = '#D7BA7D',
	cyan = '#4EC9B0',
	gray1 = '#5c6370',
	gray2 = '#2c323d',
	gray3 = '#3e4452',
	darkgrey = '#5c6370',
	grey = '#848586',
	middlegrey = '#8791A5',
	string_orange = '#CE9178',
	vivid_blue = '#4FC1FF',
	light_blue = '#9CDCFE',
	error_red = '#F44747',
	info_yellow = '#FFCC66',
	white = '#FFFFFF'
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
				v = colors.purple,
				[''] = colors.purple,
				V = colors.purple,
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
				r = colors.cyan,
				rm = colors.cyan,
				['r?'] = colors.cyan,
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
					  c  = 'COMMAND-LINE',
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
		highlight = {colors.white, colors.bg}
	}
}

gls.left[2] = {
    FileIcon = {
        provider = {function() return '  ' end, 'FileIcon'},
        condition = buffer_not_empty,
        highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon,
            colors.section_bg
        }
    }
}
			
gls.left[3] = {
    FileName = {
        provider = function()
			local file = vim.fn.expand('%:t')
			if vim.bo.readonly then return file .. '  ' end
			if vim.bo.modifiable and vim.bo.modified then
					vim.api.nvim_command('hi GalaxyFileName guifg=' .. colors.fg)
			end
			return file .. ' '
		end,
        condition = buffer_not_empty,
		highlight = {colors.white, colors.section_bg},
		separator = ' ',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

gls.left[4] = {
    DiagnosticError = {
		provider = 'DiagnosticError', 
		icon = '  ', 
		highlight = {colors.error_red, colors.bg}
	}
}

gls.left[5] = {
	DiagnosticWarn = {
		provider = 'DiagnosticWarn', 
		icon = '  ', 
		highlight = {colors.orange, colors.bg}
	}
}

gls.left[6] = {
    DiagnosticHint = {
		provider = 'DiagnosticHint', 
		icon = '  ', 
		highlight = {colors.vivid_blue, colors.bg}
	}
}

gls.right[1] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.check_git_workspace,
        icon = '+',
        highlight = {colors.green, colors.bg},
        separator = ' ',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}
gls.right[2] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.check_git_workspace,
        icon = '~',
        highlight = {colors.orange, colors.bg}
    }
}
gls.right[3] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.check_git_workspace,
        icon = '-',
        highlight = {colors.red1, colors.bg}
    }
}

gls.right[4] = {
    GitBranch = {
        -- provider = {function() return ' ' end, 'GitBranch'},
		provider = {function() return ' ' end, 'GitBranch'},
        condition = condition.check_git_workspace,
        highlight = {colors.middlegrey, colors.bg},
		separator = ' ',
        separator_highlight = {colors.middlegrey, colors.bg}
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
        separator_highlight = {colors.middlegrey, colors.bg},
		highlight = 'GalaxyViMode'
    }
}
