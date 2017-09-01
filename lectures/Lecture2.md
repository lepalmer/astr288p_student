# Lecture 2:  UNIX

## Command Line unix vs. desktop unix (Graphical User Interface)

  - GUI: a dime a dozen (and new ones keep coming...)
  - GUI: Mac (aqua) and Linux (X11)
  - GUI: Linux has many many window managers
         (twm, fvwm, enlightenment, gnome, kde, unity, plasma)
  - GUI: Linux is changing from using X11 to Wayland
  - CLI: one and only one (though minor differences do remain between Mac and Linux)

Shells can be **GUI** or **CLI** shells and act as an interface to the operating system's different services.

The notes below loosely follow the tutorials in
    http://www.ee.surrey.ac.uk/Teaching/Unix/
you are recommended to walk yourself through these.

## Login shell in a terminal: 
  - xterm                  (probably the oldest terminal in X11)
  - gnome-terminal         (Gnome Terminal)
  - xfce4-terminal         (XFCE4 terminal)
  - konsole                (KDE terminal)
  - emacs "M-x shell"      (yes, you can run a terminal inside of emacs, great for logging)


### What shells can we use? 

There are many CLI shells avaialble. Some exambles:

  - bash  (sh: bourne shell)
  - tcsh  (csh: C-shell)
  - ksh   (korn shell)
  - xonsh (pythonesque shell, cf. ipython)

We will be using **bash**.

   Q2-1: how do you know which shell you are running?

   A2-1: as is often in UNIX, several answers possible, that all need human parsing
   - **echo $SHELL** 
   - **grep $USER /etc/passwd**
   - **ps**
   
   Q2-2: What are the allowed shells on your unix system?
   
   A2-2: **cat /etc/shells**

   Q2-3: If a shell is not listed in **/etc/shells**, can I still use it?

   A2-3: yes, simply run it from the current shell (a shell within a shell; see A1)

### Changing your default shell

In this class, we will use **bash**, although in the future you may decide to use another default shell.
To change your default shell, type 
```
chsh -s /bin/bash
```

For this to take effect, you need to open a new terminal!

### Shell options (as defined in /etc/passwd, see /etc/shells)
/etc/passwd contains essential information relevant for user login.
An example line: 
```
tiberius:x:5091:500:Captain Kirk:/home/tiberius:/bin/tcsh
```
There's more information here than we need for the scope of this course, but the important fields are
  - tiberius : User name.
  - x is the password (it always comes up as 'x'; the actual encrypted password is stored elsewhere)
  - 5091: User ID (UID)
  - 500: Group ID (GID); we'll come back to this one later when we discuss file permissions
  - Captain Kirk: This is a comment field.
  - /home/tiberius/ : Path to a user's home directory when they log in.
  - /bin/tcsh : This means that on login shell /bin/tcsh is used. This can also be a command, as opposed to a shell.

CAVEAT: MacOS does not seem to use /etc/passwd (see http://docstore.mik.ua/orelly/unix3/mac/ch03_08.htm)


### Persistent shells with session management (cf. VNC)
If you don't need a full graphical interface, and still want to login to server (e.g. ursa) and maintain your session, use any of the following programs

  - screen        (often comes with UNIX)
  - tmux          (and there are more)

**screen** is useful if (e.g.) you have some code taht takes a long time to execute and you don't want to have to keep the termainal open (say, if you're getting on an airplane).

## bash
We differentiate between an *interactive*  and *login* shell. They are controlled by one or more startup ("rc") files:
   * login:
      * /etc/profile
      * ~/.bash_profile
      * ~/.bash_login
      * ~/.profile
   * interactive
     * /etc/bash.bashrc
     * ~/.bashrc

  Some of your personal files may already be present when your account was activated. Use
  the **ls -a** command to see these hidden (files starting with a dot) files.

  Q2-4:  With the **ls -a** command you will also see **.** and **..**    what are those?

  A2-4:  The current directory **.** and the parent directory **..**

