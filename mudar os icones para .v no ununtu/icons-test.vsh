#!/usr/bin/env -S v

import term { bold, green, red, yellow }

if !(execute('rm /usr/share/mime/packages/v.xml').exit_code == 0) {
	println(green("No such file or directory"))
} 

if !(execute_or_exit('sudo cp -R icons/Yaru/* /usr/share/icons/Yaru/').exit_code == 0) {
	println(red("was not possible copy `icons/Yaru` to `/usr/share/icons/Yaru/`"))
} 

if !(execute_or_exit('sudo cp -R icons/x-v.xml /usr/share/mime/packages/').exit_code == 0) {
	println(red("was not possible copy `icons/x-v.xml` to `/usr/share/mime/packages/`"))
} 

if !(execute('sudo rm /usr/share/mime/packages/vlang.xml').exit_code == 0) {
	println(yellow("was not possible remove the file `/usr/share/mime/packages/vlang.xml`"))
} 

if !(execute_or_exit('sudo update-mime-database /usr/share/mime').exit_code == 0) {
	println(red("was not possible run `update-mime-database /usr/share/mime`"))
} 

// // println(execute('sudo update-mime-database'))

// if !(execute('sudo update-mime-database').exit_code == 0) {
// 	println(red("can not update-mime-database"))
// } 

// 
text_x_v_types := execute_or_exit("grep 'text/x-v' /etc/mime.types").output
has_v_type_in_mime_type := text_x_v_types.contains("text/x-v                                        v vv vsh")
if !has_v_type_in_mime_type {
    println(red("There are not `text/x-v                                        v vv vsh` in /etc/mime.types file"))
    println(red("Try run `sudo nano /etc/mime.types` and edit the document"))
}else{
    println(text_x_v_types)
}

// sudo nano /etc/mime.types
// text/x-v                                        v vv vsh
// sudo nano /usr/share/mime/packages/freedesktop.org.xml // access and replace `text/x-verilog` for `text/x-v`
println(execute("grep 'text/x-v' /usr/share/mime/packages/freedesktop.org.xml").output)
// sudo apt-get install --reinstall shared-mime-info
// sudo update-mime-database
