Lecture 2:  More on UNIX
================


## Updating your *astr288p* repo
Any time you need to update your **astr288p** git repo, the **git pull** command will do this:
```
   cd ~/ASTR288P/astr288p_student      # make sure you are in one of the 'astr288p' directories
   git status                 		   # first make  sure you don't have anything modified
   git pull                            # warnings are possible here if there are conflicts
```
it would actually warn you if you had modified files that are also modified on the server. It will
attempt a merge and warn you.  Files that you modified and are not modified on the server

## Creating Files:

Although it does not matter where you do this, let us keep class files in **~/ASTR288P**:
```
  cd ~/ASTR288P
  mkdir lecture2
  cd lecture2
```
  1) **touch**   (Zero Length file)
```
     touch Data0.txt
     mkdir data0.txt          (testing case sensitivity)
```
  **Q2-1**: Notice on a Mac this last **mkdir** may have failed. Can you see why?
  
  2) **echo**
```
     echo Hello1   >  Data1.txt
     echo Hello2   >  Data1.txt
     echo Hello3  >>  Data1.txt
```
 **Q2-2**: Display the contents of this file using **cat Data1.txt**
  
  3) **cat**
```
     cat > Data2.txt
     1 2 3
     2 3 5
     3 4 7
     ^D                       (a.k.a. EOF - ^C also works, but ^Z will confuse you)
     cat >> Data2.txt
     4 5 9
     5 6 12
     6 7 14
     ^D
```
  **Q2-3**: How do you display what is in the file **Data2.txt**
  
  4) your favorite **$EDITOR**
```
     emacs     (C-x C-c)  or:   ^x^c  to exit
     vi        ( ':q!"  or "ZZ" to exit, the latter one also saves the file!!!)
     pico      (^X to exit)
     gedit     (^Q or ^W) to exit, or click on File->Quit
```
     Many editors keep a backup copy, often with a tilde (~) appended to the filename


## Viewing Files:

Many ways to view a file on the terminal:

     cat       the whole thing to the terminal
     more      paging section by section ('q' to get out, '?' to get help)
     less      "less is a better more" (/FOO   to search for the word FOO)
     tac       (reverses the lines)

     head      the first portion
     tail      the last portion

## Extracting/Reducing files:


     wc        WordCount (and line and character) count
     sum       check sum (see also md5sum)
     grep      show lines that match some pattern (cf. google and googling)

## Other File Operations:

     cp        CoPy files
     mv        MoVe files (also renaming if it's not going to another directory)
     rm        ReMove files (directories would need the -r flag, but see also mkdir)
     ln        LiNk between files (symbolic/soft vs. hard link)


## UNIX PATH

Any command typed in the terminal will find this from an executable file along the
directories in the $PATH environment variable:

```
   echo $PATH
   
   which ls
   which man
   which ds9
```


## Scripting:

Scripting in UNIX is nothing more than a few shell commands in a text file, which you can execute directly using the shell (the interpreter):

```
     echo "echo hello world" > hello.sh
     bash hello.sh
     ls -l hello

     chmod +x hello.sh
     ls -l hello  
     hello.sh
     echo $PATH
     ./hello.sh
```

## Permissions:

In the last section, we did something that made the script **executable**:

```
    chmod +x hello.sh
```

This means that we added the permission to execute the code from a shell. Other permissions are read and write, which are permissions to read and write to files. 

You can see what permissions a file has by doing
```
    ls -l
```
and looking at some example output:
```
    drwxr-xr-x  4 griffins veritas   39 Jan 30  2015 1ES1727+502
    -rw-r--r--  1 griffins veritas  66K Nov  7  2015 77470_t0.voltages
    -rw-rw-r--  1 griffins veritas  56K Nov  7  2015 77500_t0.voltages
    -rw-r-----  1 griffins veritas  12M Dec  2  2015 79564.cvbf
```
The columns are:
  - Permissions
  - Number of links to the file / directory
  - Name of owner (**user**)
  - The **group** the files belong to. Yours will be "student" or something similar. There are multiple groups that correspond to different types of user. 
   - File size.
   - Date the file was last modified. 
   - The filename

Permissions can be broken down into three sections: user, group, other. 
The first character indicates if it's a directory (**d**), the next three characters correspond to the reqd, write, and execute perimissions for the user, and similarly for the group, and then other. 

**Q2-4**: Describe the details of the above files.

### Changing permissions
For example:
```
    chmod a+x : add execute access for all users
    chmod g-x : remove write access for group memebers
    chmod o-wx : remove write and execute access for non-user, non-group memebers
```

## Finding files:

1) 'locate'    (but:   "**sudo updatedb**" - normally not enabled on Mac)
```
    locate -i poster
```
      
