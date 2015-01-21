#!/C/Windows/System32/WindowsPowerShell/v1.0/powershell.exe
$repoHome=(gi $(split-path $MyInvocation.MyCommand.path -parent)).Parent.FullName
$userHome=$env:userprofile

function New-Symlink([switch]$force,$target,$link){
    $input | % {
        $targetPath = join-path $target $_
        $linkPath   = join-path $link   $_

        if((test-path $linkPath) -and $force){
            & cmd.exe /c "del $linkPath"
        }
        & cmd.exe /c "mklink ""$linkPath"" ""$targetPath"""
    }
}

# files link to home directory
$files=('.gitconfig','.gvimrc','.vimrc','.inputrc','.bash_profile')
$files | New-Symlink -force $repoHome $userHome

