function cd {
    IFS='/'
    read -ra args <<< $1
    cmd=""

    if [[ ${#args[@]} -gt 0 ]]; then
        if [[ "${args[0]}" = "-" ]]; then
            cmd="-"
        else
            for arg in "${args[@]}"; do
                if [[ "$arg" =~ \.[\.]+ ]]; then
                    for (( i=1; i<=${#arg}-1; i++ )); do
                        cmd="$cmd../"
                    done
                else
                    cmd="$cmd$arg/"
                fi
            done
        fi
    else
        cmd="$HOME"
    fi

    builtin cd "$cmd"
}
