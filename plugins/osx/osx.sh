
function osx_configure_finder() {
	defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder;
}
