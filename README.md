# dotfiles

dotfiles for myself.

# Install Tools

## Google Chrome

https://www.google.com/intl/ja/chrome/

## Slack

https://slack.com/intl/ja-jp/downloads/mac

## Deepl Translator

https://www.deepl.com/ja/app/

## Docker

https://www.docker.com/products/docker-desktop

## kubectl

https://kubernetes.io/ja/docs/tasks/tools/install-kubectl/

## krew

https://krew.sigs.k8s.io/docs/user-guide/setup/install/

## kube-ps1

https://github.com/jonmosco/kube-ps1

## Notion

https://www.notion.so/desktop

## Visual Studio Code

https://code.visualstudio.com/download

## Homebrew

```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Git

```
$ brew install git
```

## Hyper

```
$ brew install --cask hyper
```

## Hammerspoon

```
$ brew install hammerspoon --cask
```

## dotfiles

```
$ git clone git@github.com:koki-develop/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ bin/setup.sh
```

## Hyper Statusbar

https://github.com/koki-develop/hyper-statusbar

## zsh-completions

```
$ brew install zsh-completions
```

## neovim

```
$ brew install neovim
```

## vim-plug

```
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ nvim +PlugInstall +UpdateRemotePlugins +qall
```

## asdf

```
$ brew install asdf
$ brew install gawk gpg
```

## Node.js

```
$ asdf plugin add nodejs
$ asdf list all nodejs
$ asdf install nodejs <version>
$ asdf global nodejs <version>
$ npm install --global npm
$ npm install --global yarn
$ asdf reshim nodejs
```

## Python

```
$ asdf plugin add python
$ asdf list all python
$ asdf install python 3.x.x 2.x.x
$ asdf global python 3.x.x 2.x.x
$ pip install --upgrade pip
$ asdf reshim python
```

## Ruby

```
$ asdf plugin add ruby
$ asdf list all ruby
$ asdf install ruby <version>
$ asdf global ruby <version>
```

## Go

```
$ asdf plugin add golang
$ asdf list all golang
$ asdf install golang <version>
$ asdf global golang <version>
```

## Rust

```
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
$ cargo install cargo-edit
```

## Terraform

```
$ asdf plugin add terraform
$ asdf list all terraform
$ asdf install terraform <version>
$ asdf global terraform <version>
```

## trash-cli

```
$ pip install trash-cli
```

## gcloud CLI

```
$ curl https://sdk.cloud.google.com | bash
$ gcloud init
```

## AWS CLI

```
$ brew install awscli
$ aws configure
```

## direnv

```
$ brew install direnv
```

## circleci

```
$ brew install circleci
```

## github-cli

```
$ brew install gh
$ gh auth login
```

## git-secrets

```
$ git secrets --register-aws --global
$ git secrets --install ~/.git-templates/git-secrets
```

## jq

```
$ brew install jq
```

## ag

```
$ brew install ag
```

## fd

```
$ brew install fd
```

## exa

```
$ brew install exa
```

## bat

```
$ brew install bat
```

## wget

```
$ brew install wget
```

## tree

```
$ brew install tree
```

## nkf

```
$ brew install nkf
```

## eksctl

https://eksctl.io/introduction/#installation
