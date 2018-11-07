# effix

Test your local changes before commit.

[![Build Status](https://travis-ci.org/alexmanno/effix.svg?branch=master)](https://travis-ci.org/alexmanno/effix)
[![GitHub license](https://img.shields.io/github/license/alexmanno/effix.svg)](https://github.com/alexmanno/effix)
[![GitHub stars](https://img.shields.io/github/stars/alexmanno/effix.svg)](https://github.com/alexmanno/effix/stargazers)

## Installation
```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/alexmanno/effix/master/tools/install.sh)"
```

## Update
```sh
~/.effix/tools/update.sh
```

## Usage
### First time
```sh
effix init # create .effix.conf file
```

### Test your files
```sh
effix test # test files
```

### Use recipes
You can edit your .effix.conf and use recipes.
To discover all the recipes:
```sh
effix recipes # show recipes
```

## Troubleshooting
If effix is a "command not found" you can try to run
```sh
export PATH="$PATH:$HOME/bin/"
```
