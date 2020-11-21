Getting going on a new machine

## On old machine

``` sh
cd ~
tar -czvf ssh.tar.gz .ssh
```

Ensure ~/.dotfiles is up to date on the old machine

## Install Homebrew

Install homebrew using instructions from https://brew.sh

This makes the core dependencies (like git) available, via the Apple Developer Tools.

## Transfer essentials from old machine

``` sh
tar xzvf ssh.tar.gz 
```

## Clone this repo

We need to get this repo onto the machine. Clone using HTTPS -- we don't have the SSH keys in place yet.

`git clone git@github.com/lazyatom/dotfiles.git ~/.dotfiles`

## Brew bundle

Then use the included `Brewfile` to install core apps and dependencies. This will take a while.

When the bundle starts working from the App Store, it will fail if you haven't already signed in, so do that now too. You can quit the App Store after.

## Change user shell to fish

Once at least fish is installed, add it to the list of acceptable shells:

``` sh
echo `which fish` | sudo tee -a /etc/shells
chsh -s `which fish`
```

## Install dotfiles

Once at least `fish` and `git` are installed, you can properly install the actual dotfiles

``` sh
cd ~/.dotfiles
./install
```

This will symlink a bunch of configuration files

## Install Oh My Fish

`curl -L https://get.oh-my.fish | fish`

This should then automatically install any packages required.

## Install a patched version of chruby-fish

``` sh
mkdir -p ~/Code/forks
git clone git@github.com:bouk/chruby-fish.git
git checkout rewrite-fish
make install
```

## Install Backblaze

Run Backblaze and inherit the previous system backup state.

## Change terminal font to Hack Nerd Font Complete 14pt

## Emacs

Looks like the builds of emacs might _not_ be portable, so building them by hand is required.

``` sh
git clone git@github.com:jimeh/build-emacs-for-macos.git ~/Code/forks/build-emacs-for-macos
cd ~/Code/forks/build-emacs-for-macos
brew bundle
./build-emacs-for-macos --git-sha fd9e9308d27138a16e2e93417bd7ad4448fea40a feature/native-com
```

This will take a while.

### Command-line wrappers

Create wrapper scripts in /usr/local/bin/emacs:

```sh
#!/bin/sh

exec /Applications/Emacs.app/Contents/MacOS/Emacs $@
```

and /usr/local/bin/emacsclient:

``` sh
#!/bin/sh

exec /Applications/Emacs.app/Contents/MacOS/bin/emacsclient $@
```

### Emacs configuration

We use chemacs and doom. The configuration is installed earlier as part of the dotfiles, but we need to actually install doom itself.

``` sh
mkdir ~/.emacs-configs
git clone git@hithub.com:hlissner/doom-emacs.git ~/.emacs-configs/doom
doom sync
```

This may also take a while, to natively compile everything.

After this, you should be able to run Emacs and see Doom.

## 1Password

Run the 1Password app, and log in to the 1Password.com account.

## Dropbox

Run the dropbox app, and log in


## In apps:

* install ruby using ruby-install, e.g. `ruby-install ruby 2.6.5`
* then install bundler globally: `gem install bundler`
* then install bundle: `bi`
