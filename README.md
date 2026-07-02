# Mark, My Words.

I made a bash function that uses pandoc to quickly preview Markdown files.


## Usage

```sh
mark [file]         # preview a single file
mark [directory]    # preview a directory, opening with its README.md
mark                # preview the current directory

marked [file]       # updating preview of a single file
marked [directory]  # updating preview of a directory
marked              # updating preview of the current directory
```


## Installation

### Dependencies

- `mark`: `pandoc`
- `marked`: `mark`, `inotify-tools`

### Setup

1. Set up a directory that looks like this:

```
./
├── style.css
└── tmp/
```

You can add custom styles in `style.css`. `tmp/` will be used when previewing
directories.

2. Set `MARK_DIR` in `mark.sh` to the location of that directory.

3. Copy `mark/mark.sh` into your `.bashrc` or `.bash_aliases` or whatever.

4. If you want live updates, copy `mark/marked.sh` too.


> It's `mark`, like a guy called Mark.  
> And it's `marked`, like marking a file, but also like
`mark` with live `ed`its.
