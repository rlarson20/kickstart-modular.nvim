okay so i think i have it figured out

set leader
bootstrap lazy
load settings

load plugins, autocmds, autogroups
plugin loader will have multiple files, each for a different component (ui, notetaking, lsp, etc)
each plugin will also have a keymaps file

load keymaps
keymaps will be like this: vanilla keymaps at first, then load each plugin's keymaps from their file
register w wk
