#!/usr/bin/perl

while(<>) {

	if ($_ =~ m/^(<file id=|<s id|<\/file>|<\/s>)/) {
	
		s/year="(\d{4})\[\]"/year="$1"/gi;
		
		print $_;
		
	}elsif ($_ =~ m/^<.*/){
	
		s/^</&lt;/gi;
		
		print $_;
	
	}else{
	
		print $_;

	}

}