# Vim Key Mappings

Leader key is `<Space>`.

## Navigation

| Key | Action |
|---|---|
| `<Space><Space>` | Switch between the last two files |
| `C-h` `C-j` `C-k` `C-l` | Navigate between vim/tmux panes seamlessly |
| `vv` | Open vertical split |
| `ss` | Open horizontal split |
| `<Space>-` | Zoom current pane (maximize) |
| `<Space>=` | Re-balance all panes |

## File Explorer (NERDTree)

| Key | Action |
|---|---|
| `C-\` | Toggle NERDTree / reveal current file |

## Fuzzy Finder (CtrlP)

| Key | Action |
|---|---|
| `<Space>t` | Open CtrlP file finder |
| `<Space>b` | Search open buffers |
| `<Space>m` | Search most recently used files |

## Search

| Key | Action |
|---|---|
| `K` | Search current word with Ag (Silver Searcher) |
| `//` | Clear current search highlight |
| `<Space>hl` | Toggle search highlighting on/off |

## RSpec (via tmux runner)

| Key | Action |
|---|---|
| `<Space>rs` | Run current spec file |
| `<Space>rn` | Run nearest spec |
| `<Space>rl` | Run last spec |
| `<Space>ra` | Run all specs |

## Code Quality (via tmux runner)

| Key | Action |
|---|---|
| `<Space>ru` | Run Rubocop on project |
| `<Space>rfu` | Run Rubocop on current file |
| `<Space>fl` | Run Flog on current file |

## ERB Templates

| Key | Mode | Action |
|---|---|---|
| `C-k` | Insert | Insert `<%= %>` tag |
| `C-j` | Insert | Insert `<% %>` tag |

## Clipboard

| Key | Action |
|---|---|
| `<Space>y` + motion | Copy to system clipboard (e.g., `<Space>yw` copies a word) |
| `<Space>p` | Paste from system clipboard |

## Tabs

| Key | Action |
|---|---|
| `Shift-t` | Open new tab |
| `Shift-Tab` | Go to next tab |

## Completion

| Key | Mode | Action |
|---|---|---|
| `Tab` | Insert | Autocomplete (or insert tab at beginning of line) |
| `Shift-Tab` | Insert | Next completion |

## Other

| Key | Action |
|---|---|
| `<Space>vr` | Reload vim configuration |
| `<Space>ct` | Generate ctags for the project |
| `<Space>gs` | Open Git status (fugitive) |
