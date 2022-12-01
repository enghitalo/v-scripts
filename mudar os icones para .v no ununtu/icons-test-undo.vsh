#!/usr/bin/env -S v

execute("rm /usr/share/mime/packages/v.xml")
execute("rm /usr/share/mime/packages/x-v.xml")
execute("rm /usr/share/mime/packages/x-vlang.xml")

execute("sudo apt-get install --reinstall shared-mime-info")

execute("update-mime-database")
