create_menu_item  -path "Scripts/Stats" -text "Get placed cells count" -script {
    puts [stats_placed_cells_count]
    #gui::input_dialog "Placed cells count:" [stats_placed_cells_count]	
}	
