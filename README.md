# vim-solidity

Syntax files for [Solidity](https://github.com/ethereum/solidity), the
contract-oriented programming language for Ethereum.

This repo has been forked from [tomlion's repo](https://github.com/tomlion/vim-solidity). It seems that the repository has been abandoned so I figured I would pick it up and improve my regex game :)

I intend to use this tool daily, so expect updates! PRs are also welcome.

## Support this project and get a cool robot!

<table border="0"><tr>  <td><a href="https://gittron.me/bots/0xb2e10218078f44cc16611cb8f31fb4ee"><img src="https://s3.amazonaws.com/od-flat-svg/0xb2e10218078f44cc16611cb8f31fb4ee.png" alt="gittron" width="50"/></a></td><td><a href="https://gittron.me/bots/0xb2e10218078f44cc16611cb8f31fb4ee">SUPPORT US WITH GITTRON</a></td></tr></table>

## Improvements over the old repo:

- assembly syntax highlighting
- natspec syntax
- more extensive color scheme
- scientific number notation (1e18 used much anyone?)
- constructor keyword highlighting
- calldata highlighting
- typecase highlighting
- abi keyword added
- anonymous & indexed event modifiers includes
- reserved words give errors
- overall more extensive and detailed syntax highlighting
- various bug fixes

## Before and After Example (new on left old on right)

![vim-solidity before & after](https://i.imgur.com/mmfron7.png)

## Installation

**Important:** If you are using `vim-polyglot` make sure to disable the default syntax provider for solidity:

```
let g:polyglot_disabled = ['solidity']
```

If you do not do this, you will be using a combination of the old tomlion repo and this new repo. You will get some strange syntax...

### Pathogen

Run the following command:

```bash
git clone https://github.com/TovarishFin/vim-solidity.git ~/.vim/bundle/vim-solidity
```

### Vundle

Add the following line to your `~/.vimrc`:

```vim
Plugin 'TovarishFin/vim-solidity'
```

### Plug

Add the following line to your `~/.vimrc`:

```vim
Plug 'TovarishFin/vim-solidity'
```

### No Plugin Manager

Copy all of the files manually into your `~/.vim`.
