#!/usr/bin/env -S v

execute("rm /usr/share/mime/packages/v.xml")

execute_or_exit("cp -R icons/Yaru/* /usr/share/icons/Yaru/")

execute_or_exit("cp -R icons/x-v.xml /usr/share/mime/packages/")

execute("rm /usr/share/mime/packages/vlang.xml")

execute_or_exit("update-mime-database /usr/share/mime")
execute("update-mime-database")

print(execute_or_exit("grep 'text/x-v' /etc/mime.types").output)

// nano /usr/share/mime/packages/freedesktop.org.xml 
// sudo apt-get install --reinstall shared-mime-info
// sudo update-mime-database