Lecture 3:  Remote sessions, manipulating your $PATH, login scripts
================

## Remote Access 

### Remote login

TO remotely connect to another machine via a terminal, we use **ssh**:
```
	ssh user@remote
```

If properly configured, ssh can also be used to forward graphical information. 
This can be tested using (e.g.) **xeyes** or **xclock**
```
	ssh user@remote
	xeyes
	xclock
```

Running an ssh remote session is like having a terminal directly on that machine. 
Recall that your $HOME directory is actually a network drive mounted on another machine (ursa)
When installing software (like we will shortly), it is much faster to log into ursa for the installation, because files do not need to be passed over the network (which is much slower than having direct drive access).

To be seen later: **screen**, **VNC**

### Remote file transfer

If you want to move files from one computer to another, there are several tools we can use. 
Arguably the simplest is **scp** (**s**ecure **c**o**p**y).

To copy a file to a remote machine, we do
```
	scp file user@remote:/path/to/remote/destination
```
We can also do this to entire directories using the **-r** flag (**r**ecursive).

You can also use scp to copy files from a remote machine to a local machine:
```
	scp user@remote:/path/to/target /path/to/local/destination
```

There are other commands, like **rsync** which offer effectively the same product, but have more features (e.g. resuming transfers, progress bars, etc.)


## Adding to your own $PATH:

We went through the effort of downloading sublime_text, but now we need to be able to run it. 
As we saw last week, it can be run from the directory where it was installed: 
```
    cd ~/ASTR288P/software/sublime_text_3
    ./sublime_text
```
but what if we want to open it from somewhere else? 
In Unix, executtables must be located in your $PATH in order to be seen by the command line.
```
    echo $PATH
```
We can add directories to the path 
```
    export PATH=~/software/sublime_text_3/:${PATH}
```

**Q3-1**: How do you permanently add something to the $PATH?

## Variables

In many shells, there are a dumber of variables designed to make life easier

  - $HOME -- The path to your home directory
  - ~ (tilde) -- This is an alias to $HOME
  - $PWD -- **P**ath **W**ith **D**irectory
  - $PATH -- The list of locations of all the different executables on your system
  - ...
 
### Creating new variables  

In bash, 
```
    export WORKDIR=${HOME}/some/long/path/to/avoid/typing
```
allows you to quickly access the directory in question via (e.g.)
```
    cd $WORKDIR
```
### Aliasing

You can also **alias** commands for shortcuts. For example:
```
alias grep="grep -n --color=auto"
```
Now, when **grep** is called, it calls it with the **-n** and **--color** flags. 

## Links

Linking files is like have a convenient shortcut available, e.g.

```
  ln -s /etc/passwd               # soft link (can go across devices)
  ls -l passwd
  head passwd

  rm passwd
  ln /etc/passwd                  # hard link (must be on same device)
```

Did you get an error in the last attempt?  if you, you are likely trying this across to another device. The **df** command
tells your devices, or on what device a file lives

```
  df .
  df /etc/passwd

  df
```

Lets try this again

```
  ls -l ~/.bashrc 
  ln ~/.bashrc dot-bashrc
  ls -l ~/.bashrc 
```


## UNIX SCRIPTS

recall: a UNIX script is nothing more than a few shell commands in a text file, which you can execute directly using
the shell (the interpreter). You do need to make that text file executable (**chmod +x**)

Recall from the previous lecture:
```
   echo echo hello world > hello
   chmod +x hello
   hello
```
**Q3-2**:  What happens if you left out the 2nd *echo* in the command that created the script?

**Q3-3**: The following shell commands do something very convoluted. How would you achieve the same result?
```
   echo '#! /bin/bash' >> hello
   tac hello  > hello1
   mv hello1 hello
   chmod +x hello
```   
   

## PYTHON

The python language often comes natively on your UNIX system.
Try the following commands in **ipython** (or **python** if you don't have **ipython** yet):
```
   LAPTOP> which python
   LAPTOP> which ipython
   LAPTOP> ipython
   In [1]:  import numpy
   In [2]:  import scipy
   In [3]:  import astropy
   In [4]:  import astroML
   In [5]:  import admit
   In [6]:  quit
```
At some point you might see the message **no module named '...'**


   
## Anaconda and Miniconda

**Miniconda** is a very barebones version of python which you can then tailor to your own needs. See also
http://conda.pydata.org/miniconda.html.
If you need more, download the full **Anaconda** version. With this you also get a nice graphical install.
See https://www.continuum.io

### On Linux:
```
  df .
  wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh 
  bash Miniconda3-latest-Linux-x86_64.sh
```

Make sure you do these commands on a locally mounted disk, not NFS (network) mounted!

### On Mac:
```
  curl https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh > Miniconda3-latest-MacOSX-x86_64.sh 
  bash Miniconda3-latest-MacOSX-x86_64.sh
```
and now in common to both Linux and Mac you will answer some questions and at the end
a modification to your **~/.bashrc** file (linux) or **~/.bash_profile** (mac) will be made.
```
  export PATH="$HOME/miniconda3/bin:$PATH"
or
  setenv PATH "$HOME/miniconda3/bin:$PATH"
```
And now make sure your shell is looking at this new python (e.g. **source ~/.bashrc** for your current shell, or open a new shell):
```
  which python
```
Now continue installing some modules that we will need for future lectures
```
  conda install ipython numpy scipy matplotlib notebook ipywidgets networkx
  conda install astropy
  conda install jupyter

```

See what modules you have installed:
```
  conda list
```

**Q3-4**:  Excercise: How many modules are now installed? Hint: 
  

### "Hello World!" in python

```
	echo 'print("Hello World!")' > hello.py
	python hello.py
```	

Following on our previous **"#!"** example we can avoid having to type the name **python** :
```
	#! /usr/bin/python
	#
	print("Hello World!")
```
or even more general
```
	#! /usr/bin/env python
	#
	print("Hello World!")
```

**Q3-5**: What is the difference between the two **#!** versions that *appear* to do the same thing.



### C compiler hello world

```
	emacs-nw hello.c

	#include <stdio.h>

	void main() 
	{
	  printf("Hello World from C!\n");

	}

	gcc -o helloc hello.c
	ls -l hello.c
	ls -l helloc
	helloc
	more helloc
	cat helloc

```

**Q3-6**:  Cut and paste the C code into your own hello.c and compile and run this program

**Q3-7**:  observe the difference between **more** and **cat**


## GRIP

GitHub Readme Instant Preview (GRIP): a command that allows you to preview your
[*MarkDown*](https://en.wikipedia.org/wiki/Markdown) files (README.md
by default) in a web browser. These lecture notes are in md
(*MarkDown*) format, they are simple text files that are a lightweight markup
language, and they format nicely in a web brosers.

Install and use it as follows
```
   pip install grip
   grip Lecture2.md
   grip Lecture3.md localhost:6420
```
pip is just another package manager, like when we did **conda install** previously.
Some packages need to be installed via **pip**, but always try **conda install** first. 

Because python also has a built-in http (web) server, you can now open a URL on
[http://localhost:6419](http://localhost:6419), or
[http://localhost:6420](http://localhost:6420) in the second case. Just make sure
to use unique port numbers.