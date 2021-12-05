# dotfiles

dotfiles for myself.

# Install Tools

## Google Chrome

https://www.google.com/intl/ja/chrome/

## iTerms2

https://iterm2.com/downloads.html

## Slack

https://slack.com/intl/ja-jp/downloads/mac

## Deepl Translator

https://www.deepl.com/ja/app/

## Docker

https://www.docker.com/products/docker-desktop

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

## dotfiles

```
$ git clone git@github.com:koki-develop/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ bin/setup.sh
````

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
```

## Python

```
$ asdf plugin add python
$ asdf list all python
$ asdf install python <version>
$ asdf global python <version>
$ pip install --upgrade pip
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
