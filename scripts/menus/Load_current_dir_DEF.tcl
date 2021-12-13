create_menu_item  -path "Scripts/Load working dir" -text "DEF file" -script {
	#DEF Files
	set defs [glob *.def]
	puts "DEF files available"
	set def_options ""
	set i 0
	foreach def_file $defs {
		set fbasename [file rootname [file tail $def_file]]
		set def_options "$def_options$i: $fbasename\n"
		puts "\t$def_file"
		incr i
	}

	set selection [gui::input_dialog "Choose DEF file to load" $def_options]
	if {$selection==""} {
		set selection $default_index
	}
	puts "Loading DEF file [lindex $defs $selection]"
	read_def [lindex $defs $selection]		
}