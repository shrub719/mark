function hypermark() {
    shopt -s globstar
    local tempdir="./tmp"
    local outdir="./hypermark"
    mkdir -p "$tempdir"
    rm -r "$tempdir"
    mkdir -p "$outdir"
    rm -r "$outdir"

    mark .
    cp -r "$MARK_DIR/tmp/" "$tempdir/"
    
    for file in "$tempdir"/**/*.html
    do
        local rel=${file#"${tempdir}/"}
        rel=${rel%".html"}
        echo "$rel"

        local readme=false
        if [[ "$rel" == **/"README" ]]
        then
            rel=${rel%"/README"}
            readme=true
        elif [[ "$rel" == "README" ]]
        then
            rel="."
            readme=true
        fi

        echo "hypermark: $rel"
        local out="$outdir/$rel/index.html"
        mkdir -p "$(dirname "$out")"
        mv "$file" "$out"

        if [ "$readme" = false ]
        then
            sed -i "s/\.\//\.\.\//g" "$out"
        fi
        sed -i "s/\.html//g" "$out"
        sed -i "s/README//g" "$out"
    done

    # TODO: copy non-md assets

    rm -r "$tempdir"
}

