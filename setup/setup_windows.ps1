# this file is not for running directly !!
# you should copy and modify some codes

$Local:DotFilePath = '\\wsl$\Ubuntu\home\m\projs\dotfiles'

New-Item -ItemType SymbolicLink -Path "$Env:USERPROFILE\dotfiles" -Target "$Local:DotFilePath"
New-Item -ItemType SymbolicLink -Path "$Env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "$Env:USERPROFILE\dotfiles\windows\.config\Microsoft.PowerShell_profile.ps1"

. "$Env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"


# install winget or scoop first!
# copy from https://github.com/microsoft/winget-cli/discussions/817
function InstallWinGet()
{
	$hasPackageManager = Get-AppPackage -name "Microsoft.DesktopAppInstaller"

	if(!$hasPackageManager)
	{
		Add-AppxPackage -Path "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"

		$releases_url = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"

		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
		$releases = Invoke-RestMethod -uri "$($releases_url)"
		$latestRelease = $releases.assets | Where { $_.browser_download_url.EndsWith("msixbundle") } | Select -First 1

		Add-AppxPackage -Path $latestRelease.browser_download_url
	}
}
InstallWinGet


# install scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
irm get.scoop.sh | iex
# AddPath "$env:USERPROFILE\scoop\shims"


# see https://github.com/ScoopInstaller/scoop/wiki/Using-Scoop-behind-a-proxy#config-examples
scoop config proxy ':@http://localhost:10811'
scoop bucket add extras
scoop bucket add nerd-fonts
scoop bucket add versions
scoop config proxy localhost:10811


# 代码编辑器
winget install Microsoft.VisualStudioCode
# 密码管理
winget install KeePassXCTeam.KeePassXC
# 文档 API 搜索
winget install Zeal
# 网盘
winget install Nutstore.Nutstore
winget install Baidu.BaiduNetdisk
winget install Microsoft.OneDrive
# ssh相关
winget install WinSCP.WinSCP
winget install PuTTY.PuTTY
winget install Iterate.Cyberduck
# see https://github.com/winfsp/sshfs-win
winget install SSHFS-Win.SSHFS-Win WinFsp.WinFsp
# wsl powershell terminal 相关
winget install Canonical.Ubuntu
winget install Microsoft.PowerShell
winget install Microsoft.WindowsTerminal
# git
winget install Git.Git
winget install TortoiseGit.TortoiseGit
scoop install lazygit
# 解压缩软件
winget install Bandisoft.Bandizip
# 下载工具
winget install CometNetwork.BitComet
# 虚拟机 和 docker
winget install Docker.DockerDesktop
winget install Oracle.VirtualBox
# 输入法
winget install Sogou.SogouInput
# 字典
winget install EuSoft.Eudic
# 社交工具
winget install Tencent.TIM
winget install Tencent.WeChat
wignet install ByteDance.Feishu
# 企业微信
winget install Tencent.wechat-work
# 论文管理
winget install Zotero.Zotero
# 图片
winget isntall DuongDieuPhap.ImageGlass
winget install jurplel.qView
winget install IrfanSkiljan.IrfanView
winget install Bandisoft.Honeyview
winget install GIMP.GIMP
winget install KDE.digikam
winget install Billfish.Billfish
# 截图
winget install Snipaste -s msstore
winget install PicGo.PicGo
# 音乐
winget install AIMP.AIMP
# 视频
winget install Shooter.SPlayerX VideoLAN.VLC
# 视频录制 制作
winget install OBSProject.OBSStudio
winget install --id=FreeTime.FormatFactory  -e
# pdf
winget install Drawboard -s msstore
winget install SumatraPDF.SumatraPDF
winget install Kingsoft.KingsoftPDF
# doc 文档
winget install Kingsoft.WPSOffice
winget install Kingsoft.KDocs
winget install TheDocumentFoundation.LibreOffice
# markdown/text
winget isntall Typora.Typora.Beta
winget install Obsidian.Obsidian
winget isntall MarkText.MarkText
winget install Joplin.Joplin
scoop install notepad3
# onenote 的 markdown 插件
winget install Neux.OneMark
# ppt
winget install iSlide.iSlide
# 搜索
winget install Bopsoft.Listary Yuanli.uTools voidtools.Everything
# 浏览器
winget install Microsoft.Edge
winget install Mozilla.Firefox
# todo 番茄时钟 效率工具
winget install 'Microsoft To Do' -s msstore
winget install Appest.Dida
scoop install Pomotodo
# 磁盘
winget install Win32diskimager.win32diskimager
winget install Rufus.Rufus
winget install Eassos.DiskGenius
# 字体
scoop install CascadiaCode-NF CascadiaCode-NF-Mono
# 围棋
winget install SabakiHQ.Sabaki
# 游戏
winget install Ubisoft.Connect
winget install Valve.Steam
# 备份
winget install Duplicati.Duplicati
winget install Kopia.KopiaUI
# 键盘按键映射
winget install sharpkeys
# 其他软件
# 罗技鼠标的官方管理软件
winget install Logitech.Options
# 字体显示增强
winget install MacType.MacType
winget install AltDrag.AltDrag
winget install Armin2208.WindowsAutoNightMode
winget install QuickLook -s msstore
# mac ipad
winget install Apple.iTunes
# 将 ipad 当做另一个显示屏，需要在 ipad 上安装 client
winget install Splashtop.SplashtopWiredXDisplay
winget install Datronicsoft.SpacedeskDriver.Server
winget install alexx2000.DoubleCommander
winget install Lexikos.AutoHotkey
# 远程连接
winget install TeamViewer.TeamViewer
# 内网穿透
winget install ZeroTier.ZeroTierOne
# 编程语言、运行时
winget install anaconda3
winget install python3 -s winget
winget install OpenJS.NodeJS.LTS
winget install rjpcomputing.luaforwindows



