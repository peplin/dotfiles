* Install homebrew
* Install Hack font
* Install gruvbox theme in Terminal.app
    https://github.com/sidnvy/gruvbox-terminal
* Configure iterm2 profile to use gruvbox colors and Hack font
* Configure caps lock to be option key
* Configure Keyboard shortcuts for:
    Spotlight:
        caps-d
    1password:
        caps-shift-d
    Screenshot:
        caps-s to clipboard
        caps-shift-s to file
    Mission control
* Disable Mission Control's Control-Arrow shortcuts (use Super-num with Amethyst
    instead) - this restores Control-Arrow for jumping between words



xcode-select --install
brew install \
    coreutils \
    util-linux \
    ykman \
    gh \
    bash \
    the_silver_searcher \
    jq \
    syncthing \
    iterm2 \
    direnv

brew install --cask \
    visual-studio-code \
    amethyst \

Enable tmux integration in iTerm2. Make sure tmux is invoked with "tmux -CC" on
the other end.


defaults write com.apple.Finder AppleShowAllFiles true

# Specify the iterm2 preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/mac"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

Q: is it possible to make caps-enter a global shortcut to open a new terminal?