### Linux and Mac philosophy on interactive and login shells different?

This is often source of confusion and discussed online
(e.g. see http://unix.stackexchange.com/questions/119627/why-are-interactive-shells-on-osx-login-shells-by-default)

Here's a summary for Linux and Mac, and when they read the startup files (WARNING: they are not the same!)

```
  linux>  ssh localhost                                 # login
  	  bash: .bash_profile                           # Q: what about .bash_login and .profile?
	  tcsh: .cshrc .login                           # in that order
	  
  linux>  xterm (or open a gnome-terminal)              # interactive
  	  bash: .bashrc
	  tcsh: .cshrc

  mac> ssh localhost                                    # login (enable in System Preferences -> Sharing -> Remote Login)
       -> .bash_profile

  mac> Terminal  (CMD-N)                                # login
       -> .bash_profile                                 # if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
       bash                                             # interactive
       -> .bashrc 
```

If you use the **csh** variety, the **.login** and **.cshrc** files control which one is read for what type of session.

## Files and Directories - Part 1:

```
  ls                  LiSt files
  pwd                 Print Working Directory
  whoami              Isn't that obvious?
```

## How to get more help for a given COMMAND:
(this obviously means you know the name of the COMMAND)

```
  COMMAND --help
  COMMAND --version
  man COMMAND
  info COMMAND

  which COMMAND
  whatis COMMAND
  apropos COMMAND
  <google>
```  

  Q2-5: man pages have sections (the -s option) to narrow down search

## Files:  the "ls" command

```
  ls -l   # l for long 
  ls -al # all long
  ls -lt # long, sort by modification time
  ls -ltr # long, sort by modification time, reverse order
  ls -lt | tac 
  ls --full-time #what does this one do? 
```
  Q2-6:  What is the '|' symbol doing? 

  Q2-7:  What is the 'tac' command?

  Q2-8:  What are '.' and '..' ?


## Directories:

```
  pwd
  mkdir ASTR288P
  cd ASTR288P            (try typing just 'A' or "AS" and then <TAB>-complete)
  pwd
```

## git: sharing your codes: a first encounter

We will come back to **git**, but the following commands will download the "astr288p" repository of codes and documentation that are helpful for this class.
```
  git clone https://github.com/SeanCGriffin/astr288p_student
  ls
  cd astr288p_student
  ls -la
```
But wait -- there's nothing but the course outline in the repository!

I need to add the correct files to the repository.

```
    git add lectures/Lecture2.md
    git commit
    git push
```

Now, if we do 
```
    git pull
```

you should be able to see this doucment!

This **Lecture2.md** file is the file you are reading now. Most humans can read it, but it does read a little nicer once it has been formatted by a web browser, instead of straight to the terminal! Or you can read it directly on github on
https://github.com/SeanCGriffin/astr288p_student/blob/master/lectures/Lecture2.md
  less lectures/Lecture2.md

## Creating Files:

Although it does not matter where you do this, let us keep files in **~/ASTR288P**:
```
  cd ~/ASTR288P
```
  1) **touch**   (Zero Length file)
```
     touch Data0.txt
     mkdir data0.txt          (testing case sensitivity)
```
  Q2-9: Notice on a Mac this last **mkdir** may have failed. Can you see why?
  
  2) **echo**
```
     echo Hello1   >  Data1.txt
     echo Hello2   >  Data1.txt
     echo Hello3  >>  Data1.txt
```
  Q2-10: Display the contents of this file using **cat Data1.txt**
  
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
  Q2-11: How do you display what is in the file **Data2.txt**
  
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

**Question**: Describe the details of the above files.

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
    cd ~/               # Navigate home
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
**Question**:  What changes if you remove a single $$v$$ flag? 

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
**Question**: What are the contents of my_tarball.tar? (Someone come draw it on the board!)

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

**Question**: How do you permanently add something to the $PATH?

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





