# Weenix(i386) meets macOS (Intel and Apple silicon)

## Preparation

We will use [brew](https://brew.sh/) to install necessary packages. (This is only for simplicity, some of the packages can be installed by [port](https://www.macports.org/install.php) as well.)

### miscellaneous

```
brew tap nativeos/i386-elf-toolchain
brew install nativeos/i386-elf-toolchain/i386-elf-binutils
brew install nativeos/i386-elf-toolchain/i386-elf-gcc
brew install nativeos/i386-elf-toolchain/i386-elf-grub
brew install qemu cscope xorriso coreutils binutils
```

### gdb with python2

#### older macOS with builtin python2

```
cp i386-elf-gdb@11.1-system_python2.rb $(brew tap-info nativeos/i386-elf-toolchain | grep -o "^/\S*")"/Formula/i386-elf-gdb@11.1.rb"
brew install nativeos/i386-elf-toolchain/i386-elf-gdb@11.1
```

#### newer macOS without builtin python2

Install python2 using [port](https://www.macports.org/install.php): `sudo port install python27`

```
cp i386-elf-gdb@11.1-port_python2.rb $(brew tap-info nativeos/i386-elf-toolchain | grep -o "^/\S*")"/Formula/i386-elf-gdb@11.1.rb"
brew install nativeos/i386-elf-toolchain/i386-elf-gdb@11.1
```

### finally

Copy `Global.mk` and `weenix-mac` to your weenix directory.

## Basics

### compile weenix

`export PATH="$(brew --prefix coreutils)/libexec/gnubin:$(brew --prefix binutils)/bin:$PATH"`

`make`

### invoke weenix

`./weenix-mac n` (equivalent to `./weenix-mac -n`)

### debug weenix

Keep `GDBWAIT=0`.

#### original approach

`brew install xquartz`

`./weenix-mac d` (equivalent to `./weenix-mac -n -d gdb`)

#### using tmux

`brew install tmux` and copy `weenix-tmux-debug-mac` to your weenix directory.

`./weenix-tmux-debug-mac`

#### using two terminals

In one terminal: `./weenix-mac l` (equivalent to `./weenix-mac -n -d gdb -y`)

In another terminal: `./weenix-mac a` (equivalent to `./weenix-mac -d gdb -x`)

## Extra stuff

### show not_yet_implemented

`brew install findutils`

`export PATH="$(brew --prefix findutils)/libexec/gnubin:$PATH"`

`make nyi`

### invoke/debug weenix without video output

Add option `-t` (e.g. `./weenix-mac n -t`)

### paste to weenix

open `paste_to_weenix.applescript` and run.

### show the stack you actually want when you get a kernel/user page fault

(gdb) `source real_stack.py`

### build with Sublime Text

Create a new Build System and copy content from `weenix.sublime-build` or `cp weenix.sublime-build "$HOME/Library/Application Support/Sublime Text 3/Packages/User"`.

Press `⌘`+`B` to build or clean.

Press `⌘`+`⇧`+`B` to reselect default action.

### launch weenix in background when debugging (not becoming frontmost window)

Install [QEMUBackground](https://github.com/brendonjkding/QEMUBackground).
