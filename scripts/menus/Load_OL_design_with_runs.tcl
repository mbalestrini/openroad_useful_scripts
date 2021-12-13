set fileId [open "/tmp/.openroad_dynamic_menu" "w"]


# Openlane Designs Menu
set designs [glob $::env(OPENLANE_ROOT)/designs/*]
# # set def_options ""
set i 0
foreach design_path $designs {
	set design_name [file rootname [file tail $design_path]]		

	set run_dir $design_path/runs
	if [file exists $run_dir] {
		

		set line "create_menu_item -path \"Scripts/Load Openlane Design (with runs)\" -text $design_name -script { 
			puts \"Load $design_name \" 
			
			set runs \[glob $design_path/runs/*\]
			puts \"runs available\"
			set run_options \"\"
			set i 0
			foreach run_path \$runs {
				set run_name \[file tail \$run_path]\]
				if {\$i==0} {
					set default_index \$i
					set run_name \"\$run_name (default)\"
				}
				set run_options \"\$run_options\$i: \$run_name\n\"
				puts \"\t\$run_path\"
				incr i
			}

			set selection \[gui::input_dialog \"Choose RUN to load\" \$run_options\]
			if {\$selection==\"\"} {
				set selection \$default_index
			}
			puts \"Loading run \[lindex \$runs \$selection\]\"
			cd \[lindex \$runs \$selection\]

			load_openlane_result

		}"

		#puts -nonewline $fileId $data		
		puts $fileId $line

		incr i			
	}
}

close $fileId

source "/tmp/.openroad_dynamic_menu"