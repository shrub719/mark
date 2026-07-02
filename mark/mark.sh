export MARK_DIR="[INSERT DIRECTORY OF MARK FILES (style.css, tmp/)]"

function _mark-convert() {
    pandoc "$1" -o "$2" -s -c "$MARK_DIR/style.css" --quiet
}

function mark() {
    shopt -s globstar

    if [ -z "$1" ]
    then
        mark .

    elif [ -d "$1" ]
    then
        local outdir="$MARK_DIR/tmp"
        mkdir -p "$outdir"
        rm -r "$outdir"

        for file in "$1"/**/*.md
        do
            echo "mark: $file"
            local out="$outdir/${file%".md"}.html"
            mkdir -p "$(dirname "$out")"
            _mark-convert "$file" "$out"
            sed -i "s/\.md/\.html/g" "$out"
        done

        if [ -f "$outdir/index.html" ]
        then
            xdg-open "$outdir/index.html"
        elif [ -f "$outdir/README.html" ]
        then
            xdg-open "$outdir/README.html"
        else
            xdg-open "$outdir"
        fi

    elif [[ "$1" == *.md ]]
    then
        local out="$MARK_DIR/tmp.html"
        _mark-convert "$1" "$out"

        xdg-open "$out"

    else
        echo "not a directory or markdown file" 
    fi
}

complete -f -d mark

