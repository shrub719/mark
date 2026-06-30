# Mark, My Words.

I made a bash function that uses pandoc to quickly preview Markdown files.


## Setup

1. Set up a directory that looks like this:

```
./
├── style.css
└── tmp/
```

2. Set `MARK_DIR` in `mark.sh` to the location of that directory.

3. Copy `mark.sh` into your `.bashrc` or `.bash_aliases` or whatever.

Obviously, you will need pandoc installed. Other than that, you're done!


## Usage

```sh
mark [file]         # preview a single file
mark [directory]    # preview a directory, opening with its README.md
mark                # preview the current directory
```

