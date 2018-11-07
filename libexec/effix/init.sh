#!/usr/bin/env bash

_init () {
    cat > $PROJECT_DIR/$EFFIX_CONF <<EOL
# One command each line

# use CUSTOM_BIN_DIR="/custom/bin" if you want to use custom bin dir
# You can use recipes. Use: effix recipes for more info

phpunit
phpstan
csfix

# You can also run a custom command using [file] as placeholder. Example:
# your/script.sh [file]
EOL
}
