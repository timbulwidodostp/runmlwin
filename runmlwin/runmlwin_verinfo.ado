program runmlwin_verinfo, rclass
	version 9.0
	syntax [anything] [, *]

	tempname ver1
	tempname ver2
	tempname ver3
	tempname ver4

	scalar `ver1' = .
	scalar `ver2' = .
	scalar `ver3' = .
	scalar `ver4' = .

	capture plugin call runmlwin_getversion, `"`anything'"' "`ver1'" "`ver2'" "`ver3'" "`ver4'"
	if c(rc) == 199 {
		display as error "Warning: getversion plugin could not be loaded"
		tempfile verinfo
		shell "`anything'" --version > "`verinfo'"
		file open f using "`verinfo'", read
		file read f version
		file close f
		local pos = strpos("`version'", ".")
		local ver1 = substr("`version'", 1, `=`pos'-1')
		local ver2 = substr("`version'", `=`pos'+1', .)
		local ver3 = 0
		local ver4 = 0
	}
	display as text "Version: " `ver1' as text "." `ver2' as text "." `ver3' as text "." `ver4'
	
	return clear
	return scalar ver1 = `ver1'
	return scalar ver2 = `ver2'
	return scalar ver3 = `ver3'
	return scalar ver4 = `ver4'
end

capture program runmlwin_getversion, plugin

******************************************************************************
exit