2)  find       (arguably one of the more complex UNIX commands)
```  
    find $HOME/Talks -name "*oster*"
```
## Tarballs

A **tarball** is a type of file archive. It is a convenient method of transporting multiple files and folders around. 

### Extracting an archive
For this example, we'll download a popular text editor called sublime_text (note that we may need to update the link if a new release is provided): 
```
    cd ~/ASTR288P       # Navigate to our working directory.
    mkdir software      # Make a new directory
    cd software         # Move to it
    wget https://download.sublimetext.com/sublime_text_3_build_3126_x64.tar.bz2 #Download the file
```
You can see that the file extansion here is .tar.bz2. The .bz2 means that the file is also **compressed**.

We can decompress the file:
```
    bunzip2 sublime_text_3<tab-complete> 
```
and then un-tar (un-archive) the tarball:
```
    tar -xvvf sublime_text_3<tab-complete>
```
The flags in being used: 
```
    x : eXtract
    v : Verbose
    v : even more Verbose
    f : Filename specifier
```
**Q2-5**:  What changes if you remove a single $$v$$ flag? 

NOTE: In practice, it is not necessary to bunzip the tarball before calling **tar -xf**; the program is smart enough to know what's going on.

### Creating an archive

To create an archive:
```
    cd ~ #go home 
    mkdir software/some_working_directory
    touch software/some_working_directory/example.log
    echo "Test pattern" > software/some_working_directory/test.log
    tar -cvvf my_tarball.tar software/
```
**Q2-6**: What are the contents of my_tarball.tar? (Someone come draw it on the board!)

## Adding to your own $PATH:

We went through the effort of downloading sublime_text, but now we need to be able to run it. 
It can be run from the directory where it was installed: 
```
    cd ~/software/sublime_text_3
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

**Q2-7**: How do you permanently add something to the $PATH?

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

See something interesting in the second file listing?



## UNIX SCRIPTS

recall: a UNIX script is nothing more than a few shell commands in a text file, which you can execute directly using
the shell (the interpreter). You do need to make that text file executable (**chmod +x**)

Recall from the previous lecture:
```
   echo echo hello world > hello
   chmod +x hello
   hello
```
**Q2-8**:  What happens if you left out the 2nd *echo* in the command that created the script?

**Q2-9**: The following shell commands do something very convoluted. How would you achieve the same result?
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

**Q2-10**:  How many modules are now installed (use basic unix tools)
  

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

**Q2-11**: What is the difference between the two **#!** versions that *appear* to do the same thing.

### plotting example
Previously we created a small dataset **Data2.txt** in the **ASTR288P** directory. This is how it should plot
on your screen

```
	astr288p/python/tabplot.py Data2.txt
```



### C compiler hello world

```
	cat hello.c

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

**Q2-12**:  cut and paste the C code into your own hello.c and compile and run this program

**Q2-13**:  observe the difference between **more** and **cat**


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
Because python also has a built-in http (web) server, you can now open a URL on
[http://localhost:6419](http://localhost:6419), or
[http://localhost:6420](http://localhost:6420) in the second case. Just make sure
to use unique port numbers.