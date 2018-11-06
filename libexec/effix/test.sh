#!/usr/bin/env bash

__read_conf () {
    if [ ! -f "$PROJECT_DIR/$EFFIX_CONF" ]; then
        echo "File not found!" && exit 2
    fi

    config="$(cat $PROJECT_DIR/$EFFIX_CONF | grep -v '^#')"
}

__print_debug_command () {
    [ ! -z "$CUSTOM_BIN_DIR" ]
    __print_info "DEBUG: $1"
}
__read_files () {
    FILES=$(git diff --name-only)
}

__exec_cmd () {
    [ "$DEBUG" == true ] && [ "$VERBOSITY" == 1 ] && __print_debug_command "$1"

    eval $1
}

__run_cmd_on_files () {
    cmd="$1"
    for FILE in $FILES; do
        cmd_s="$(echo "${cmd/\[file\]/$FILE}" | sed '/^\s*$/d')"
        if [ ! -z "$cmd_s" ]; then
            case "$cmd_s" in
                phpunit|phpstan|csfix)
                    [ "$DEBUG" == true ] && [ "$VERBOSITY" == 1 ] && __print_debug_command "recipe: $cmd_s $FILE"
                    $cmd_s "$FILE"
                shift
                ;;
                *)
                    __exec_cmd "$cmd_s"
                ;;
            esac
        fi

    done
}

_test () {
    __read_conf &&
    __read_files

    echo "$config" | while read cmd; do
      __run_cmd_on_files "$cmd"
    done
}
