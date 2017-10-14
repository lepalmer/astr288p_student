# Lecture 7:  TBD

## ASTROPY

A community Python Library... 

### Official references

* Home page:   http://www.astropy.org/
* Affiliated packages:  http://www.astropy.org/affiliated/
* Developers (git) : http://docs.astropy.org/en/stable/development/workflow/development_workflow.html


### Astronomical Data


* Images:  FITS files.  (a new file **ngc6503.cube.fits** was added to your astr288p_student/data directory)
  * **ds9**: http://ds9.si.edu/site/Download.html
    Supports 3D cubes: a 3D slicer comes up autmatically. 

    To bring up a spectrum, select Edit->Region, double click the region (or Region->Get Information)
    and set Analysis->Plot3D (save in Preferences -> Region -> Auto Plot 3D to make it persistent)

  * **ginga**: https://ginga.readthedocs.io/en/latest/
    Supports 3D cubes, but perhaps not as intuitive as ds9
  
* Tables  (astropy http://docs.astropy.org/en/stable/io/unified.html)
  * ascii tables
  * FITS tables
  * VO tables


### Reminder on installing software in python:

Various ways, in increasing complexity and varying degrees of success:

* conda
```
	conda install -c astropy ginga
```
* pip
```
	pip install ginga
```
* source
```
	git clone https://github.com/ejeschke/ginga.git
	cd ginga
	python setup.py install
```
Now you should test (perhaps after a **rehash** command if you use the **csh** shell) where ginga lives:
```
	which ginga
```

## Today's notebooks

* **n6503-case1** : analyzing the new ngc6503.cube.fits using astropy
* **n6503-case2** : analyzing the new ngc6503.cube.fits using radio-astro-tools (experimental)
* **n6503-orbits** : theoretical models what to expect of a galactic velocity field




