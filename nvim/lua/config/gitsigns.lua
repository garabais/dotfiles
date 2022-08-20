require('gitsigns').setup {
  signs = {
    add          = { hl = 'GitGutterAdd', text = '│', },
    change       = { hl = 'GitGutterChange', text = '│', },
    delete       = { hl = 'GitGutterDelete', text = '│', },
    topdelete    = { hl = 'GitGutterDelete', text = '│', },
    changedelete = { hl = 'GitGutterChange', text = '│', },
  },
  --signs = {
  --add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
  --change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  --delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
  --topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
  --changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  --},
}
