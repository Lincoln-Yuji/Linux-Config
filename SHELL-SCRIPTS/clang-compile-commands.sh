touch compile_commands.json
sed "s|HOME-DIR|$HOME|g" $HOME/.local/bin/meta/compile_commands_template \
    | sed "s|CUR-DIR|$(pwd)|g" > compile_commands.json
