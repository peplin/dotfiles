export IRBRC=$HOME/.irbrc
export GEM_HOME=$HOME/.gem/ruby/$RUBY_VERSION

if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi
