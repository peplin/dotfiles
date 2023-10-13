* Install homebrew
* Install Hack font
* Install gruvbox theme in Terminal.app
    https://github.com/sidnvy/gruvbox-terminal
* Configure iterm2 profile
* Configure caps lock to be option key
* Configure Keyboard shortcuts for:
    Chrome:
        control-t
        control-w
        control-k
        control-l
        shift versions
    Spotlight:
        caps-d
    Screenshot:
        caps-s



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


defaults write com.apple.Finder AppleShowAllFiles true

# Specify the iterm2 preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/mac"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true



Q: is it possible to make caps-enter a global shortcut to open a new terminal?
