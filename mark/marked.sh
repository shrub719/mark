function marked() {
    shopt -s globstar

    if [ -z "$1" ]
    then
        marked .

    elif [ -d "$1" ]
    then
        local outdir="$MARK_DIR/tmp"
        mark "$1"
        echo "directory marked"

        inotifywait -mrqe modify --format "%w%f" "$1" | while read file
        do
            echo "mark: $file"
            local out="$outdir/${file%".md"}.html"
            mkdir -p "$(dirname "$out")"
            pandoc "$file" -o "$out" -s -c "$MARK_DIR/style.css" --quiet
            sed -i "s/\.md/\.html/g" "$out"
        done
        
    elif [[ "$1" = *.md ]]
    then
        local out="$MARK_DIR/tmp.html"
        mark "$1"
        echo "file marked"

        inotifywait -mrqe modify --format "%w%f" "$1" | while read file
        do
            echo "mark: $file"
            local out="$MARK_DIR/tmp.html"
            pandoc "$1" -o "$out" -s -c "$MARK_DIR/style.css" --quiet
        done

    else
        echo "not a directory or markdown file"
    fi
}

complete -f -d marked

