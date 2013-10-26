#!/usr/bin/awk -f
	function rev_recursive(text)
	{
		if (length(text)==0)
			return ""
		else
			return substr(text, length(text),1) rev_recursive(substr(text,1,length(text)-1))
	}

	function rev_simple(text,  i, str_rev)
	{
		for (i=length(text);i>0;i--)
			str_rev = str_rev substr(text,i,1)
		return str_rev
	}
