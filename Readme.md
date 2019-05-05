# convert_dta2018

This repository contains scripts to convert the DTA/TEI data to CWB. Courtesy of Susanne Flach (Université de Neuchâtel) and Anatol Stefanowitsch (FU Berlin), redistributed with minor modifications under GNU GPL license. 


## About the scripts

* required input: Final TCF-Release of DTA (2018)

* Conversion scripts are for everybody, GNU GPL 1.x-4.x, CC-BY-SA 2.0-4.0 (unported)
  
  2015 Version: Anatol Stefanowitsch, Freie Universität Berlin
  
  2017 Version: Susanne Flach, Université de Neuchâtel
  
  2018 Version: Stefan Hartmann, University of Bamberg (minor changes)
  Feedback and improvement suggestions welcome!

  
* Tested on a Mac OS 10.11.5 (El Capitan) and 10.12.6 (Sierra)
* For Step 3, an installation of CWB-3.0 and the base Perl support package is required
  http://cwb.sourceforge.net/download.php


<br />


## Instructions

STEP 1: Prepare
- create a folder for dta2018
- within this folder, create a folder that contains the tcf files
	files/
- make sure you also have two folders in this directory:
	newfiles/
	scripts/

STEP 2: Run wrapper script
	sh scripts/dta2017.sh

STEP 3: Convert to CWB (backslashes indicate line break that should be removed):

```
cwb-encode -c utf8 -v \\
	-d /path/to/cwb/data/folder \\
	-f /path/to/vrt/file -R /path/to/registry/dta2018 \\
	-P original -P lemma -P pos -P tokid -S s:0+id+no \\
	-S file:0+id+dtaid+year+century+decade+year_pub+year_creat+genre+author+title\\
	+sup_title+pub_place+publisher+genre_dta+subgenre_dta+genre_dwds+subgenre_dwds+\\
	types+tokens+pages+urn+url+licence+dta_collection+dta_release+dta_digitalization

	cwb-make -V DTA2018
```

