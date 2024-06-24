# Temp script to transfer LSCOLORS code to 'theme.toml'
# file for 'yazi' 
# Thanks ChatGPT
# -- Louis 2024/0623
#!/bin/bash

transform_lscolors() {
    local code="$1"
    IFS=';' read -r -a parts <<< "$code"
    local fg_color=""
    local bg_color=""
    local bold=false
    local underline=false
    local italics=false

    for ((i=0; i<${#parts[@]}; i++)); do
        case "${parts[$i]}" in
            1)
                bold=true
                ;;
            3)
                italics=true
                ;;
            4)
                underline=true
                ;;
            38)
                if [ "${parts[$((i+1))]}" -eq 2 ]; then
                    local r=${parts[$((i+2))]}
                    local g=${parts[$((i+3))]}
                    local b=${parts[$((i+4))]}
                    fg_color=$(printf "#%02X%02X%02X" "$r" "$g" "$b")
                fi
                ;;
            48)
                if [ "${parts[$((i+1))]}" -eq 2 ]; then
                    local r=${parts[$((i+2))]}
                    local g=${parts[$((i+3))]}
                    local b=${parts[$((i+4))]}
                    bg_color=$(printf "#%02X%02X%02X" "$r" "$g" "$b")
                fi
                ;;
        esac
    done

    local result="fg = \"$fg_color\""
    [ "$bg_color" ] && result+=", bg = \"$bg_color\""
    $bold && result+=", bold = true"
    $underline && result+=", underline = true"
    $italics && result+=", italics = true"

    echo "$result"
}

process_file() {
    local filename="$1"
    while IFS= read -r line; do
        local name="${line%%=*}"
        local code="${line#*=}"
        local transformed_code=$(transform_lscolors "$code")
        echo "{ name = \"$name\", $transformed_code },"
    done < "$filename"
}

filename="lscolors.txt"
process_file "$filename"
