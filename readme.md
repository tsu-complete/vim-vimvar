
vim-vimvar
===
> reliable/compatible var storage for viml

Use
---

```viml
runtime ./vimvar.vim

call VarSave("key", "value")

let somevar = VarRead("key")
```

