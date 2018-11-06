#!/usr/bin/env bash

_init () {
    cat > $PROJECT_DIR/$EFFIX_CONF <<EOL
# One command each line
# use [file] as file placeholder
# You can use also a recipe. Use: effix recipes for more info

# use CUSTOM_BIN_DIR="/custom/bin" if you want to use custom bin dir

vendor/bin/php-cs-fixer fix [file]
vendor/bin/phpstan analyse -l 1 [file]
vendor/bin/phpunit [file]
EOL
}
