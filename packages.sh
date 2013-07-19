#!/usr/bin/zsh

pip freeze | grep -v '^\-e' | cut -d = -f 1 > /home/threv/.dotfiles/installed_pip.txt

gem list --no-versions | sed -e '/^(*|$)/d' > /home/threv/.dotfiles/installed_gems.txt

perl -MExtUtils::Installed -E 'say for ExtUtils::Installed->new->modules' > /home/threv/.dotfiles/installed_cpan.txt

npm list -g --parseable | awk 'BEGIN {FS = "/" }; {print $NF}' | uniq >!  /home/threv/.dotfiles/installed_npms.txt

dpkg --get-selections >! /home/threv/.dotfiles/myselections
