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

## In apps:

* install ruby using ruby-install, e.g. `ruby-install ruby 2.6.5`
* then install bundler globally: `gem install bundler`
* then install bundle: `bi`
