# dotfiles
Compilation of all of my dotfiles

## What's inside
| Path | What it configures |
|---|---|
| `.zshrc` | zsh with Oh My Zsh, Dracula theme, plugins, fzf, zoxide, mise and aliases |
| `.zshenv` | PATH for every zsh, including non-interactive shells (mise shims, Homebrew) |
| `.config/herdr/` | [herdr](https://herdr.dev) terminal multiplexer and its status bar scripts |
| `.vimrc` | Vim |
| `.tmux.conf` | tmux (deprecated, replaced by herdr) |
| `.bashrc`, `.config/terminator/` | Old Ubuntu setup (legacy) |

## Setup (macOS)
Run these in order on a new machine.

### 1. Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Clone repository
```bash
git clone https://github.com/HugoLiconV/dotfiles.git ~/dev/dotfiles
export DOTFILES=~/dev/dotfiles   # wherever you cloned it
```

### 3. zsh
Install Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install Dracula theme
```bash
git clone https://github.com/dracula/zsh.git ~/zsh
ln -s ~/zsh/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme
```

Install zsh-autosuggestions
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Install [mise](https://mise.jdx.dev) (manages node, pnpm and other runtimes)
```bash
brew install mise
```

Create symlinks last, once everything `.zshrc` needs is installed. `-f` replaces the `.zshrc` the Oh My Zsh installer created.
```bash
ln -sf $DOTFILES/.zshrc ~/.zshrc
ln -sf $DOTFILES/.zshenv ~/.zshenv
```

### 4. CLI tools
```bash
brew install jq fzf ripgrep bat eza zoxide
```

`.zshrc` sets up fzf and zoxide automatically and adds aliases for bat and eza. Every alias is only defined when its tool is installed. See [Usage](#usage) for what each tool does.

### 5. Ghostty and herdr
Install the [Ghostty](https://ghostty.org) terminal and herdr
```bash
brew install --cask ghostty
brew install herdr
```

Create symlinks for the herdr config and the status bar scripts
```bash
mkdir -p ~/.config/herdr
ln -s $DOTFILES/.config/herdr/config.toml ~/.config/herdr/config.toml
ln -s $DOTFILES/.config/herdr/status ~/.config/herdr/status
```

The status bar icons need Nerd Font symbols. Ghostty includes them, other terminals may need a [Nerd Font](https://www.nerdfonts.com).

### 6. Vim
```bash
ln -s $DOTFILES/.vimrc ~/.vimrc
```

### 7. Check it works
```bash
ls -la ~ ~/.config/herdr | grep -- '->'   # every symlink points into $DOTFILES
zsh -i -c exit                           # a new shell starts without errors
herdr server reload-config               # "status":"applied" with no diagnostics
```

## Usage

### herdr
- Prefix is `Ctrl + a`. Press `prefix` + `?` to see every keybinding
- `prefix` + `-` and `prefix` + `v` split the pane
- Apply config changes with `herdr server reload-config`
- The status bar at the bottom shows CPU, RAM, battery and time. Each value comes from a script in `.config/herdr/status/`, and the entries are listed under `tab_bar_right` in `config.toml`

### CLI tools

#### jq
Reads, filters and pretty-prints JSON.
```bash
jq . data.json                     # pretty-print a file
curl -s https://api.github.com/repos/HugoLiconV/dotfiles | jq '.stargazers_count'
jq -r '.dependencies | keys[]' package.json   # -r prints raw strings, without quotes
```

#### fzf
Fuzzy finder: type a few letters to filter any list, then pick one with the arrow keys and Enter.
- `Ctrl + R`: search your command history
- `Ctrl + T`: pick a file and insert its path into the command
- `Alt + C`: pick a folder and `cd` into it (on macOS, set your terminal to treat Option as Alt)
```bash
vim $(fzf)        # open whichever file you pick
cd **<Tab>        # fuzzy-complete a path for any command
```

#### ripgrep (`rg`)
A much faster `grep` for searching code. It skips files listed in `.gitignore` by default.
```bash
rg "TODO"            # search the current folder, recursively
rg -i "useState"     # ignore case
rg -t js "fetch"     # only JavaScript files
rg -l "API_KEY"      # only list the files that match
```

#### bat (alias `b`)
`cat` with syntax highlighting, line numbers and git changes in the margin.
```bash
b .zshrc             # view a file
b -r 10:20 .zshrc    # only lines 10 to 20
b -p .zshrc          # plain output, for copying
```

#### eza (aliases `ll`, `lt`)
A modern `ls` with colors and git status.
```bash
ll                           # eza -lah --git: list everything, with git status per file
lt                           # eza --tree --level=2: folder tree, two levels deep
eza --tree --level=3 src     # deeper tree of a specific folder
```

#### zoxide (`z`, `zi`)
A smarter `cd` that learns which folders you visit and jumps to them from part of a name.
```bash
z dotfiles      # jump to the most used folder matching "dotfiles"
z dev dot       # several words narrow it down (~/dev/dotfiles)
zi              # pick from your visited folders with fzf
z -             # go back to the previous folder
zoxide import --from=z ~/.z   # one-time: import history from the old z.sh
```

## Deprecated: tmux
Replaced by herdr. Kept for machines that still use it.

```bash
brew install tmux
ln -s $DOTFILES/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
Install plugins: press `prefix` + `I` (capital i). The prefix is `Ctrl + a`

## Legacy: Ubuntu
Configs from an older Ubuntu setup.

- `.bashrc`: Ubuntu's default bash config with nvm and broot added
- `.config/terminator/`: config for the [Terminator](https://gnome-terminator.org) terminal

```bash
ln -s $DOTFILES/.bashrc ~/.bashrc
mkdir -p ~/.config/terminator
ln -s $DOTFILES/.config/terminator/config ~/.config/terminator/config
```

CLI tools on Ubuntu (eza is in apt from 24.04; bat installs as `batcat`)
```bash
sudo apt install jq fzf ripgrep bat eza zoxide
```
