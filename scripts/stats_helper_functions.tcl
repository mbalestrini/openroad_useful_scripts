proc stats_placed_cells_count {} {
    set block [ord::get_db_block]

    set total_placed_cells 0

    if {[info exists cells_count]==1} {
        unset cells_count
    }
    foreach inst [get_cells] {
        set cell [get_name [$inst cell]]
        # puts $cell
        if {[array exists cells_count($cell)]==0} {
            set cells_count($cell) 0
        }
        if {[$block findInst [get_full_name $inst]]!="NULL" && [ [$block findInst [get_full_name $inst]] isPlaced ] == 1} {
            set cells_count($cell) [incr name($cell)]
            set total_placed_cells [incr total_placed_cells]
        }
    }
    set result_string ""
    foreach cell_name [lsort [array names cells_count]] {
        set result_string "$result_string[format %-30.30s $cell_name]:\t[expr $cells_count($cell_name)]\n"        
    }

    set result_string "$result_string TOTAL:\t[expr $total_placed_cells]\n"        

    
    
    return $result_string
}
