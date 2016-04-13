#!/usr/local/bin/zsh

sudo pip freeze | grep -v '^\-e' | cut -d = -f 1 > /Users/msimpson/.dotfiles/installed_pip.txt

gem list --no-versions | sed -e '/^(*|$)/d' > /Users/msimpson/.dotfiles/installed_gems.txt

brew list > /Users/msimpson/.dotfiles/installed_brews.txt

perl -MExtUtils::Installed -E 'say for ExtUtils::Installed->new->modules' > /Users/msimpson/.dotfiles/installed_cpan.txt

#npm list -g --parseable | awk 'BEGIN {FS = "/" }; {print $NF}' | uniq >! installed_npms.txt
