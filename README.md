Getting going on a new machine

## Transfer essentials from old machine

* ~/.ssh

Ensure ~/.dotfiles is up to date

## Homebrew (part one)

Install homebrew using instructions from https://brew.sh

## Sign in to App Store

While Homebrew is installing (this takes a while), sign in to the App Store. This is required for the brew bundkle step to work

## Brew bundle

Then use the included `Brewfile` to install core apps and dependencies

## Clone this repo

While the brew dependencies are installing, clone this repo

`git clone git@github.com:lazyatom/dotfiles.git ~/.dotfiles`
`./dotfiles/install.sh`

## Change user shell to fish

Once at least fish is installed, use System Preferences / Users & Groups to change the shell of your user to `/usr/local/bin/fish`

## Install dotfiles

Once at least `fish` is installed, run `install` in this repo to set up dotfiles. You can test if this worked by opening a new Terminal tab or window.

## Install Oh My Fish

`curl -L https://get.oh-my.fish | fish`

This should then automatically install any packages required.

## Install a patched version of chruby-fish

`git clone git@github.com:bouk/chruby-fish.git`
`git checkout rewrite-fish`
`make install`

## Change terminal font to Hack Nerd Font Complete 14pt

## Emacs

Looks like the builds of emacs might _not_ be portable, so building them by hand is required.

``` sh
mkdir -p ~/Code/forks
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

We use chemacs and doom principally. The configuration is installed earlier as part of the dotfiles, but we need to actually install doom itself.

``` sh
mkdir ~/.emacs-configs
git clone git@hithub.com:hlissner/doom-emacs.git ~/.emacs-configs/doom
doom sync
```

This may also take a while, to natively compile everything.

After this, you should be able to run Emacs and see Doom.

## In apps:

* install ruby using ruby-install, e.g. `ruby-install ruby 2.6.5`
* then install bundler globally: `gem install bundler`
* then install bundle: `bi`
