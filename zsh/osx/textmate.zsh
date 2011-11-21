/usr/libexec/PlistBuddy -c 'Delete OakShellVariables' ~/Library/Preferences/com.macromates.textmate.plist
/usr/libexec/PlistBuddy -c 'Add OakShellVariables Array' ~/Library/Preferences/com.macromates.textmate.plist
/usr/libexec/PlistBuddy -c 'Merge /Users/james/.dotfiles/resources/textmate_environment_variables.plist OakShellVariables' ~/Library/Preferences/com.macromates.textmate.plist
# /usr/libexec/PlistBuddy -c 'Print OakShellVariables' ~/Library/Preferences/com.macromates.textmate.plist