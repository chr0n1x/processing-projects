processing-projects
===================

Repository for my [Processing](https://www.processing.org) projects.
Do what you want with the code, I'm just playing around.

### Setup

Just run the `setup.sh` file. It downloads libs for you. You'll need to set up a `PROCESSING_PATH` environment variable for it to run (it'll tell you how).

### Libs/Tools Used

- [sophacles/vim-processing](https://github.com/sophacles/vim-processing) (for colors!)
- [extrapixel/gif-animation](https://github.com/extrapixel/gif-animation)

### Running your sketches from VIM

In your `.vimrc`

```
nnoremap <Leader>p
\ :!rm -rf /tmp/processing/*
\ &&
\ processing-java --output=/tmp/processing --sketch=%:p:h
\ --force
\ --run<CR>
```

This maps ``\p`` in vim to the shell command above, which runs the Processing sketch that you currently have open. I set that up because I didn't have any luck with `sophacles/vim-processing`.

Make sure that you install the `processing-java` bin via the Processing GUI!

**Processing -> Tools -> Install "processing-java"**
