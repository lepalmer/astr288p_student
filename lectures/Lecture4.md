Lecture 4:  PYTHON
==================


## Updating your *astr288p* repo

Remember to always update your git repo for this class. New material is added weekly.
```
   cd ~/ASTR288P/astr288p      # make sure you are in one of the 'astr288p' directories
   git status                  # first make  sure you don't have anything modified
   git pull                    # warnings are possible here if there are conflicts
```

## References

* Unix Shell : http://swcarpentry.github.io/shell-novice/
* Python : http://swcarpentry.github.io/python-novice-inflammation/
* PSL :   https://swcarpentry.github.io/python-second-language/

## Python 

In the previous lecture we installed our own version (miniconda3) of Python. Make sure
you have the right version using the **which** command!   There are at least 4 ways you
may wind up running python:

    1. python: the script interpreter

```
	python
	which python
```

Normally never used interactively, but python scripts normally start with
```
	 #! /usr/bin/env python
```
so you can use them just like another unix command on the terminal/command line.
(see also the **hello world** python example from the previous lecture)

     2. ipython: interactive python
```
	ipython
	alias i=ipython
	which ipython
```	
This is the way to quickly try something out.

     3. graphical user interface

Here there are quite a few options, most of them have *introspection-based code completion* and *integrated debugger*

    * PyCharm
    * KDevelop
    * PyDev (eclipse)
    * Spyder (anaconda)
      You can install this:   *conda install spyder*

We will not be using these in this class, but it can be a great way for development.

     4. jupyter: web interface

```
	ipython notebook
	jupyter notebook
	which jupyter 
	
```	

Now watch your default browser opening a new tab. Navigave to your **astr288p/notebooks** folder, where
you should see some *ipynb* files.  The rest of this lecture will be taking place in the notebooks.

We will start with **01-intro.ipynb**

Apart from the [Software Carpentry](http://software-carpentry.org) lessons, a comprehensive python
tutorial that we often will come back to is on https://www.tutorialspoint.com/python/index.htm
