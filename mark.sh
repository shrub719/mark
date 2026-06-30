export MARK_DIR="[INSERT DIRECTORY OF MARK FILES (style.css, tmp/)]"

function mark() {
    if [ -z "$1" ]
    then
        mark .
    elif [ -d "$1" ]
    then
        for file in "$1"/*.md
        do
            echo "mark: $file"
            mark-convert "$file"
        done
        mark-open "README.md"
    elif [[ "$1" == *.md ]]
    then
        mark-convert "$1"
        mark-open "$1"
    else
        echo "not a .md file or directory" 
    fi
}

function mark-convert() {
    local name=$(basename "$1")
    local out="$MARK_DIR/tmp/$name.html"
    pandoc "$1" -o "$out" -s -c "$MARK_DIR/style.css" --quiet
    sed -i "s/\.md/\.md.html/g" "$out"
}

function mark-open() {
    local name=$(basename "$1")
    xdg-open "$MARK_DIR/tmp/$name.html"
}

function mark-clean() {
    rm "$MARK_DIR/tmp"/*
}

complete -f -d mark

