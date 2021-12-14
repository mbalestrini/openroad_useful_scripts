create_menu_item  -path "Scripts/Tests" -text "Highlight _clk cells" -script {
    foreach inst [get_cells] {
        set cell [get_name [$inst cell]]
        if {[string first "_clk" $cell] != -1} {
            gui::highlight_inst [get_full_name $inst] 1
        }
    }
}	

create_menu_item  -path "Scripts/Tests" -text "Highlight _df cells" -script {   
   foreach inst [get_cells] {
        set cell [get_name [$inst cell]]
        if {[string first "_df" $cell] != -1} {
            #select -type Inst -name $cell
            gui::highlight_inst [get_full_name $inst] 0
        }
    }
}	

create_menu_item  -path "Scripts/Tests" -text "Highlight _mux cells" -script {   
    foreach inst [get_cells] {
        set cell [get_name [$inst cell]]
        if {[string first "_mux" $cell] != -1} {
            #select -type Inst -name $cell
            gui::highlight_inst [get_full_name $inst] 3
        }
    }
}	

create_menu_item  -path "Scripts/Tests" -text "Unplace fills, taps, diode, etc" -script {   
    set current_block [ord::get_db_block]

    foreach c [get_cells FILLER*] {
        set inst [$current_block findInst [get_full_name $c]]
        $inst setPlacementStatus UNPLACED
    }

    foreach c [get_cells ANTENNA*] {
        set inst [$current_block findInst [get_full_name $c]]
        $inst setPlacementStatus UNPLACED
    }


    foreach c [get_cells TAP*] {
        set inst [$current_block findInst [get_full_name $c]]
        $inst setPlacementStatus UNPLACED
    }


    foreach c [get_cells PHY*] {
        set inst [$current_block findInst [get_full_name $c]]
        $inst setPlacementStatus UNPLACED
    }
}	

create_menu_item  -path "Scripts/Tests" -text "Select connected instances" -script {   

 # SELECT CONNECTED INSTANCES
    set current_block [ord::get_db_block]
    set inst [$current_block findInst [gui::get_selection_property Name ]]
    foreach term [$inst getITerms] {
        set net [$term getNet]
        set net_name [$net getName]
            

        if {$net_name!="VGND" && $net_name!="VPWR" && $net_name!="VNB" && $net_name!="VPB" && [$term getIoType]!="INOUT"} {

            puts [[$term getMTerm] getName] 
            #$term getIoType 
            #$term getNet
            puts "Net: $net_name"
            # puts "Capacitance: [$net getTotalCapacitance]"
            #$net getITerms

            # Select NET
            # select -type Net -name $net_name
            gui::highlight_net $net_name 2

            foreach connected_term [$net getITerms] {
                puts [$connected_term getIoType]
                puts [[$connected_term getMTerm] getName]
                puts [[$connected_term getInst] getName]
                select -type Inst -name [[$connected_term getInst] getName]
                gui::highlight_inst [[$connected_term getInst] getName] 1

            }
        }
    }
}