find . -maxdepth 1 -type d ! -path . -exec basename {} \; | xargs -I {} sh -c "git --git-dir {}/.git --no-pager log -1 --format=%cd --date=iso-local | sed 's/$/ {}/'" | sort
