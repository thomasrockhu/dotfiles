#!/usr/bin/env python

from optparse import OptionParser
from os import listdir
from os import remove
from os.path import basename
from os.path import dirname
from os.path import expanduser
from os.path import exists
from os.path import join
from subprocess import call

VERSION = "1.0.0"

HOME_DIR = expanduser("~")
DOTFILE_DIR = join(HOME_DIR, "dotfiles")
VIM_BUNDLE_DIR = "vim/bundle"

# tuple[0] is HOME_DIR path
# tuple[1] is DOTFILE_DIR path
PATHS = {
    'vimrc': ('.vimrc', 'vimrc'),
    'zshrc': ('.zshrc', 'zshrc'),
    'tmux_conf': ('.tmux.conf', 'tmux_conf'),
    'tmux_date': ('.tmux.date.conf', 'tmux_date'),
    'ackrc': ('.ackrc', 'ackrc'),
}

VIM_PLUGIN_REPOS = [
    "https://github.com/kien/ctrlp.vim.git", # Semantic Analyzer
    "https://github.com/Raimondi/delimitMate.git",
    "https://github.com/Shougo/neocomplete.vim.git", # Autocomplete
    "https://github.com/scrooloose/nerdcommenter.git", # Comment helper
    "https://github.com/scrooloose/nerdtree.git", # File browser
    "https://github.com/ervandew/supertab.git", # Tab helper
    "https://github.com/scrooloose/syntastic.git", # Synatx checker
    "https://github.com/majutsushi/tagbar.git", # Ctags side bar
    "https://github.com/bling/vim-airline.git", # PowerLine
    "https://github.com/altercation/vim-colors-solarized.git", # ColorScheme
    "https://github.com/tpope/vim-fugitive.git", # Git Tools
    "https://github.com/mhinz/vim-signify.git",
    "https://github.com/Shougo/vimproc.vim.git",
]

def get_home_path(filename):
    return join(HOME_DIR, PATHS[filename][0])

def get_dotfile_path(filename):
    return join(DOTFILE_DIR, PATHS[filename][1])

def clean_home_dotfiles(warn=False):
    if warn:
        def user_approval():
            choice = raw_input("Warning: Deleting existing dotfile configs in home directory. Proceed? (Y/N) ")
            if choice.lower() == 'y':
                return True
            elif choice.lower() == 'n':
                return False
            else:
                return user_approval()

        if not user_approval():
            return False

    print "Cleaning dotfiles..."
    for filename in PATHS.keys():
        home_file = get_home_path(filename)
        if exists(home_file):
            remove(home_file)

    return True

def install_dotfiles():
    print "Installing Oh-My-ZSH..."
    # Setup oh-my-zsh
    call(["curl", "-L", "http://install.ohmyz.sh", "|", "sh"])

    print "Installing Pathogen..."
    # Setup Pathogen
    pathogen = join(DOTFILE_DIR, "vim/autoload/pathogen")
    call(["curl", "-L", "https://tpo.pe/pathogen.vim", "-o", pathogen])

    print "Setting up Symlinks..."
    # Setup Symlinks
    for filename in PATHS.keys():
        home_fn = get_home_path(filename)
        dotfile_fn = get_dotfile_path(filename)
        call(["ln", "-sF", dotfile_fn, home_fn])

    print "Cloning Vim plugins..."
    # Clone vim plugins
    vim_bundle = join(DOTFILE_DIR, VIM_BUNDLE_DIR)
    for repo_url in VIM_PLUGIN_REPOS:
        call(["git", "clone", repo_url, "--template", vim_bundle])

    print "Installation Complete"

def update_plugins():
    print "Updating Vim Plugins..."
    root_path = join(DOTFILE_DIR, VIM_BUNDLE_DIR)
    plugin_paths = listdir(root_path)
    for plugin in plugin_paths:
        call(["cd", root_path, plugin, ";", "git", "pull", ";"])
    print "Update Complete"

def setup_option_parser():
    parser = OptionParser(usage=("Usage: %s [options] [command]" % (basename(__file__))),
                          description="MazMachine's Dotfile Manager",
                          version=VERSION)
    parser.add_option("-i", "--install",
                      action="store_true",
                      help="Install dotfiles to home directory")
    parser.add_option("-c", "--clean",
                      action="store_true",
                      help="Clean Home Directory Dotfiles")
    parser.add_option("-u", "--update",
                      action="store_true",
                      help="Update plugins")
    return parser

def main():
    option_parser = setup_option_parser()
    options, args = option_parser.parse_args()

    if options.install:
        clean_home_dotfiles(warn=True)
        install_dotfiles()
        update_plugins()
    elif options.clean:
        clean_home_dotfiles()
    elif options.update:
        update_plugins()
    else:
        option_parser.print_help()


if __name__ == '__main__':
    main()
