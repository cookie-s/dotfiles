source ~/git/peda/peda.py
set follow-exec-mode same
set follow-fork-mode parent
python from libheap import *
