# dta2vrt

# This script converts tcf files from the Deutsches Textarchiv to the vrt format
# needed to produce cwb/cqp corpora. IMPORTANT: the script expects newlines before
# all opening tags and before closing </TextCorpus> tags and it expects all other 
# tags to be exactly as they are in the DTA files. The following script will produce 
# exactly the input that dta2vrt likes.

# while (<>) {
#	s/(<[^\/])/\n\1/gs;
#	s/(<\/TextCorpus>)/\n\1/gs;
#	print $_;
#	}


# Version v2018.pl

# 2019-19-01, Stefan Hartmann, GNU GPL 1.x-4.x, CC-BY-SA 2.0-4.0 (unported)
# Differences to previous:
# - The original transliteration rather than the normalized text
#   is now used as the base level as the normalized text tends to 
#   level out variation phenomena that can be interesting from a
#   historical-linguistic perspective. 

# 2017-11-10, Susanne Flach, GNU GPL 1.x-4.x, CC-BY-SA 2.0-4.0 (unported)
# Differences to previous:
# - Removed the internal tag. I really can't remember what we needed it for in the
#   first place other than having to remove it later on.
# - Adjusted to xml document structure of DTA 2017 release (tcf files)
# - Extracted more meta data from the original files
# - Script also works without the conversion with newlines in lines 9-13 above
# Note: should be run on each file individually. Otherwise *this* version gets confused
#    (I have not figured out why, but it mixes token IDs and returns wrong p-attributes.)
#    i.e., for i in files/* ; do perl scripts/dta2vrt_v2017.pl <$i; done > dta2017a.txt

# Version 0.5a

# (c) 2015 by Anatol Stefanowitsch, GNU GPL 1.x-4.x, CC-BY-SA 2.0-4.0 (unported)
# You are free to use, modify and distribute this work, provided that you
# retain (at least one of) the above licences for the original and all derivative 
# works. For example, you can strip out the silly comments.

# Differences to 0.4:
# - Now handles multiple files as input.
# - corrected an error that caused the DWDS genre to be used both for genre and
# subgenre

# Differences to 0.3:
# - now also creates an internal meta-information tag with the year, the url, the
#   number of tokens and the licence
# - now produces the vrt output in the order
#   1: word
#   2: correction (if present, else remains empty)
#   3: lemma
#   4: pos-tag
#   5: token id

# Ok, time waits for no-one, so let us begin!

@master = ();
@words = ();

# This while-loop is our main routine, which does some initial extracting of meta 
# information for our internal tag, and then calls the subroutines that deal with 
# different parts of the document:

while (<>) {

# First, our main routine encounters the of the landing page in the DTA. This could easily
# be changed to the url pointing directly to any of the versions of the actual text.
# The routine now opens a self-closing "internal" tag, which holds information that is 
# just for us, so that we can more easily determine which files should be included 
# in our various versions of the corpus.

# The routine now prints the url into the internal tag; it also extracts the publication
# year from the filename and puts it into a year attribute to help us select texts 
#(the year is later repeated in the file tag for the actual users):

	if ($_ =~ m/<cmdp:idno type=\"URLWeb\">(.*)<\/cmdp:idno>/) {
				
		#print "<url=\"http:\/\/www.deutschestextarchiv.de\/".$1.$2."\" ";
		$url = $1;

	}

# Next, the routine encounters the number of tokens and prints it into our internal tag:

	elsif ($_ =~ m/<cmdp:measure type=\"tokens\">(.*)<\/cmdp:measure>/) {
	
		#print "tokens=\"".$1."\" ";
		$tokens = $1;

	}


# Next, the routine encounters the number of types and prints it into our internal tag:

	elsif ($_ =~ m/<cmdp:measure type=\"types\">(.*)<\/cmdp:measure>/) {
	
		$types = $1;

	}



# Next, it encounters the licence, prints it into our internal tag and closes the tag:
		
	elsif ($_ =~ m/<cmdp:licence target=\"(.*)">/) {
		
		$licence = $1;
		

	}

# Ok, enough with the preliminaries, let the real work begin already!

# The last task of the main routine before handing over to the subroutines is to extract 
# the file id, open a file tag, print the file id (note: this is the official DTA file 
# id), ...

	elsif ($_ =~ m/<cmdp:idno type=\"DTADirName\">(.*)<\/cmdp:idno>/) {
	
		print "<file id=\"".$1."\" ";

	}


	elsif ($_ =~ m/<cmdp:idno type=\"DTAID\">(.*)<\/cmdp:idno>/) {
	
		print "dtaid=\"".$1."\" ";

	}
	
# ... and do the same with the urn (leaving the file tag open for more information 
# to come:
		
	elsif ($_ =~ m/<cmdp:idno type=\"URN\">(.*)<\/cmdp:idno>/) {
		
		print "urn=\"".$1."\" ";

	}

# Now the main routine encounters the sourceDesc-section and calls the subroutine 
# get_meta_bibl which will extract the bibliographical meta information and print 
# it into the file-tag (see below):

	elsif ($_ =~ m/<cmdp:sourceDesc>/) {
	
		get_meta_bibl();

		}		

# When the get_meta_bibl subroutine is done, the main routine takes over again.

# Next, it encounters the text class information and calls the subroutine get_meta_text,
# which extracts the genre and subgenre information:
		
	elsif ($_ =~ m/<cmdp:textClass>/) {

		get_meta_text();

		}		

# When the get_meta_text subroutine is done, the main routine takes over again.

# Next it encounters the actual corpus part of the file and calls the subroutine
# format_file, that will transform the various linearized bits and pieces of xml
# into a nice and clean vrt format (which the DTA should have used all along):
		
	elsif ($_ =~ m/<TextCorpus/) {

		format_file();
		
	}

# When format_file is done, the main routine takes over for a final task, which is
# to stop running an lean back with the satisfying glow of a job well done.
		
}
	

