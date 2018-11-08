#!/bin/sh

_print_recipes () {
    echo "Recipes:"
    echo
    echo "phpstan   - Run phpstan recipe"
    echo "            Supported vars CUSTOM_BIN_DIR, PHPSTAN_CONF, PHPSTAN_LEVEL"
    echo
    echo "phpunit   - Run phpunit recipe"
    echo "            Supported vars CUSTOM_BIN_DIR, PHPUNIT_CONF"
    echo
    echo "csfix     - Run phpunit recipe"
    echo "            Supported vars CUSTOM_BIN_DIR"
}

# Recipes

__phpunit_single_test () {
    : ${CUSTOM_BIN_DIR:=$PROJECT_DIR/vendor/bin}
    : ${PHPUNIT_CONF:=phpunit.xml.dist}

    PHPUNIT_OUTPUT="$($CUSTOM_BIN_DIR/phpunit -c $PHPUNIT_CONF $1)"
    if ! echo "$PHPUNIT_OUTPUT" | grep -q "OK"; then
        __print_error "$PHPUNIT_OUTPUT"
        exit 1
    fi
}

phpunit () {
    if echo $1 | grep -q "tests/"; then
        __phpunit_single_test $1
    else
        FILE_TMP="$(echo $1 | sed 's,src/,tests/,g' | sed 's,\.php,Test\.php,g')"

        if [ -f "$FILE_TMP" ] &&  echo $FILE_TMP | grep -q "Test.php"; then
            __phpunit_single_test $FILE_TMP
        fi
    fi
}

phpstan () {
    : ${PHPSTAN_CONF:=phpstan.neon}
    : ${PHPSTAN_LEVEL:=1}
    : ${CUSTOM_BIN_DIR:=$PROJECT_DIR/vendor/bin}

    PHPSTAN_OUTPUT="$($CUSTOM_BIN_DIR/phpstan analyse --ansi -c $PHPSTAN_CONF -l $PHPSTAN_LEVEL $1 2>&1)"
    if ! echo "$PHPSTAN_OUTPUT" | grep -q "\[OK\]"; then
        __print_error "$PHPSTAN_OUTPUT"
    fi

}

csfix () {
    : ${CUSTOM_BIN_DIR:=$PROJECT_DIR/vendor/bin}

    CSFIX_OUTPUT="$($CUSTOM_BIN_DIR/php-cs-fixer fix $1 2>&1 | grep '1) ' | awk '{ print " " $2; }')"
    if [ ! -z "$CSFIX_OUTPUT" ]; then
        __print_error "$CSFIX_OUTPUT"
    fi
}