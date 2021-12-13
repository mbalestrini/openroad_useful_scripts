## This is a compilation of some useful [OpenROAD](https://github.com/The-OpenROAD-Project/OpenROAD) scripts I've been using for the GUI

### Environment
The environment variable: `OPENROAD_SCRIPTS_PATH` should point to the repository's [scripts](scripts/) folder

### Startup script
When OpenROAD starts it tries to load the `.openroad` file in your home folder. 
You should copy and rename the file [openroad-home_folder_script](openroad-home_folder_script) to `~/.openroad`

This startup script will execute all the scripts in the `[OPENROAD_SCRIPTS_PATH]` when openroad GUI opens

Some are helper functions and other are the scripts that create the menu items (using `create_menu_item`)





