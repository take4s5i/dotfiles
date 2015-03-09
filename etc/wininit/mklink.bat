@echo off

rem TODO : 絶対パスではなく、リポジトリの相対パスに書き換える
del %USERPROFILE%\.bash_profile
del %USERPROFILE%\.gitconfig   
del %USERPROFILE%\.gitignore   
del %USERPROFILE%\.gvimrc      
del %USERPROFILE%\.inputrc     
del %USERPROFILE%\.vimrc       

mklink %USERPROFILE%\.bash_profile %USERPROFILE%\projects\github\dotfiles\.bash_profile 
mklink %USERPROFILE%\.gitconfig    %USERPROFILE%\projects\github\dotfiles\.gitconfig
mklink %USERPROFILE%\.gitignore    %USERPROFILE%\projects\github\dotfiles\.gitignore
mklink %USERPROFILE%\.gvimrc       %USERPROFILE%\projects\github\dotfiles\.gvimrc
mklink %USERPROFILE%\.inputrc      %USERPROFILE%\projects\github\dotfiles\.inputrc
mklink %USERPROFILE%\.vimrc        %USERPROFILE%\projects\github\dotfiles\.vimrc