# If a single file was processed, the perl script will now go to sleep until it is 
# awakened again by its god, the mighty command line.
# If multiple files are sent to the script (e.g. via cat), the script will continue to
# process the input, repeating until there is no more input or until the heat death
# of the universe (whichever happens first).

# Here are the subroutines that do the actual work while the main routine takes all
# the credit.

# This little subroutine extracts the meta information:

sub get_meta_bibl {
	
	while(<>) {
		
# it gets the title,...
		
		if ($_ =~ m/<cmdp:title level=\"[am]*\" type=\"main\">(.*?)<\/cmdp:title>/) {
		
			$title = $1;
			$title =~ s/(\"|&quot;)/'/g;
		
		}

# ... it gets the author(s) (it should work for multiple authors, but I haven't bothered
# to actually test this, because WHAT COULD POSSIBLY GO WRONG; ...
		
		if ($_ =~ m/<cmdp:(author)>/) {

			$auth = 1;
		
			}elsif ($_ =~ m/<\/cmdp:author>/) {
		
			$auth = 0;
		
			}
		
		if ($_ =~ m/<cmdp:surname>(.*)<\/cmdp:surname>/) {	
	
			if ($auth == 1) {
		
			$authsurname = $1;
		
			}
		
		}
	
		if ($_ =~ m/<cmdp:forename>(.*)<\/cmdp:forename>/) {
	
			if ($auth == 1) {
		
			$authforename = $1;
				
			}
			
		}	
			
		if ($_ =~ m/<\/cmdp:persName>/) {
		
			push (@authname, $authsurname.", ".$authforename);
			undef $authsurname;
			undef $authforename;
			
			}


# ... it gets the place of publication, ...
		
		if ($_ =~ m/<cmdp:pubPlace>(.*)<\/cmdp:pubPlace>/) {
		
			$pub_place = $1;
		
			}

# ... its number of pages, ...

		if ($_ =~ m/<cmdp:measure type=\"pages\">(.*?)<\/cmdp:measure>/) {
	
			$pages = $1;

		}

# ... the year of publication ...

		if ($_ =~ m/<cmdp:date type="publication">(.*)<\/cmdp:date>/) {
		
			$pub_year = $1;
			
			}
# ... the year of creation ...

		if ($_ =~ m/<cmdp:date type="creation">(.*)<\/cmdp:date>/) {
		
			$creat_year = $1;
			
			}

# ... and the publisher.
			
		if ($_ =~ m/<cmdp:publisher><cmdp:name>(.*)<\/cmdp:name><\/cmdp:publisher>/m) {
		
			$publisher = $1;
		
		}
		
		if ($_ =~ m/<cmdp:title type=\"sub\">(.*)<\/cmdp:title>/) {
		
			$sup_title = $1;
		
		}

		
# On encountering the end of the sourceDesc section, it prints the information into the
# file tag...
		
		if ($_ =~ m/<\/cmdp:sourceDesc/) {
		
			print "url=\"".$url."\" licence=\"".$licence."\" types=\"".$types."\" tokens=\"".$tokens."\" pages=\"".$pages."\" author=\"".join(";",@authname)."\" title=\"".$title."\" sup_title=\"".$sup_title."\" year=\"".$pub_year."[".$creat_year."]\" year_pub=\"".$pub_year."\" year_creat=\"".$creat_year."\" pub_place=\"".$pub_place."\" publisher=\"".$publisher."\" ";

# ... deletes the contents of the authname array (which is important, since otherwise
# each new author will simply be added to the list, resulting in multiple author 
# misattributions for subsequent files that are much worse than what you see regularly
# in papers published by NATURE, SCIENCE and other glossy popular science magazines.
			
			undef @authname;
			undef $title;
			undef $sup_title;
			undef $pub_year;
			undef $creat_year;
			undef $pub_place;
			undef $publisher;
			undef $url;
			undef $licence;
			undef $types;
			undef $tokens;
			undef $pages;

# The subroutine then hands over to the main routine again.

			return;

		}
	
	}
	
}

# This little subroutine gets the genre information and adds it to the file tag:

sub get_meta_text {

	while (<>) {

# it collect the information (see for yourself, what this is and where it gets it, 
# they don't pay me enough to explain every little detail to you):

		if ($_ =~ m/<cmdp:classCode .*#dtamain\">(.*)<\/cmdp:classCode>/) {

			$genre_dta = $1;

		}

		if ($_ =~ m/<cmdp:classCode .*#dtasub\">(.*)<\/cmdp:classCode>/) {

			$subgenre_dta = $1;

		}

		if ($_ =~ m/<cmdp:classCode .*#dwds1main\">(.*)<\/cmdp:classCode>/) {

			$genre_dwds = $1;

		}

		if ($_ =~ m/<cmdp:classCode .*#dwds1sub\">(.*)<\/cmdp:classCode>/) {

			$subgenre_dwds = $1;

		}

		if ($_ =~ m/<cmdp:classCode .*#DTACorpus\">(.*)<\/cmdp:classCode>/) {

			push (@dtastatus, $1);

		}

		elsif ($_ =~ m/<cmdp:classCode .*#DTACorpus\">(.*)<\/cmdp:classCode>/) {

			push (@dtastatus, $1);

		}

		elsif ($_ =~ m/<cmdp:classCode .*#DTACorpus\">(.*)<\/cmdp:classCode>/) {

			push (@dtastatus, $1);

		}

# On encountering the end of the textClass section, it prints the genre information into 
# the file tag, closes it and hands over to the main routine:

		if ($_ =~ m/<\/cmdp:textClass/) {

			print "genre=\"".$genre_dwds."\" genre_dta=\"".$genre_dta."\" subgenre_dta=\"".$subgenre_dta."\" genre_dwds=\"".$genre_dwds."\" subgenre_dwds=\"".$subgenre_dwds."\" dta_collection=\"".$dtastatus[0]."\" dta_release=\"".$dtastatus[1]."\" dta_digitalization=\"".$dtastatus[2]."\">\n";

			undef @dtastatus;
			undef $genre_dta;
			undef $subgenre_dta;
			undef $genre_dwds;
			undef $subgenre_dwds;
			
			return;

		}
	
	
	}

}


# This little subroutine does the vrt magic. The comments represent its internal dialog

sub format_file {

	while (<>) {

# Yay, the input matches one of the word-level annotations...
	
		if ($_ =~ m/<(token|lemma|tag|correction) (tokenIDs|ID)=\"([^"]+)"[^\>]*>([^\<]+)<\/(token|lemma|tag|correction)>/) {

# ... so I must get the tag type (hash), the token ID (key) and the contents (value), and...
		
			$hash = $1;
	
			$key = $3;
	
			$value = $4;
	
# ... add the contents to the corresponding hash, using the token ID as a key. I'm being
# really clever here, creating (and later identifying identifying the appropriate hash
# by the hash name I have extracted from the word-level annotation; this means that a
# single subroutine will handle all word-level annotations, rather than sharing the work
# with three other subroutines that would be identical except for the name of the 
# annotation token and the corresponding name of the hash.
		
			$$hash{$key} = $value;
	
# Else, if the input matches a sentence ID, ...
			
		}elsif ($_ =~ m/<sentence ID=\"(s\S+)\" tokenIDs=\"([^"]+)\"\/>/) {
	
