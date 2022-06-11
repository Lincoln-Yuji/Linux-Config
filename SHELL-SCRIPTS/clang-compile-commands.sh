touch compile_commands.json
sed "s|HOME-DIR|$HOME|g;s|CUR-DIR|$(pwd)|g" $HOME/.local/bin/meta/compile_commands_template \
    > compile_commands.json
