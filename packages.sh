#!/usr/local/bin/zsh

pip freeze | grep -v '^\-e' | cut -d = -f 1 > /Users/threv/.dotfiles/installed_pip.txt

gem list --no-versions | sed -e '/^(*|$)/d' > /Users/threv/.dotfiles/installed_gems.txt

brew list > /Users/threv/.dotfiles/installed_brews.txt

perl -MExtUtils::Installed -E 'say for ExtUtils::Installed->new->modules' > /Users/threv/.dotfiles/installed_cpan.txt

npm list -g --parseable | awk 'BEGIN {FS = "/" }; {print $NF}' | uniq >! installed_npms.txt
