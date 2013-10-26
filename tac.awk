#!/usr/bin/awk -f
	{ lines[NR] = $0 }
	END {
		for (line=NR;line>=1;line--)
			print lines[line]
	}
