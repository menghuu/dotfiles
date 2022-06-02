## 依赖

- `git`
- `ruby` 可选，如果不安装linuxbrew、homebrew，则可以不需要 `ruby`

## linuxbrew/homebrew

- 如果没有root权限;或者不想用root权限安装包;或者在macos中。需要安装linuxbrew、homebrew
- 此依赖于`ruby`
- 参考的安装步骤
  - <https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/>
  - <https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/>
  - [这个脚本](./setup/setup_brew.bash)中查看、复制相应的命令来执行
  - 安装步骤一定不要跳过，有比较多的坑

```bash
chmod u+x ./setup/setup_brew.bash
./setup/setup_brew.bash
```

## 其他的软件

参见 `setup/setup_packages.bash`

## stow it

```sh
stow ~ main shell nvim git
```
