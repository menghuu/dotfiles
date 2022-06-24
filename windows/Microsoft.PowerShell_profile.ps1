
function AddPath([String]$paths)
{
    foreach($path in $paths){
        # echo "path is $path"
        if( ! $Env:Path.Contains($path) ) {
            # echo "will add path $path"
            $Env:Path = "$path;$Env:Path"
        }
    }
}
Function proxy {
    $env:HTTP_PROXY="http://localhost:10809"
    $env:HTTPS_PROXY="http://localhost:10809"
    curl myip.ipip.net
}

Function noproxy {
    $env:HTTP_PROXY="http://localhost:10809"
    $env:HTTPS_PROXY="http://localhost:10809"
    curl myip.ipip.net
}



AddPath "$env:USERPROFILE\scoop\shims"

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Chord "Ctrl+f" -Function ForwardWord
if ( get-command oh-my-posh ) {
    # 主题的地址使用是和 wsl2 中一样的
    # TODO 需要更加健壮的配置
    $posh_theme_file_path = 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/pure.omp.json'
    $posh_theme_file_path = '\\wsl$\Ubuntu\home\m\.poshthemes\pure.omp.json'
    oh-my-posh init pwsh --config $posh_theme_file_path | Invoke-Expression
}


# 开启 z.lua 支持
$ZLuaPath = scoop prefix z.lua
if ($ZLuaPath -ne '') {
    Invoke-Expression (& { (lua "$ZLuaPath\z.lua" --init powershell) -join "`n" })

    function zi() { z -i }
    function zf() { z -I . }
    function zb() { z -b }
    function zbi() { z -b -i }
    function zbf() { z -b -I }
    function zt() { z -t }
    function zt.() { z -t . }
    # function z-() -{ z - }
    # function z--() { z -- }

    $Env:_ZL_MATCH_MODE = 1
    $Env:_ZL_ADD_ONCE = 1
}

if ( Get-Command lazygit ) {
    Set-Alias lg lazygit
}


Set-Alias ll Get-ChildItem

$env:GO111MODULE="on"
$env:GOPROXY = "https://proxy.golang.com.cn,direct"
# $env:GOPRIVATE = "git.mycompany.com,github.com/my/private"
