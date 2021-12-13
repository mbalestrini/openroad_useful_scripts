proc load_liberty_tech {} {
	# LIB files 
	set libs [glob $::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/lib/*.lib]
	puts "LIB files available"
	set lib_options ""
	set i 0
	foreach lib_file $libs {
		set fbasename [file rootname [file tail $lib_file]]
		if {$fbasename=="sky130_fd_sc_hd__tt_025C_1v80"} {
			set default_index $i
			set fbasename "$fbasename (default)"
		}
		set lib_options "$lib_options$i: $fbasename\n"
		puts "\t$lib_file"
		incr i
		#read_def $lib_file
	}

	set selection [gui::input_dialog "Choose LIB file to load" $lib_options]
	if {$selection==""} {
		set selection $default_index
	}
	puts "Loading liberty file [lindex $libs $selection]"
	read_liberty [lindex $libs $selection]
}


proc load_tech_files { {merged 1}} {
    set STD_CELL_LIBRARY sky130_fd_sc_hd

	if {$merged} {
		puts "Loading Technology files (merged)"

		set merged_lef_path "/tmp/_readtechlef_merged.lef"
		set arguments { $::env(OPENLANE_ROOT)/scripts/mergeLef.py -i $::env(PDK_ROOT)/sky130A/libs.ref/$STD_CELL_LIBRARY/techlef/$STD_CELL_LIBRARY.tlef [glob $::env(PDK_ROOT)/sky130A/libs.ref/$STD_CELL_LIBRARY/lef/*.lef] -o $merged_lef_path }
		
		if { [catch { exec python3 $arguments } msg] } {
		puts "Error running merge command\npython3 $arguments"
		puts "Information about it: $::errorInfo"
		}
		read_lef $merged_lef_path
	} else {
		puts "Loading Technology files (unmerged)"

		read_lef -tech $::env(PDK_ROOT)/sky130A/libs.ref/$STD_CELL_LIBRARY/techlef/$STD_CELL_LIBRARY.tlef
		# read_lef $::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd.tlef
		set lefs [glob $::env(PDK_ROOT)/sky130A/libs.ref/$STD_CELL_LIBRARY/lef/*.lef]
		foreach lef_file $lefs {
			read_lef $lef_file
		}	
	}

	puts "Load of Technology files done"

}

proc load_caravel_result {} {
	set project_name [file rootname [file tail [pwd]]]
	

	puts "Loading tech LEF file $::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd.tlef"
	read_lef -tech $::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd.tlef
	#read_lef $::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hvl/techlef/sky130_fd_sc_hvl.tlef
	

	#puts "Read project merged_unpadded.lef"
	#read_lef ./results/magic/merged_unpadded.lef
	set lefs [glob $::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/lef/*.lef]
	foreach lef_file $lefs {
		read_lef $lef_file
	}	

	set lefs [glob $::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_pr/lef/*.lef]
	foreach lef_file $lefs {
		read_lef $lef_file
	}	

	set lefs [glob $::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_io/lef/*.lef]
	foreach lef_file $lefs {
		read_lef $lef_file
	}	



	set lefs [glob ./lef/*.lef]
	foreach lef_file $lefs {
		read_lef $lef_file
	}	


	#DEF Files
	set defs [glob ./def/*.def]
	puts "DEF files available"
	set def_options ""
	set i 0
	foreach def_file $defs {
		set fbasename [file rootname [file tail $def_file]]
		if {$fbasename=="sky130_fd_sc_hd__tt_025C_1v80"} {
			set default_index $i
			set fbasename "$fbasename (default)"
		}
		set def_options "$def_options$i: $fbasename\n"
		puts "\t$def_file"
		incr i
		#read_def $def_file
	}

	set selection [gui::input_dialog "Choose DEF file to load" $def_options]
	if {$selection==""} {
		set selection $default_index
	}
	puts "Loading DEF file [lindex $defs $selection]"
	read_def [lindex $defs $selection]		
	set design_name [file rootname [file tail [lindex $defs $selection]]]


	load_tech_files


}

proc load_openlane_result {} {
	set project_name [file rootname [file tail [glob "./results/magic/*.gds"]]]
	

	puts "Loading tech LEF file $::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd.tlef"
	read_lef -tech $::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd.tlef
	

	puts "Read project merged_unpadded.lef"
	read_lef ./results/magic/merged_unpadded.lef
	
	# Project LEF
	set lef_file ./results/magic/$project_name.lef
	puts "Loading project lef file $lef_file"
	read_lef $lef_file 


	# Project DEF
	set def_file [glob "./results/routing/*.def"]
	puts "Loading project DEF file $def_file"
	read_def $def_file

	# LIB files 
	set libs [glob $::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/lib/*.lib]
	puts "LIB files available"
	set lib_options ""
	set i 0
	foreach lib_file $libs {
		set fbasename [file rootname [file tail $lib_file]]
		if {$fbasename=="sky130_fd_sc_hd__tt_025C_1v80"} {
			set default_index $i
			set fbasename "$fbasename (default)"
		}
		set lib_options "$lib_options$i: $fbasename\n"
		puts "\t$lib_file"
		incr i
		#read_def $lib_file
	}

	set selection [gui::input_dialog "Choose LIB file to load" $lib_options]
	if {$selection==""} {
		set selection $default_index
	}
	puts "Loading liberty file [lindex $libs $selection]"
	read_liberty [lindex $libs $selection]


	# Project SPEF
	set spef_file [glob "./results/routing/*.spef"]
	puts "Loading project SPEF file $spef_file"
	read_spef $spef_file

	# Project SDC
	set sdc_file [glob "./results/cts/*.sdc"]
	puts "Loading project SDC file $sdc_file"
	read_sdc $sdc_file
}


proc load_intermediate_openlane_result {} {
	
	

	set def_files []
	puts "DEF files available"
	set def_options_str ""	
	set i 0
	
	# FLOORPLAN DEF files
	set def_options_str "$def_options_str\FLOORPLAN\n"
	set defs [glob ./tmp/floorplan/*.def]
	foreach def_file $defs {
		set fbasename [file rootname [file tail $def_file]]
		set def_options_str "$def_options_str$i: $fbasename\n"
		lappend def_files $def_file
		puts "\t$def_file"
		incr i
	}
	set def_options_str "$def_options_str\n"
	# PLACEMENT DEF files
	set def_options_str "$def_options_str\PLACEMENT\n"
	set defs [glob ./tmp/placement/*.def]
	foreach def_file $defs {
		set fbasename [file rootname [file tail $def_file]]
		set def_options_str "$def_options_str$i: $fbasename\n"
		lappend def_files $def_file
		puts "\t$def_file"
		incr i
	}
	set def_options_str "$def_options_str\n"
	# ROUTING DEF files
	set def_options_str "$def_options_str\ROUTING\n"
	set defs [glob ./tmp/routing/*.def]
	foreach def_file $defs {
		set fbasename [file rootname [file tail $def_file]]
		set def_options_str "$def_options_str$i: $fbasename\n"
		lappend def_files $def_file
		puts "\t$def_file"
		incr i
	}
	set def_options_str "$def_options_str\n"


	set selection [gui::input_dialog "Choose DEF file to load" $def_options_str]
	if {$selection==""} {
		set selection $default_index
	}


	# LIB files
	load_liberty_tech

	# LEF files
	puts "Read project merged_unpadded.lef"
	read_lef ./results/magic/merged_unpadded.lef
	

	# DEF
	puts "Loading DEF file [lindex $def_files $selection]"
	read_def [lindex $def_files $selection]	


	# # Project DEF
	# set def_file [glob "./results/routing/*.def"]
	# puts "Loading project DEF file $def_file"
	# read_def $def_file



}

