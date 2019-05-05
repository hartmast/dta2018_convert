#!/usr/bin/perl

while (<>) {
	if ($_ =~ m/^<file.*/) {
	
	# is:
	# < year="1675" year_pub="1675" year_creat="" 

		if ($_ =~ m/year="\d{4}"/) {
		
            s@year="(141\d)"@year="$1" century="15" decade="1410"@gi;
            s@year="(142\d)"@year="$1" century="15" decade="1420"@gi;
            s@year="(143\d)"@year="$1" century="15" decade="1430"@gi;
            s@year="(144\d)"@year="$1" century="15" decade="1440"@gi;
            s@year="(145\d)"@year="$1" century="15" decade="1450"@gi;
            s@year="(146\d)"@year="$1" century="15" decade="1460"@gi;
			s@year="(147\d)"@year="$1" century="15" decade="1470"@gi;
			s@year="(148\d)"@year="$1" century="15" decade="1480"@gi;
			s@year="(149\d)"@year="$1" century="15" decade="1490"@gi;
			s@year="(150\d)"@year="$1" century="16" decade="1500"@gi;
			s@year="(151\d)"@year="$1" century="16" decade="1510"@gi;
			s@year="(152\d)"@year="$1" century="16" decade="1520"@gi;
			s@year="(153\d)"@year="$1" century="16" decade="1530"@gi;
			s@year="(154\d)"@year="$1" century="16" decade="1540"@gi;
			s@year="(155\d)"@year="$1" century="16" decade="1550"@gi;
			s@year="(156\d)"@year="$1" century="16" decade="1560"@gi;
			s@year="(157\d)"@year="$1" century="16" decade="1570"@gi;
			s@year="(158\d)"@year="$1" century="16" decade="1580"@gi;
			s@year="(159\d)"@year="$1" century="16" decade="1590"@gi;
			s@year="(160\d)"@year="$1" century="17" decade="1600"@gi;
			s@year="(161\d)"@year="$1" century="17" decade="1610"@gi;
			s@year="(162\d)"@year="$1" century="17" decade="1620"@gi;
			s@year="(163\d)"@year="$1" century="17" decade="1630"@gi;
			s@year="(164\d)"@year="$1" century="17" decade="1640"@gi;
			s@year="(165\d)"@year="$1" century="17" decade="1650"@gi;
			s@year="(166\d)"@year="$1" century="17" decade="1660"@gi;
			s@year="(167\d)"@year="$1" century="17" decade="1670"@gi;
			s@year="(168\d)"@year="$1" century="17" decade="1680"@gi;
			s@year="(169\d)"@year="$1" century="17" decade="1690"@gi;
			s@year="(170\d)"@year="$1" century="18" decade="1700"@gi;
			s@year="(171\d)"@year="$1" century="18" decade="1710"@gi;
			s@year="(172\d)"@year="$1" century="18" decade="1720"@gi;
			s@year="(173\d)"@year="$1" century="18" decade="1730"@gi;
			s@year="(174\d)"@year="$1" century="18" decade="1740"@gi;
			s@year="(175\d)"@year="$1" century="18" decade="1750"@gi;
			s@year="(176\d)"@year="$1" century="18" decade="1760"@gi;
			s@year="(177\d)"@year="$1" century="18" decade="1770"@gi;
			s@year="(178\d)"@year="$1" century="18" decade="1780"@gi;
			s@year="(179\d)"@year="$1" century="18" decade="1790"@gi;
			s@year="(180\d)"@year="$1" century="19" decade="1800"@gi;
			s@year="(181\d)"@year="$1" century="19" decade="1810"@gi;
			s@year="(182\d)"@year="$1" century="19" decade="1820"@gi;
			s@year="(183\d)"@year="$1" century="19" decade="1830"@gi;
			s@year="(184\d)"@year="$1" century="19" decade="1840"@gi;
			s@year="(185\d)"@year="$1" century="19" decade="1850"@gi;
			s@year="(186\d)"@year="$1" century="19" decade="1860"@gi;
			s@year="(187\d)"@year="$1" century="19" decade="1870"@gi;
			s@year="(188\d)"@year="$1" century="19" decade="1880"@gi;
			s@year="(189\d)"@year="$1" century="19" decade="1890"@gi;
			s@year="(190\d)"@year="$1" century="20" decade="1900"@gi;
			s@year="(191\d)"@year="$1" century="20" decade="1910"@gi;
			s@year="(192\d)"@year="$1" century="20" decade="1920"@gi;
			s@year="(193\d)"@year="$1" century="20" decade="1930"@gi;
			s@year="(194\d)"@year="$1" century="20" decade="1940"@gi;
			s@year="(195\d)"@year="$1" century="20" decade="1950"@gi;
			s@year="(196\d)"@year="$1" century="20" decade="1960"@gi;

	
			print $_;
			
		} elsif ($_ =~ m/year="\d{0,4}\[\d+\]"/) {
			
			s@year="(\d{0,4})\[(147\d)]"@year="$1\[$2\]" century="15" decade="1470"@gi;
			s@year="(\d{0,4})\[(148\d)]"@year="$1\[$2\]" century="15" decade="1480"@gi;
			s@year="(\d{0,4})\[(149\d)]"@year="$1\[$2\]" century="15" decade="1490"@gi;
			s@year="(\d{0,4})\[(150\d)]"@year="$1\[$2\]" century="16" decade="1500"@gi;
			s@year="(\d{0,4})\[(151\d)]"@year="$1\[$2\]" century="16" decade="1510"@gi;
			s@year="(\d{0,4})\[(152\d)]"@year="$1\[$2\]" century="16" decade="1520"@gi;
			s@year="(\d{0,4})\[(153\d)]"@year="$1\[$2\]" century="16" decade="1530"@gi;
			s@year="(\d{0,4})\[(154\d)]"@year="$1\[$2\]" century="16" decade="1540"@gi;
			s@year="(\d{0,4})\[(155\d)]"@year="$1\[$2\]" century="16" decade="1550"@gi;
			s@year="(\d{0,4})\[(156\d)]"@year="$1\[$2\]" century="16" decade="1560"@gi;
			s@year="(\d{0,4})\[(157\d)]"@year="$1\[$2\]" century="16" decade="1570"@gi;
			s@year="(\d{0,4})\[(158\d)]"@year="$1\[$2\]" century="16" decade="1580"@gi;
			s@year="(\d{0,4})\[(159\d)]"@year="$1\[$2\]" century="16" decade="1590"@gi;
			s@year="(\d{0,4})\[(160\d)]"@year="$1\[$2\]" century="17" decade="1600"@gi;
			s@year="(\d{0,4})\[(161\d)]"@year="$1\[$2\]" century="17" decade="1610"@gi;
			s@year="(\d{0,4})\[(162\d)]"@year="$1\[$2\]" century="17" decade="1620"@gi;
			s@year="(\d{0,4})\[(163\d)]"@year="$1\[$2\]" century="17" decade="1630"@gi;
			s@year="(\d{0,4})\[(164\d)]"@year="$1\[$2\]" century="17" decade="1640"@gi;
			s@year="(\d{0,4})\[(165\d)]"@year="$1\[$2\]" century="17" decade="1650"@gi;
			s@year="(\d{0,4})\[(166\d)]"@year="$1\[$2\]" century="17" decade="1660"@gi;
			s@year="(\d{0,4})\[(167\d)]"@year="$1\[$2\]" century="17" decade="1670"@gi;
			s@year="(\d{0,4})\[(168\d)]"@year="$1\[$2\]" century="17" decade="1680"@gi;
			s@year="(\d{0,4})\[(169\d)]"@year="$1\[$2\]" century="17" decade="1690"@gi;
			s@year="(\d{0,4})\[(170\d)]"@year="$1\[$2\]" century="18" decade="1700"@gi;
			s@year="(\d{0,4})\[(171\d)]"@year="$1\[$2\]" century="18" decade="1710"@gi;
			s@year="(\d{0,4})\[(172\d)]"@year="$1\[$2\]" century="18" decade="1720"@gi;
			s@year="(\d{0,4})\[(173\d)]"@year="$1\[$2\]" century="18" decade="1730"@gi;
			s@year="(\d{0,4})\[(174\d)]"@year="$1\[$2\]" century="18" decade="1740"@gi;
			s@year="(\d{0,4})\[(175\d)]"@year="$1\[$2\]" century="18" decade="1750"@gi;
			s@year="(\d{0,4})\[(176\d)]"@year="$1\[$2\]" century="18" decade="1760"@gi;
			s@year="(\d{0,4})\[(177\d)]"@year="$1\[$2\]" century="18" decade="1770"@gi;
			s@year="(\d{0,4})\[(178\d)]"@year="$1\[$2\]" century="18" decade="1780"@gi;
			s@year="(\d{0,4})\[(179\d)]"@year="$1\[$2\]" century="18" decade="1790"@gi;
			s@year="(\d{0,4})\[(180\d)]"@year="$1\[$2\]" century="19" decade="1800"@gi;
			s@year="(\d{0,4})\[(181\d)]"@year="$1\[$2\]" century="19" decade="1810"@gi;
			s@year="(\d{0,4})\[(182\d)]"@year="$1\[$2\]" century="19" decade="1820"@gi;
			s@year="(\d{0,4})\[(183\d)]"@year="$1\[$2\]" century="19" decade="1830"@gi;
			s@year="(\d{0,4})\[(184\d)]"@year="$1\[$2\]" century="19" decade="1840"@gi;
			s@year="(\d{0,4})\[(185\d)]"@year="$1\[$2\]" century="19" decade="1850"@gi;
			s@year="(\d{0,4})\[(186\d)]"@year="$1\[$2\]" century="19" decade="1860"@gi;
			s@year="(\d{0,4})\[(187\d)]"@year="$1\[$2\]" century="19" decade="1870"@gi;
			s@year="(\d{0,4})\[(188\d)]"@year="$1\[$2\]" century="19" decade="1880"@gi;
			s@year="(\d{0,4})\[(189\d)]"@year="$1\[$2\]" century="19" decade="1890"@gi;
			s@year="(\d{0,4})\[(190\d)]"@year="$1\[$2\]" century="20" decade="1900"@gi;
			s@year="(\d{0,4})\[(191\d)]"@year="$1\[$2\]" century="20" decade="1910"@gi;
			s@year="(\d{0,4})\[(192\d)]"@year="$1\[$2\]" century="20" decade="1920"@gi;
			s@year="(\d{0,4})\[(193\d)]"@year="$1\[$2\]" century="20" decade="1930"@gi;
			s@year="(\d{0,4})\[(194\d)]"@year="$1\[$2\]" century="20" decade="1940"@gi;
			s@year="(\d{0,4})\[(195\d)]"@year="$1\[$2\]" century="20" decade="1950"@gi;
			s@year="(\d{0,4})\[(196\d)]"@year="$1\[$2\]" century="20" decade="1960"@gi;
			
			print $_;
		}
		
	} else {
	
		print $_;
	}
}

