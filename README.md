Getting going on a new machine

## On old machine

``` sh
cd ~
tar --exclude="bin/caddy" -czvf dotfiles.tar.gz .ssh .aws .bundle/config .chef .config/gh .editorconfig .gem/credentials .gitconfig.private .homebrew-token .gnupg .irb_history .netrc .npmrc .s3cfg .sem.yaml .ssb/secret .ssb/gossip.json .zhistory bin org lazyatom.ovpn
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
git clone git@github.com:bouk/chruby-fish.git ~/Code/forks/chruby-fish
cd ~/Code/forks/chruby-fish
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
./build-emacs-for-macos --git-sha fd9e9308d27138a16e2e93417bd7ad4448fea40a feature/native-comp
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
git clone git@github.com:hlissner/doom-emacs.git ~/.emacs-configs/doom
doom sync
```

This may also take a while, to natively compile everything.

After this, you should be able to run Emacs and see Doom.

### Font installation

The Doom modeline needs a font -- install it by running the `all-the-icons-install-font` function.

## 1Password

Run the 1Password app, and log in to the 1Password.com account.

## Dropbox

Run the dropbox app, and log in

## MariaDB

As of 10.4, the authentication set up by MariaDB is different. A user will be created with the same username as the unix account, but it won't be possible to authenticate that user over anything but the unix socket, which isn't super-useful for Rails when configuring databases using URLs.

So instead, run this:

``` sh
brew services start mariadb
mysql -e 'SET PASSWORD FOR "james"@"localhost" = PASSWORD("");'
```

After this, you should be able to connect to the database using Rails and Sequel Ace.

## Compilation failures

Some of the clang tooling in Big Sur [breaks gem builds by default](https://github.com/puma/puma/issues/2304#issuecomment-664448309). The fix is to ignore some warnings:

``` sh
bundle config build.bcrypt-ruby --with-cflags="-Wno-error=implicit-function-declaration"
bundle config build.github-markdown --with-cflags="-Wno-error=implicit-function-declaration"
bundle config build.puma --with-cflags="-Wno-error=implicit-function-declaration"
bundle config build.pg --with-cflags="-Wno-error=implicit-function-declaration"
```

Similarly, some other things have issues compiling:

#### vterm under Emacs

To fix this, after compilation failed I had to edit the file at `~/.emacs-configs/doom/.local/straight/build-<dir>/vterm/build/libvterm-prefix/src/libvterm/Makefile`, changing the line that starts with `override CFLAGS` to include `-Wno-error=implicit-function-declaration`. 

There might be a better way of fixing all these errors at once, but until then...

## In apps:

* install ruby using ruby-install, e.g. `ruby-install ruby 2.6.5`
* then install bundler globally: `gem install bundler`
* then install bundle: `bi`
