cnoremap <expr> <CR> getcmdtype() == ":" && index(["q", "wq"], getcmdline()) >= 0 ? "<C-u>" : "<CR>"
