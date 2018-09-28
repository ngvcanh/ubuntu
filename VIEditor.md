# VI Editor

## 1. Action file

Quit: `:q` or `:q!`

Save file: `:w`

Save and quit file: `:x`

Enable insert mod: `i`

Disable insert mod: `[ESC]`

## 2. Line

Go to line 15: `:15`

Delete line 15: `:15d`

Delete from line 15 to line 30: `:15,30d`

## 3. Fix error arrow and backspace

Create file Config

```
sudo vi ~/.vimrc
```

Insert content

```
set nocompatible
set backspace=2
```