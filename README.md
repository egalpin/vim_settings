vim_setup_settings
==================
Portable Vim settings including various plugins.
The plugins I claim no ownership over and have the utmost respect for their creators.  Plugins include Tim Pope's pathogen, Scrooloose's NERDTree, and many more.

__This repo makes use of [apt-vim](https://github.com/egalpin/apt-vim) to install packages__

Tested working on:
  - Ubuntu 12.04, 14.04
  - Mac OSX 10.9.4, 10.10.2

Installation
===================

###Option 1 - Automatic
Execute:

    curl -fSsL https://raw.githubusercontent.com/egalpin/vim_settings/master/vimSetup.sh|sh

* Set the terminal font to one of the `Powerline` compatible fonts
  - If no `Powerline` fonts are available, try to manually install fonts from your user's `.fonts` directory i.e.```~/.fonts``` folder if 
* (Optional) If using Vdebug (included) and debugging on a virtual machine, you'll need to fill out the ```path_maps``` section of Vdebug in your .vimrc (/home/your_username/.vimrc)
    - Maps should be in the form of (using vagrant VM as an example): '/home/vagrant/guest/path/to/your/dir': '/home/your_username/host/path/to/your/dir'

###Option 2 - Manual
1. Clone this repo: ```git clone https://github.com/egalpin/vim_settings.git```
2. Change to the cloned directory: ```cd vim_settings```
3. Run ```./vimSetup.sh```
    - Be aware that you will need sudo privileges to complete the full installation in order to ```make``` some of the depencies such as ctags
4. Set the terminal font to one of the `Powerline` compatible fonts
  - If no `Powerline` fonts are available, try to manually install fonts from your user's `.fonts` directory i.e.```~/.fonts``` folder if 
5. (Optional) If using Vdebug (included) and debugging on a virtual machine, you'll need to fill out the ```path_maps``` section of Vdebug in your .vimrc (/home/your_username/.vimrc)
    - Maps should be in the form of (using vagrant VM as an example): '/home/vagrant/guest/path/to/your/dir': '/home/your_username/host/path/to/your/dir'


Quick Summary of Vim commands:
===============================
  - Note that leader has been mapped to ;
  - Note that the arrow keys have been deactivated.  Only j/k/l/h will move the cursor.


Normal Mode Mappings
-----------------------------------------------------
  - ;t --> open tagbar
  - ;E --> open NERDTree
  - ;n --> stop highlighting search results (if any)
  - spacebar --> enter visual mode and highlight current word
  - ;v --> source ~/.vimrc, helpful for making changes on the fly
  - ;r --> refreshes all buffers, helpful for suspend vim and pulling changes from git
  - ;c --> remove colour column, helpful if using multiple languages with differing line length standards
  - \<ctrl\> p --> run the Vim plugin "CtrlP" (found here:  https://github.com/kien/ctrlp.vim)
  - ;d --> close current buffer using bbye (found here:  https://github.com/moll/vim-bbye)
  - \<ctrl\> j/k/l/h --> navigate windows in current tab
  - QQ --> quit tab without saving more recent changes
  - WQ --> quit tab but save current changes first


Insert Mode Mappings
-----------------------------------------------------
  - jk --> exit insert mode
  - \<ctrl\> u --> set current word characters to all UPPERCASE
  - \<ctrl\> l --> set current word characters to all lowercase
  - \<ctrl\> d --> delete contents of line and begin inserting at start
  - \<ctrl\> b --> delete one word backwards (like db, but availabe in insert mode)


<b>Visual Mode Mappings</b>
-----------------------------------------------------
  - \<ctrl\> h --> starts a find/replace sequence for the highlighted selection

TONS more mappings, check out .vimrc for more :-)
  
