## This is a compilation of some useful [OpenROAD](https://github.com/The-OpenROAD-Project/OpenROAD) scripts I've been using for the GUI

---
### Setup 
- Clone the repository to some local folder (ej: /home/user/openroad_useful_scripts )
- Set the `OPENROAD_SCRIPTS_PATH` environment variable to the local [scripts/](scripts/) folder (ej: `~/export OPENROAD_SCRIPTS_PATH=/home/user/openroad_useful_scripts/scripts` )
- Copy and rename the file [openroad-home_folder_script](openroad-home_folder_script) to `~/.openroad`
- Launch `openroad -gui` 

---

### Info about startup script

When OpenROAD starts it tries to load the `.openroad` file in your home folder. 

The provided `openroad-home_folder_script` script will execute all the scripts in the `[OPENROAD_SCRIPTS_PATH]` when openroad GUI opens

Some scripts are helper functions and other are the scripts that create the menu items (using `create_menu_item`)

If you want to add another menu options you should add another file to the script folder with the script that add the new menu options. Ej:

```
create_menu_item  -path "Scripts/Load working dir" -text "Caravel results" -script {
	load_caravel_result
}	
```

You can read more about the OpenROAD create_menu_item function at https://openroad.readthedocs.io/en/latest/main/src/gui/README.html#add-items-to-the-menubar





