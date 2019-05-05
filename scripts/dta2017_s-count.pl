#!/usr/bin/perl

while(<>) {

	if ($_ =~ m/<file id=\"([^\"]+)\"/) {
	
		$fileid = $1;
		print $_;
		$subcount = 1;
		
	}elsif ($_ =~ m/<s id=\"(.*?)\">/){
	
		print "<s id=\"".$1."\" no=\"".$fileid."-".$subcount."\">\n";
		$subcount++;
		
	}else{
	
		print $_;

	}

}