# ... I get the sentence ID, ...
			
			$sentenceID = $1;
	
# ... I get the list of token IDs in that sentence and turn them into an array @words
# (remember: arrays maintain the order of the input), ...
	
			@words = split(/ /,$2);
	
# ... I add an opening sentence tag with the sentence id to the master array (which, since
# you ask is an array that holds the information about the actual structure of the text, 
# i.e. the sequence of sentence tags and token ids), ...
	
			push(@master, "<s id=\"$sentenceID\">");
	
# ... I add the current words array to the master array, and clear it (important, since
# otherwise each subsequent sentence would simply be added to the words array, and thus
# sentences would be added to the master array multiple times),...
	
			push(@master,@words);
			
			undef @words;
			
# ... and finally I add a closing sentence tag:
	
			push(@master,"</s>");
	
# When I reach the end of the corpus section, I produce the output (the book in vrt
# format) and return to the main routine.

		}elsif ($_ =~ m/<\/TextCorpus>/) {

			foreach $element (@master) {

				if ($element =~ m/^</) {

					print $element."\n";

				}else{

					print "$token{$element}\t$correction{$element}\t$lemma{$element}\t$tag{$element}\t$element\n";

				}

			}
			#print "</text>\n";
			print "</file>\n";
	
			undef @master;

			return;
			
		}
	
	}

}

# This litte subroutine is never called upon.

sub praise_anatol {

	print "Hail thee, Anatol, Lord of the File Transformation.\n";
	print "I hail thee, Anatol, Lord of Excellent Script Documentation.\n";
	
	}