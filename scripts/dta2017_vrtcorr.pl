while (<>) {

	if ($_ =~ m/^(\S+)\t(\S*)\t(\S+)\t(\S+)\t(\S+)$/) {
	
		$orig = $1;
		$corr = $2;
		$lemm = $3;
		$post = $4;
		$tkid = $5;
		
		if ($corr eq "") {
		
			$corr = $orig;
			
			}
			
		print $orig."\t".$corr."\t".$lemm."\t".$post."\t".$tkid."\n";
		
	}else{
	
		print $_;
		
	}
	
}

# ....