pip install pipx
# 开发效率工具
winget install vim.vim
winget install Neovim.Neovim
# like gnu stow
pipx install dploy
scoop install z.lua
scoop install fd fzf ripgrep
scoop install bat
scoop install direnv
scoop install gow
scoop install ffmpeg
scoop install losslesscut
scoop install dismplusplus
scoop install spacesniffer
scoop install v2rayn
scoop install ventoy
scoop install rclone
scoop install hugo hugo-extended
scoop install delta


# setup powershell
winget install --id Microsoft.Powershell --source winget
winget install JanDeDobbeleer.OhMyPosh
Install-Module -Name PSReadLine -AllowPrerelease


foreach ($package in 'main', 'git') {
	dploy stow "$Env:USERPROFILE/dotfiles/$package" $Env:USERPROFILE
}
New-Item -ItemType SymbolicLink -Path "$Env:USERPROFILE\.gitconfig" -Target "$Env:USERPROFILE\.config\git\windows.gitconfig"

# TODO config nvim/vim
#dploy stow "$Env:USERPROFILE/dotfiles/nvim" $Env:USERPROFILE
#New-Item -ItemType SymbolicLink -Path "$Env:USERPROFILE\dotfiles\windows\Microsoft.PowerShell_profile.ps1" -Target "$Env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
#New-Item -ItemType SymbolicLink -Path "$Env:USERPROFILE\vimfiles" -Target "$Env:USERPROFILE\.config\nvim"
#curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#rm "$Env:USERPROFILE\AppData\Local\nvim\"
#New-Item -ItemType SymbolicLink -Path "$Env:USERPROFILE\AppData\Local\nvim" -Target "$Env:USERPROFILE\.config\nvim"
#New-Item -ItemType SymbolicLink -Path "$Env:USERPROFILE\_vimrc" -Target "$Env:USERPROFILE\.config\nvim\init.vim"
