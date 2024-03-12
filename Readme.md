***MongoDB-Backup

We have windows server for backup and we created network drive for the same.
First we have to run below command to mount your windows network drive in linux mahcine with /home/wittyticketing/backup directory.
     apt install cifs-utils -y
     sudo mount.cifs //remote-machine-ip/network-dir-name /home/test -o username=abc,password=abc@123,uid=$(id -u),gid=$(id -g)
if successfully mounted then run command given below to check that mounted correctly. 
      df -h
Create a directory for local path also, in local path first data backup in local path then copy in mounted path which was mounted with our windows machine, after this process local path files remove after successfully copied.