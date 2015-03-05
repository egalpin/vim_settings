vim_setup_settings
==================
Portable Vim settings including various plugins.
The plugins I claim no ownership over and have the utmost respect for their creators.  Plugins include Tim Pope's pathogen, Scrooloose's NERDTree, and more.

Tested working on:
  - Ubuntu 12.04
  - Mac OSX 10.94
    - Requires manual installation of fonts
  - Cygwin 32-bit

-----------------------------------------------------
If simply cloning:
  - Clone the repo using ```git clone https://github.com/egalpin/vim_settings.git```
  - Navigate to the cloned location
  - run ```./vimSetup.sh```
    - Note that on most systems, the script may need to be run with sudo in order to allow for compilation of dependencies (ctags)
  - Install fonts from your user's home directory i.e.```~/fonts``` folder

-----------------------------------------------------

Quick Summary of Vim commands:
===============================
  - Note that leader has been mapped to ;
  - Note that the arrow keys have been deactivated.  Only j/k/l/h will move the cursor.


Normal Mode Mappings
-----------------------------------------------------
  - ;t --> open tagbar
  - ;e --> open NERDTree
  - ;q --> stop highlighting search results (if any)
  - ;" --> place quotations around the current word
  - spacebar --> enter visual mode and highlight current word
  - \<ctrl\> w --> toggle line wrap
  - ;r --> toggle relative numbers
  - ;n --> toggle line numbers
  - ;sv --> source ~/.vimrc, helpful for making changes on the fly
  - ;git --> refreshes all buffers, helpful for suspend vim and pulling changes from git
  - ;c --> remove colour column, helpful if using multiple languages with differing line length standards
  - \<ctrl\> p --> run the Vim plugin "CtrlP" (found here:  https://github.com/kien/ctrlp.vim)
  - ;bd --> close current buffer using bbye (found here:  https://github.com/moll/vim-bbye)
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
  
