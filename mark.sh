export MARK_DIR="[INSERT DIRECTORY OF MARK FILES (style.css, tmp/)]"

function mark() {
    if [ -z "$1" ]
    then
        mark .

    elif [ -d "$1" ]
    then
        shopt -s globstar
        local outdir="$MARK_DIR/tmp"
        mkdir -p "$outdir"
        rm -r "$outdir"

        for file in "$1"/**/*.md
        do
            echo "mark: $file"
            local out="$outdir/${file%".md"}.html"
            mkdir -p "$(dirname "$out")"
            pandoc "$file" -o "$out" -s -c "$MARK_DIR/style.css" --quiet
            sed -i "s/\.md/\.html/g" "$out"
        done

        if [ -f "$outdir/README.html" ]
        then
            xdg-open "$outdir/README.html"
        else
            xdg-open "$outdir"
        fi

    elif [[ "$1" == *.md ]]
    then
        local out="$MARK_DIR/tmp.html"
        pandoc "$1" -o "$out" -s -c "$MARK_DIR/style.css" --quiet

        xdg-open "$out"

    else
        echo "not a directory or markdown file" 
    fi
}

complete -f -d mark


