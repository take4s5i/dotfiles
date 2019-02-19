" vim:et:sw=2:ts=2

function! s:on_load_pre()
  " Plugin configuration like the code written in vimrc.
  " This configuration is executed *before* a plugin is loaded.
  let g:quickrun_config = {
  \   '_' : {
  \       'hook/output_encode/enable' : 1,
  \       'hook/output_encode/encoding' : '&termencoding'
  \   },
  \   'ruby':{
  \       'hook/output_encode/enable' : 0
  \   },
  \   'sql' : {
  \       'type' : executable('mysql') ? 'sql/mysql' :
  \                executable('sqlplus') ? 'sql/oracle' : ''
  \   },
  \   'sql/oracle' : {
  \       'command' : 'sqlplus',
  \       'cmdopt' : '%{OraConnectionGet()}',
  \       'exec' : ['%c -S %o < %s']
  \   },
  \   'sql/mysql' : {
  \       'command' : 'mysql',
  \       'cmdopt' : '%{MysqlConnectionGet()}',
  \       'exec' : [ '%c %o < %s' ]
  \   },
  \  'javascript': {
  \    'type': executable('node') ? 'javascript/nodejs':
  \            executable('phantomjs') ? 'javascript/phantomjs':
  \            executable('js') ? 'javascript/spidermonkey':
  \            executable('d8') ? 'javascript/v8':
  \            executable('jrunscript') ? 'javascript/rhino':
  \            executable('cscript') ? 'javascript/cscript': '',
  \  }
  \}
endfunction

function! s:on_load_post()
  " Plugin configuration like the code written in vimrc.
  " This configuration is executed *after* a plugin is loaded.
endfunction

function! s:loaded_on()
  " This function determines when a plugin is loaded.
  "
  " Possible values are:
  " * 'start' (a plugin will be loaded at VimEnter event)
  " * 'filetype=<filetypes>' (a plugin will be loaded at FileType event)
  " * 'excmd=<excmds>' (a plugin will be loaded at CmdUndefined event)
  " <filetypes> and <excmds> can be multiple values separated by comma.
  "
  " This function must contain 'return "<str>"' code.
  " (the argument of :return must be string literal)

  return 'start'
endfunction

function! s:depends()
  " Dependencies of this plugin.
  " The specified dependencies are loaded after this plugin is loaded.
  "
  " This function must contain 'return [<repos>, ...]' code.
  " (the argument of :return must be list literal, and the elements are string)
  " e.g. return ['github.com/tyru/open-browser.vim']

  return []
endfunction
