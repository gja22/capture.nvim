# capture.nvim

Capture various types of notes in Neovim.

## Warning

I do not recommend that you use this plugin for a few reasons: 
- The note types and their structure is highly specific to how I work and the
  system is not configurable.
- This is my first Neovim plugin and was primarily a learning opportunity. I did
  learn a ton (and had a lot of fun), but I am still very much a novice when it
  comes to the Neovim APIs. More than once I have destroyed a few files and I
  fully expect this will happen again.
- The design of the plugin is rather messy. All part of learning something new,
  but not necessarily something that you need to subject yourself to.
- My Lua experience is also minimal (some Redis and Nginx scripting, but nothing
  close to a real program). This was also a Lua learning experience. Please
  don't assume that anything I've done in here is the "right" way to approach
  the problem, it's high unlikely that is the case.

## Installation

Using packer:
```
use "gja22/capture.nvim"
```

Suggested keymaps:
```
vim.keymap.set('n', '<leader>zo', function() require('capture').oneonone() end, { desc = "Capture 1-1" })
vim.keymap.set('n', '<leader>zm', function() require('capture').meeting() end, { desc = "Capture meeting" })
vim.keymap.set('n', '<leader>zn', function() require('capture').note() end, { desc = "Capture note" })
vim.keymap.set('n', '<leader>zd', function() require('capture').daily() end, { desc = "Capture daily" })
vim.keymap.set('n', '<leader>zw', function() require('capture').weekly() end, { desc = "Capture weekly" })
```

## Basics

Capture is a template system that uses structured filenames and file headers to
organize and support the creation and subsequent use of notes.

This plugin (to date) is an efficiency tool to quickly generate new files based
on a template for various types of entries.

There are 5 notes types:
- One on one
- Meeting
- Note
- Daily
- Weekly

Filename structure:
- blah

Header structure:
- blah 

Body Structure:
- The body is completely free form
- I use Markdown for structure here, but that is not required by Capture
- Markdown is useful as there are many tools to help and most of the
  color schemes highlight the Markdown structure well
- I will use tags to help later searching

Directory structure:
- All files are stored in a single directory
- I'm not sure that this is a good idea, but it's working for now

## Note example


## What's next?

- Alphanumeric sorting of filenames when using Telescope. It used to work this
  way with the file-browser extension, but something changed along the way and
  these are now sorted in relevancy order (which in general is exactly what you
  want from a fuzzy finder, but order matters here because I want to scan
  through all, say, one-on-ones with the same person in chronological order
  which I should be able do based on the filename).
- It needs more tools, especially to manage tags and to link easily to other
  entries. Extending Telescope looks promising and I may end up writing my own
  tools as my Neovim and Lua knowledge grows.
- It would be nice to be able to link to images. If this could be made efficient
  it really would make the system somewhat complete.

## Alternate approaches

- You can probably do what I've done here with a good snippet tool. Snippets
  will definitely be useful for working with common text within entries and I'm
  sure I will add some of those, but I did not know if snippets can create new
  files.
- There are Vim plugins that I'm sure would meet my needs (e.g. Vim-OrgMode),
  but I also wanted to write a NeoVim plugin to learn what that was all about
  and given that my needs were relatively simple I decided to just do that.

## Inspiration

I have cycled through many, many note taking systems and I keep coming back to
plain text files, nowadays using Markdown, for keeping notes. Why?:
- Using plain text does not put me at the mercy of propriety formats.
- I am not subject to being stuck in tools that are no longer evolving.
- I can process, structure, organize, and move my notes however I please.

I tried a few markdown editors. They are fine, but always missing some feature
I wanted and I still felt at the mercy of a system that will likely not evolve
how I would like. Besides, I'm a Vim guy and I wanted to use Vim.

The other inspiration was the Zettelkasten method. I've been using this for a
while and I find it simple and useful, no more overthinking my note taking.

